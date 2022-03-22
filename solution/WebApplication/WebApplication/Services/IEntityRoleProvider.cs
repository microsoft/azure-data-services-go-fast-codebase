using System;
using System.Threading.Tasks;

namespace WebApplication.Services
{
    public interface IEntityRoleProvider
    {
        Task<string[]> GetUserRoles(object entity, params Guid[] groups);
    }
}