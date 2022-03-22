using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Humanizer;
using Microsoft.AspNetCore.Mvc.ModelBinding.Metadata;

namespace WebApplication.Helpers
{


    public class HumanizerMetadataProvider : IDisplayMetadataProvider
    {
        public void CreateDisplayMetadata(DisplayMetadataProviderContext context)
        {
            var propertyAttributes = context.Attributes;
            var modelMetadata = context.DisplayMetadata;
            var propertyName = context.Key.Name;

            if (IsTransformRequired(propertyName, modelMetadata, propertyAttributes))
            {

                modelMetadata.DisplayName = () =>
                {
                    switch (propertyName)
                    {
                        case "ActiveYn":
                            return "Is Active";
                        default:
                            return propertyName.Humanize().Transform(To.TitleCase);
                    }
                    
                };
            }
        }

        private static bool IsTransformRequired(string propertyName, DisplayMetadata modelMetadata, IReadOnlyList<object> propertyAttributes)
        {
            if (!string.IsNullOrEmpty(modelMetadata.SimpleDisplayProperty))
                return false;

            if (propertyAttributes.OfType<DisplayNameAttribute>().Any())
                return false;

            if (propertyAttributes.OfType<DisplayAttribute>().Any())
                return false;

            if (string.IsNullOrEmpty(propertyName))
                return false;

            return true;
        }
    }
}
