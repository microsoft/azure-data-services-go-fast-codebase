using AutoFixture;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using Moq.Contrib.ExpressionBuilders.Logging;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Data.Resources;
using SecureFileUploader.Data.Tests.Extensions;
using SecureFileUploader.Data.Tests.Infrastructure;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;

namespace SecureFileUploader.Data.Tests;

public class SecureFileUploaderContextTests : IClassFixture<ObjectFactoryFixture>
{
    private readonly Fixture _objectFactory;

    public SecureFileUploaderContextTests(ObjectFactoryFixture objectFactoryFixture)
    {
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    public static IEnumerable<object[]> WhenPersistingChangesThatDoNotContainNonUtcDates_DoesNotThrowException_Input =>
        new List<object[]> {
            new object[] { Environments.Development },
            new object[] { Environments.Staging },
            new object[] { Environments.Production }
        };

    public static IEnumerable<object[]> WhenPersistingChangesNotDuringDevelopmentThatContainNonUtcDates_DoesNotThrowException_Input =>
        new List<object[]> {
            new object[] { Environments.Staging, DateTimeKind.Local },
            new object[] { Environments.Staging, DateTimeKind.Unspecified },
            new object[] { Environments.Production, DateTimeKind.Local },
            new object[] { Environments.Production, DateTimeKind.Unspecified }
        };

    private CreateDbContextOptions WithDefaultCreateOptions => new() {
        DatabaseName = _objectFactory.Create<Guid>().ToString(),
        EnvironmentName = Environments.Development,
        Logger = Mock.Of<ILogger<SecureFileUploaderContext>>()
    };

    [Theory]
    [MemberData(nameof(WhenPersistingChangesThatDoNotContainNonUtcDates_DoesNotThrowException_Input))]
    public async Task WhenPersistingChangesThatDoNotContainNonUtcDates_DoesNotThrowException(string environmentName)
    {
        var dbContext = CreateDbContext(o => o.EnvironmentName = environmentName);
        var model = _objectFactory.Create<ProgramDataModel>();
        dbContext.Add(model);

        Func<Task> act = async () =>
        {
            await dbContext.SaveChangesAsync();
        };

        await act.Should().NotThrowAsync();
    }

    [Theory]
    [InlineData(DateTimeKind.Local)]
    [InlineData(DateTimeKind.Unspecified)]
    public async Task WhenPersistingChangesDuringDevelopmentThatContainNonUtcDates_ThrowsException(DateTimeKind dateTimeKind)
    {
        var logger = Mock.Of<ILogger<SecureFileUploaderContext>>();
        var dbContext = CreateDbContext(o => o.Logger = logger);
        var model = _objectFactory
            .Build<ProgramDataModel>()
            .With(x => x.CommencementDate, DateTime.SpecifyKind(_objectFactory.Create<DateTime>(), dateTimeKind))
            .Create();
        dbContext.Add(model);

        Func<Task> act = async () =>
        {
            await dbContext.SaveChangesAsync();
        };

        await act.Should().ThrowExactlyAsync<ApplicationException>();
        logger.Verify(
            Log.With.LogLevel(LogLevel.Error)
                .And.LogMessage(LogMessages.NonUtcDateFound)
                .And.LoggedValue("entityType", "Program")
                .And.LoggedValue("nonUtcProperties", "CommencementDate"),
            Times.Once);
    }

    [Theory]
    [MemberData(nameof(WhenPersistingChangesNotDuringDevelopmentThatContainNonUtcDates_DoesNotThrowException_Input))]
    public async Task WhenPersistingChangesNotDuringDevelopmentThatContainNonUtcDates_DoesNotThrowException(string environmentName, DateTimeKind dateTimeKind)
    {
        var dbContext = CreateDbContext(o => o.EnvironmentName = environmentName);
        var model = _objectFactory
            .Build<ProgramDataModel>()
            .With(x => x.CommencementDate, DateTime.SpecifyKind(_objectFactory.Create<DateTime>(), dateTimeKind))
            .Create();
        dbContext.Add(model);

        Func<Task> act = async () =>
        {
            await dbContext.SaveChangesAsync();
        };

        await act.Should().NotThrowAsync();
    }

    [Theory]
    [InlineData(DateTimeKind.Local)]
    [InlineData(DateTimeKind.Unspecified)]
    public async Task WhenRetrievingDateTimeValue_AlwaysReturnsUtcDateTimeKind(DateTimeKind dateTimeKind)
    {
        var databaseName = _objectFactory.Create<Guid>().ToString();

        void DbContextCreateOptions(CreateDbContextOptions createOptions)
        {
            createOptions.DatabaseName = databaseName;
            createOptions.EnvironmentName = _objectFactory.Create<string>();
        }

        var dbContext = CreateDbContext(DbContextCreateOptions);
        var model = _objectFactory
            .Build<ProgramDataModel>()
            .With(x => x.CommencementDate, DateTime.SpecifyKind(_objectFactory.Create<DateTime>(), dateTimeKind))
            .Create();
        dbContext.Add(model);
        await dbContext.SaveChangesAsync();

        var anotherDbContext = CreateDbContext(DbContextCreateOptions);
        anotherDbContext.Set<ProgramDataModel>().Single().CommencementDate.Kind.Should().Be(DateTimeKind.Utc);
    }

    private SecureFileUploaderContext CreateDbContext(Action<CreateDbContextOptions>? createOptions = null)
    {
        var resolvedCreateOptions = WithDefaultCreateOptions;
        createOptions?.Invoke(resolvedCreateOptions);
        return CreateDbContext(resolvedCreateOptions);
    }

    private SecureFileUploaderContext CreateDbContext(CreateDbContextOptions createOptions) =>
        new(new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(createOptions.DatabaseName).Options,
            createOptions.Logger,
            new FakeClock(Instant.FromDateTimeUtc(_objectFactory.UtcNow())),
            Mock.Of<IHostEnvironment>(x => x.EnvironmentName == createOptions.EnvironmentName),
            Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));

    private class CreateDbContextOptions
    {
        public string DatabaseName { get; set; }

        public string EnvironmentName { get; set; }

        public ILogger<SecureFileUploaderContext> Logger { get; set; }
    }
}
