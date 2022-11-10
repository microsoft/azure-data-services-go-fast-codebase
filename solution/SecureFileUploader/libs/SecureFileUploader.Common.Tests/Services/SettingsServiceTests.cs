using AutoFixture;
using AutoMapper;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Tests.Infrastructure;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;
using ProgramSettingsSnapshotDto = SecureFileUploader.Common.Dtos.Settings;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramSettingsSnapshotDataModel = SecureFileUploader.Data.Models.ProgramSettingsSnapshot;

namespace SecureFileUploader.Common.Tests.Services;

public class SettingsServiceTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;
    private readonly IClock _clock;
    private readonly Mock<ICreateSettingsService> _createSettingsService;

    public SettingsServiceTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
        _createSettingsService = new Mock<ICreateSettingsService>();
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WithAnyProgramGuid_ReturnsUnderlyingSettings()
    {
        var settings = _objectFactory.Create<SettingsDataModel>();
        var dbContext = CreateDbContext();
        var expectedResult = _mapper.Map<SettingsDto>(settings);

        await dbContext.Settings.AddAsync(settings);
        await dbContext.SaveChangesAsync();

        var settingsService = new SettingsService(_mapper, dbContext, _createSettingsService.Object);
        var actualResult = await settingsService.GetAllCurrentSettingsForProgramAsync(new Guid());

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WithAnyProgramGuid_ReturnsNewestSettings()
    {
        var settings = _objectFactory.CreateMany<SettingsDataModel>().ToList();
        var dbContext = CreateDbContext();
        var expectedResult = _mapper.Map<SettingsDto>(settings.MaxBy(x => x.LastModifiedOn));

        await dbContext.AddRangeAsync(settings);
        await dbContext.SaveChangesAsync();

        var settingsService = new SettingsService(_mapper, dbContext, _createSettingsService.Object);
        var actualResult = await settingsService.GetAllCurrentSystemSettingsAsync();

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WithValidProgramGuid_ReturnsProgramSettings()
    {
        // we do not expect these settings
        var settings = _objectFactory.Create<SettingsDataModel>();
        // we expect these setting
        var programSettings = _objectFactory.Create<ProgramSettingsSnapshotDataModel>();

        var dbContext = CreateDbContext();
        var expectedResult = _mapper.Map<SettingsDto>(programSettings.Settings);

        await dbContext.ProgramSettingsSnapshot.AddAsync(programSettings);
        await dbContext.Settings.AddAsync(settings);
        await dbContext.SaveChangesAsync();

        var settingsService = new SettingsService(_mapper, dbContext, _createSettingsService.Object);
        var actualResult = await settingsService.GetAllCurrentSettingsForProgramAsync(programSettings.Program.Id);

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WithMultipleProgramSnapshots_ReturnsTheNewest()
    {
        // we do not expect these settings
        var settings = _objectFactory.Create<SettingsDataModel>();
        var guid = Guid.NewGuid();

        var programSettingsSnapshot = CreateProgramSettingsSnapshots(guid);
        // make sure they all have the same program
        var dbContext = CreateDbContext();
        await dbContext.ProgramSettingsSnapshot.AddRangeAsync(programSettingsSnapshot);
        await dbContext.Settings.AddAsync(settings);
        await dbContext.SaveChangesAsync();

        // fetch the newest settings
        var orderedSettings = programSettingsSnapshot.OrderByDescending(x => x.SnapshotOn);
        var newestSettings = orderedSettings.First();

        var settingsService = new SettingsService(_mapper, dbContext, _createSettingsService.Object);
        var actualResult = await settingsService.GetAllCurrentSettingsForProgramAsync(newestSettings.ProgramId);

        var expectedResult = _mapper.Map<SettingsDto>(newestSettings.Settings);
        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WhenUpdatingSettings_ReturnsNewId()
    {
        var settings = _objectFactory.Create<SettingsDto>();
        var settingsModel = _objectFactory.Create<SettingsDataModel>();

        var dbContext = CreateDbContext();

        // Just make sure a save occurs - no need to be too finnicky
        _createSettingsService.Setup(x => x.InsertSettingsDataAsync(It.IsAny<SettingsDto>())).ReturnsAsync(settingsModel);

        var settingsService = new SettingsService(_mapper, dbContext, _createSettingsService.Object);
        var actualResult = await settingsService.UpdateSystemSettingsAsync(settings);

        actualResult.Should<Guid>();
    }

    private List<ProgramSettingsSnapshotDataModel> CreateProgramSettingsSnapshots(Guid programId)
    {
        var programSettingsSnapshot = _objectFactory.CreateMany<ProgramSettingsSnapshotDataModel>().ToList();
        // Too fiddly in practise using this https://github.com/AutoFixture/AutoFixture/issues/708
        var now = DateTime.UtcNow;

        foreach (var programSetting in programSettingsSnapshot)
        {
            programSetting.ProgramId = programId;
            // everyone is an hour later than last
            programSetting.SnapshotOn = now.AddHours(1);
        }

        return programSettingsSnapshot;
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        _clock,
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));
}
