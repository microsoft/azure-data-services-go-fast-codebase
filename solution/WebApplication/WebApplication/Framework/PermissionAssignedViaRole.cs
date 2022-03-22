using Microsoft.AspNetCore.Authorization;

namespace WebApplication
{
    public class PermissionAssignedViaRole : IAuthorizationRequirement
    {
        public PermissionAssignedViaRole()
        {

        }
    }
}