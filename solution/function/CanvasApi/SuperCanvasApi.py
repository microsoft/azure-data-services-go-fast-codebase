# 'JsonHmacAPI' implements the HttpApi Protocol and includes helpers for authenticating using a HMAC token
# Using Asynchronous I/O via aiohttp
# Brodie Hicks, 2021.
# Leo Bravo 2022 workaround the finding of super class in a single

import hmac
import base64
import datetime
import aiohttp

from abc import abstractmethod

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)))
sys.path.append(__file__)

import hashlib

class SuperCanvasApi():
    Encoding: str = "utf-8" # Encoding for HMAC

    ApiKey: str
    ApiSecret: str
    HmacDigest: any # Any to allow for strings, constructors or modules (e.g. 'sha256' vs hashlib.sha256)
    Scheme: str = "https"
    Host: str
    Session: aiohttp.ClientSession

    def __init__(self, apiKey, apiSecret, encoding="utf-8", hmacDigest=hashlib.sha256):
        self.Host = "portal.inshosteddata.com"

        self.ApiKey = apiKey
        self.ApiSecret = apiSecret
        self.Encoding = encoding
        self.HmacDigest = hmacDigest

    async def __aenter__(self):
        self.Session = aiohttp.ClientSession()

    async def __aexit__(self, exc_type, exc, tb):
        await self.Session.close()

 
    def _get_hash_message(self, method, path, headers, content) -> str:
        """
        Generates a HMAC token for Canvas Data as per:
        https://portal.inshosteddata.com/docs/api
        """
        query = ""
        if "?" in path:
            [path, query] = path.split("?", 1)
            # Query args needed to be sorted
            query = "&".join(sorted(query.split("&")))

        return "\n".join([
            method.upper(),
            headers["Host"],
            headers["Content-Type"] if "Content-Type" in headers else "",
            hashlib.md5(content).digest().decode(self.Encoding) if content else "",
            path,
            query,
            headers["Date"],
            self.ApiSecret
        ])

    def _get_auth_token(self, method, path, headers, content) -> str:
        """
        Gets the HMAC authorization token for a given request
        """
        msg = self._get_hash_message(method, path, headers, content)
        hmacObj = hmac.new(bytes(self.ApiSecret, self.Encoding), bytes(msg, self.Encoding), digestmod=self.HmacDigest)

        return base64.b64encode(hmacObj.digest()).decode(self.Encoding)

    def _get_utc_date_header(self) -> str:
        """
        Gets the current date/time in RFC 7321 format.
        """
        return datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')

    async def get_response(self, path):
        """
        Performs a HTTP GET request and returns the raw request response for further manipulation.
        """
        headers = {
            "Date": self._get_utc_date_header(),
            "Host": self.Host
        }
        headers["Authorization"] = f"HMACAuth {self.ApiKey}:{self._get_auth_token('GET', path, headers, content=None)}"

        response = await self.Session.get(f"{self.Scheme}://{self.Host}/{path.lstrip('/')}", headers=headers)
        response.raise_for_status()
        return response

    async def get(self, path):
        """
        Performs a HTTP GET request using HMAC Auth and returns the parsed JSON response
        """
        async with await self.get_response(path) as response:
            return await response.json()



    async def get_schema_version_response(self, version: str):
        """
        Helper to get schema version.
        We create a separate method for this to decouple query path from the output in our activity functions
        (e.g. - if the API endpoint changes we only have to update this func.)
        """
        return await self.get_response(f"/api/schema/{version}")

    async def get_sync_list(self):
        """
        Helper to get synchronisation list from Canvas
        As above - we create a separate method for this to de-couple the API endpoint from our activity function logic.
        """
        return await self.get("/api/account/self/file/sync")
    