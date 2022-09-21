# Implements components of the v1 Canvas Data API (as v2 isn't out yet)

# LBravo 2022 same with bearer token


class CanvasDataApiToken(JsonHmacApi.JsonHmacApi):
    def __init__(self, token, encoding="utf-8", hmacDigest=hashlib.sha256):
        self.Host = "https://barker.instructure.com/api/v1/accounts/1/"
        self.Encoding = encoding
        self.HmacDigest = hmacDigest
        self.token = token

    def _get_token_call(self, method, path, headers, content) -> str:
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
                      path,
            query,
             '-H ',"'Authorization: Bearer '",
            self.token
        ])

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