using Humanizer;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using System;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Threading.Tasks;
using WebApplication.Services;

namespace WebApplication.Controllers
{
    public class BaseController : Controller
    {
        protected readonly ISecurityAccessProvider _securityAccessProvider;
        private readonly IEntityRoleProvider _roleProvider;

        protected string Name = "Base";

        public BaseController(ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider)
        {
            Name = GetType().Name.Replace("Controller", string.Empty);
            _securityAccessProvider = securityAccessProvider;
            _roleProvider = roleProvider;
        }

        protected string[] GetUserAdGroups()
        {
            return _securityAccessProvider.GetUserGroups(User.Identity as ClaimsIdentity);
        }

        protected Guid[] GetUserAdGroupUids()
        {
            return _securityAccessProvider.GetUserAdGroupIds(User.Identity as ClaimsIdentity);
        }

        protected string[] GetPermittedGroupsForCurrentAction([CallerMemberName] string actionName = null)
        {
            if (actionName is null)
                throw new ArgumentNullException(nameof(actionName));

            return _securityAccessProvider.GetRolesForAction(Name, actionName);
        }

        protected bool CanPerformCurrentActionGlobally([CallerMemberName] string actionName = null)
        {
            if (actionName is null)
                throw new ArgumentNullException(nameof(actionName));

            return _securityAccessProvider.CanPerformOperation(Name, actionName, User.Identity as ClaimsIdentity);
        }

        protected async Task<bool> CanPerformCurrentActionOnRecord(object record, [CallerMemberName] string actionName = null)
        {
            if (actionName is null)
                throw new ArgumentNullException(nameof(actionName));

            if (CanPerformCurrentActionGlobally(actionName))
                return true;

            var entityRoles = await _roleProvider.GetUserRoles(record, GetUserAdGroupUids());
            return _securityAccessProvider.CanPerformOperation(Name, actionName, entityRoles);
        }

        protected JArray GetSecurityFilteredActions(string actions)
        {
            var actionsList = actions.Split(",");
            JArray results = new JArray();
            foreach (var item in actionsList)
            {
                if (_securityAccessProvider.CanPerformOperation(Name, item, User.Identity as ClaimsIdentity))
                {
                    results.Add(item);
                }
            }
            return results;
        }

        protected void HumanizeColumns(JArray cols)
        {
            foreach (var col in cols)
            {
                var ob = (JObject)col;
                var name = ob.Property("name").Value.ToString();
                if (!string.IsNullOrEmpty(name))
                {
                    ob.Property("name").Value = name.Humanize(LetterCasing.Title);
                }
            }
        }

    }
}
