using System.Text.RegularExpressions;

namespace SecureFileUploader.Portal.Web.Infrastructure;

public class SlugifyParameterTransformer : IOutboundParameterTransformer
{
    public string? TransformOutbound(object? value) =>
        value == null ? null : Regex.Replace(value.ToString() ?? string.Empty, "([a-z])([A-Z])", "$1-$2").ToLower();
}
