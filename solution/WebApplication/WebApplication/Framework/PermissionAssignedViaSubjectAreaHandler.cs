using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Controllers;
using System.Linq;
using System.Data;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using WebApplication.Models;
using System.Reflection;
using WebApplication.Services;

namespace WebApplication.Framework
{
    public class PermissionAssignedViaControllerActionHandler : AuthorizationHandler<PermissionAssignedViaRole>
    {
        private readonly AdsGoFastContext _context;
        private readonly ISecurityAccessProvider _securityAccessProvider;

        public PermissionAssignedViaControllerActionHandler(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider)
        {
            _context = context;
            _securityAccessProvider = securityAccessProvider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, PermissionAssignedViaRole requirement)
        {

            if (!(context.Resource is Endpoint endpoint))
                return;

            var actionDescriptor = endpoint.Metadata.GetMetadata<ControllerActionDescriptor>();

            //method declares that it checks security itself
            if (actionDescriptor.MethodInfo.GetCustomAttribute<ChecksUserAccessAttribute>(inherit: true) == null)
                return;

            context.Succeed(requirement);
        }
    }
}

