using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace WebApplication.Services
{
    public class DefaultHelpLinkActionFilter : ActionFilterAttribute
    {
        public override void OnResultExecuting(ResultExecutingContext context)
        {


            if (context.Controller is Controller)
            {
                var controller = context.Controller as Controller;

                string controllerAreaName = controller.RouteData.Values["controller"].ToString();
                string controllerActionName = controller.RouteData.Values["action"].ToString();

                controller.ViewBag.Helplink = new[]{
                    $"HelpFiles/{controllerAreaName}/{controllerActionName}.md",
                    $"HelpFiles/{controllerAreaName}.md"
                }.FirstOrDefault(System.IO.File.Exists);

            }

            base.OnResultExecuting(context);
        }

    }

}
