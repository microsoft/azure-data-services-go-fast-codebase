using Microsoft.Identity.Web;
using SecureFileUploader.Data.Interfaces;

namespace SecureFileUploader.Portal.Web.Services;

public class RequestContext : IRequestContext
{

    public RequestContext(IHttpContextAccessor context)
    {
        // null checks help during EF migrate
        DisplayName = context?.HttpContext?.User?.GetDisplayName() ?? "LocalDev";
    }

    public string DisplayName { get; }
}
