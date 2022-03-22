using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using WebApplication.Framework;
using WebApplication.Models.Options;

namespace WebApplication.Services
{
    public class SecurityAccessProvider : ISecurityAccessProvider
    {
        private readonly ILogger _logger;
        private readonly IOptions<SecurityModelOptions> _options;
        private const string WildCardString = "*";

        public SecurityAccessProvider(IOptions<SecurityModelOptions> options, ILogger<SecurityAccessProvider> logger)
        {
            _options = options;
            _logger = logger;
        }

        public bool CanPerformOperation(string controllerName, string actionName, ClaimsIdentity identity)
        {
            if (identity == null || !identity.IsAuthenticated)
                return false;
            
            var roles = GetUserGlobalRoles(identity);
            return CanPerformOperation(controllerName, actionName, roles);
        }

        public bool CanPerformOperation(string controllerName, string actionName, string[] roles)
        {
            //global deny actions to lock out scaffolded actions we don't want
            if (ContainsMatchToController(_options.Value.GlobalDenyActions, controllerName, actionName))
                return false;

            //check globally permitted actions
            if (ContainsMatchToController(_options.Value.GlobalAllowActions, controllerName, actionName))
                return true;

            if (roles == null || roles.Length < 1)
                return false;

            //check user's role permitted actions
            var roleAllowActions = roles
                .SelectMany(x =>
                    _options.Value.SecurityRoles.TryGetValue(x, out var role)
                        ? role.AllowActions
                        : Enumerable.Empty<string>())
                .ToArray();

            if (ContainsMatchToController(roleAllowActions, controllerName, actionName))
                return true;

            return false;
        }

        /// <summary>
        /// Returns a list of appliciation roles that are valid for the given action
        /// </summary>
        public string[] GetRolesForAction(string controllerName, string actionName)
        {
            //global deny actions to lock out scaffolded actions we don't want
            if (ContainsMatchToController(_options.Value.GlobalDenyActions, controllerName, actionName))
                return new string[0];

            //check globally permitted actions
            if (ContainsMatchToController(_options.Value.GlobalAllowActions, controllerName, actionName))
                return _options.Value.SecurityRoles.Keys.ToArray();

            //return specific roles permissable
            return _options.Value
                .SecurityRoles
                .Where(x => ContainsMatchToController(x.Value.AllowActions, controllerName, actionName))
                .Select(x => x.Key)
                .ToArray();
        }

        public string[] GetUserGroups(ClaimsIdentity identity)
        {
            return identity is null 
                ? (new string[0]) 
                : identity.Claims.Where(x => x.Type == "groups").Select(v => v.Value).ToArray();
        }

        public string[] GetUserRoles(ClaimsIdentity identity)
        {
            return identity is null
               ? (new string[0])
               : identity.Claims.Where(x => x.Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/role").Select(v => v.Value).ToArray();
        }

        public Guid[] GetUserAdGroupIds(ClaimsIdentity claimsIdentity)
        {
            //todo: probably need to resolve these using graph API in case it changes to group names
            return GetUserGroups(claimsIdentity).Choose(x => Guid.TryParse(x, out var g) ? g : (Guid?)null).ToArray();
        }

        public string[] GetUserGlobalRoles(ClaimsIdentity identity)
        {
            var groups = GetUserGroups(identity);
           
            //First Get Role Based on AD Groups attached to roles in app settings. This requires app has Graph group read priviledges 
            string[] roles = _options.Value.SecurityRoles.Where(x => groups.Any(a => a == x.Value.SecurityGroupId) || x.Value.UserOverideList.Contains(identity.Name)).Select(x => x.Key).ToArray();

            if (roles.Length == 0)
            {
                //Next Get Role based on App Roles
                roles = GetUserRoles(identity);
            }
            return roles;
        }

        private bool ContainsMatchToController(IEnumerable<string> actionsToMatch, string controllerName, string actionName)
        {
            return actionsToMatch
                .SelectMany(ExpandRoleActions)
                .Any(x => isMatchUsingWildCard(x.controller, controllerName) && isMatchUsingWildCard(x.action, actionName));

            bool isMatchUsingWildCard(string pattern, string target) =>
                pattern == WildCardString
                || pattern == target
                //possibly better to switch this to regex parsing but this is nice and simple 
                || (pattern.EndsWith(WildCardString) && target.StartsWith(pattern.Substring(0, pattern.Length - WildCardString.Length)));
        }

        /// <summary>
        /// This 
        /// </summary>
        /// <param name="permission"></param>
        /// <returns></returns>
        private IEnumerable<(string controller, string action)> ExpandRoleActions(string permission)
        {
            if (permission is null)
                throw new System.ArgumentNullException(nameof(permission));

            var s = permission.Split(".");

            //effectively Controller.*
            if (s.Length == 1)
                return new (string controller, string action)[] { (permission, WildCardString) };

            //got an action, check if it's a placeholder and expand out the actions list
            if (s[1] == "_Reader")
                return _options.Value.ReaderActions.Select(x => (s[0], x));

            if (s[1] == "_Writer")
                return _options.Value.WriterActions.Select(x => (s[0], x));

            return new (string controller, string action)[] { (controller: s[0], action: s[1]) };
        }

    }
}
