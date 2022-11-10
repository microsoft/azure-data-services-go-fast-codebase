using System.Globalization;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace SecureFileUploader.Portal.Web.Infrastructure;

internal class CustomDateTimeModelBinderProvider : IModelBinderProvider
{
    internal const DateTimeStyles SupportedStyles = DateTimeStyles.AdjustToUniversal | DateTimeStyles.AllowWhiteSpaces;

    public IModelBinder? GetBinder(ModelBinderProviderContext context)
    {
        if (context == null)
        {
            throw new ArgumentNullException(nameof(context));
        }

        var modelType = context.Metadata.UnderlyingOrModelType;
        if (modelType == typeof(DateTime))
        {
            var loggerFactory = context.Services.GetRequiredService<ILoggerFactory>();
            return new CustomDateTimeModelBinder(SupportedStyles, loggerFactory);
        }

        return null;
    }
}
