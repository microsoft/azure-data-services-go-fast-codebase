using System;
using System.Security.Claims;

namespace WebApplication.Framework
{
    public static class ClaimsPrincipalExtension
    {

        /// <summary>
        /// iterates a bunch of common claims to load the username
        /// this is annoyingly because ADFS/AAD/AADB2C all use slightly different ways of doing this!
        /// </summary>
        /// <returns></returns>
        public static string GetUserName(this ClaimsPrincipal principal)
        {
            string value;
            if (principal.TryGetClaim("upn", out value))
                return value;
            if (principal.TryGetClaim("unique_name", out value))
                return value;
            if (principal.TryGetClaim("preferred_username", out value))
                return value;
            if (principal.TryGetClaim("email", out value))
                return value;

            throw new Exception("Could not find suitable claim to use for a upn");
        }


        public static bool TryGetClaim(this ClaimsPrincipal principal, string claim, out string value)
        {
            var c = principal.FindFirst(c => c.Type == claim);
            value = c?.Value;
            return c != null; 
        }
    }
}