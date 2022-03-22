using System;
using System.Security.Claims;

namespace WebApplication.Services
{
    public interface ISecurityAccessProvider
    {
        string[] GetRolesForAction(string controllerName, string actionName);
        string[] GetUserGroups(ClaimsIdentity identity);
        bool CanPerformOperation(string name, string actionname, string[] roles);
        bool CanPerformOperation(string controllerName, string actionName, ClaimsIdentity identity);
        string[] GetUserGlobalRoles(ClaimsIdentity identity);
        Guid[] GetUserAdGroupIds(ClaimsIdentity claimsIdentity);
    }
}