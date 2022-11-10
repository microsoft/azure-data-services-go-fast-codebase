using System.Globalization;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ModelBinding.Binders;

namespace SecureFileUploader.Portal.Web.Infrastructure;

/// <summary>
/// A custom model binder that ensures that all date time values passed to the API are <see cref="DateTimeKind.Utc"/>.
/// </summary>
/// <remarks>
/// Date time values with the Kind <see cref="DateTimeKind.Unspecified"/> are converted to W. Australia Standard Time before being converted to UTC.
/// </remarks>
internal class CustomDateTimeModelBinder : IModelBinder
{
    private readonly DateTimeModelBinder _dateTimeModelBinder;

    public CustomDateTimeModelBinder(DateTimeStyles supportedStyles, ILoggerFactory loggerFactory)
    {
        _dateTimeModelBinder = new DateTimeModelBinder(supportedStyles, loggerFactory);
    }

    public async Task BindModelAsync(ModelBindingContext bindingContext)
    {
        await _dateTimeModelBinder.BindModelAsync(bindingContext);

        if (bindingContext.Result.IsModelSet)
        {
            var dateTimeValue = (DateTime)bindingContext.Result.Model!;

            // Server side projects in this solution are exclusively UTC. If we get a local datetime, convert it to UTC.
            if (dateTimeValue.Kind == DateTimeKind.Local)
            {
                dateTimeValue = dateTimeValue.ToUniversalTime();
            }

            // This is a fallback position; if we get an unspecified datetime, convert it to AWST (the expected primary user location),
            // then convert it to UTC.
            // It exists primarily for compatibility, in the future we may change this behaviour (e.g., throw an exception)
            if (dateTimeValue.Kind == DateTimeKind.Unspecified)
            {
                dateTimeValue = TimeZoneInfo.ConvertTimeToUtc(dateTimeValue, TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time"));
            }

            bindingContext.Result = ModelBindingResult.Success(dateTimeValue);
        }
    }
}
