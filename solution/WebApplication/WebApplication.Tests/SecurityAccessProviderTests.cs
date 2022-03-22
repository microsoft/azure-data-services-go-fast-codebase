using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebApplication.Models.Options;
using WebApplication.Services;
using System.Security.Claims;

namespace WebApplication.Tests
{
    [TestClass]
    public class SecurityAccessProviderTests
    {
        private const string Reader = "Reader";
        private const string ReaderGroupID = "ReaderSecurityId";

        [TestMethod]
        public void LoadingSettingsIncludesGlobalListsAndRoles()
        {
            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appSettings.json");
            var config = configBuilder.Build();
            var optionsModel = ConfigurationBinder.Get<SecurityModelOptions>(config.GetSection("SecurityModelOptions"));
            var options = Options.Create(optionsModel);

            options.Should().NotBeNull();
            options.Value.GlobalAllowActions.Count.Should().BeGreaterThan(0);
            options.Value.GlobalDenyActions.Count.Should().BeGreaterThan(0);
            options.Value.SecurityRoles.Count.Should().BeGreaterThan(0);
            options.Value.SecurityRoles[Reader].AllowActions.Count.Should().BeGreaterThan(0);
        }
    }
}
