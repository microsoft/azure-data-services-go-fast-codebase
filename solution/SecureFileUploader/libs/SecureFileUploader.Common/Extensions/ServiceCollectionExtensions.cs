using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using NodaTime;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Mapping;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Settings;
using SendGrid.Extensions.DependencyInjection;

// ReSharper disable once CheckNamespace
namespace Microsoft.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddCommonServices(this IServiceCollection services)
    {
        services.AddTransient<IAccessTokenService, AccessTokenService>();
        services.AddTransient<IInviteeEventTypeService, InviteeEventTypeService>();
        services.AddTransient<IInviteeService, InviteeService>();
        services.AddTransient<INotificationService, NotificationService>();
        services.AddTransient<IStorageService, StorageService>();
        services.AddTransient<ISettingsService, SettingsService>();
        services.AddTransient<ICreateSettingsService, CreateSettingsService>();
        services.AddTransient<ISendGridEmailService, SendGridEmailService>();
        AddCommonZoneCommonServices(services);

        services.AddAutoMapper(config =>
        {
            config.AddProfile<MappingProfile>();
        });

        services.AddSingleton<IClock>(SystemClock.Instance);

        services.AddSendGrid((serviceProvider, sendGridOptions) =>
        {
            var settings = serviceProvider.GetRequiredService<IOptions<SendGridSettings>>();
            sendGridOptions.ApiKey = settings.Value.ApiKey;
        });

        return services;
    }

    public static void AddCommonZoneCommonServices(this IServiceCollection services)
    {
        services.AddTransient<ICryptographyProvider, CryptographyProvider>();
        services.AddTransient<IByteConversionService, ByteConversionService>();
    }


    public static IServiceCollection AddCommonConfiguration(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<InviteEmailTemplateSettings>(configuration.GetSection("Templates:Email:Invite"));
        services.Configure<SendGridSettings>(configuration.GetSection("Integration:SendGrid"));
        services.Configure<StorageSettings>(configuration.GetSection("Storage"));

        if (configuration.GetValue<bool>("ADS:UseADS"))
            services.Configure<AdsSettings>(configuration.GetSection("ADS"));

        return services;
    }
}
