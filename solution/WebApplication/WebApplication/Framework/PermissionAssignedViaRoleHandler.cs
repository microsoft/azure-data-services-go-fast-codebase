using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Controllers;
using System.Reflection;
using System.Security.Claims;
using System.Threading.Tasks;
using WebApplication.Services;

namespace WebApplication.Framework
{
    public class PermissionAssignedViaRoleHandler : AuthorizationHandler<PermissionAssignedViaRole>
    {
        private readonly ISecurityAccessProvider _provider;

        public PermissionAssignedViaRoleHandler(ISecurityAccessProvider provider)
        {
            _provider = provider;
        }

        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, PermissionAssignedViaRole requirement)
        {
            if (context.Resource is Endpoint endpoint)
            {
                var actionDescriptor = endpoint.Metadata.GetMetadata<ControllerActionDescriptor>();

                if (_provider.CanPerformOperation(actionDescriptor.ControllerName, actionDescriptor.ActionName, ((ClaimsIdentity)context.User.Identity)))
                {
                    context.Succeed(requirement);
                }

                //method declares that it checks security itself
                if (actionDescriptor.MethodInfo.GetCustomAttribute<ChecksUserAccessAttribute>(inherit: true) != null)
                {
                    context.Succeed(requirement);
                }
            }

            return Task.CompletedTask;
        }

    }
}
