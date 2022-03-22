using System.Collections.Generic;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApplication.Services;

namespace WebApplication.Pages
{
    public class ClaimsModel : PageModel
    {
        public IList<string> Roles { get; set; }
        protected ISecurityAccessProvider SecProvider { get; }

        public ClaimsIdentity Claims { get; set; }

        public ClaimsModel(ISecurityAccessProvider secProvider)
        {
            SecProvider = secProvider;
          
        }

        public void OnGet()
        {
            Roles = SecProvider.GetUserGlobalRoles(HttpContext.User.Identity as ClaimsIdentity);
            Claims = HttpContext.User.Identity as ClaimsIdentity;
        }
    }
}
