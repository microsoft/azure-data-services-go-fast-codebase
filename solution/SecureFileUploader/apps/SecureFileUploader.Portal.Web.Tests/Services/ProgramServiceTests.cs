using AutoFixture;
using AutoMapper;
using FluentAssertions;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Tests.Extensions;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Dtos.Request;
using SecureFileUploader.Portal.Web.Interfaces;
using SecureFileUploader.Portal.Web.Services;
using SecureFileUploader.Portal.Web.Tests.Extensions;
using SecureFileUploader.Portal.Web.Tests.Infrastructure;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramDto = SecureFileUploader.Portal.Web.Dtos.Program;

namespace SecureFileUploader.Portal.Web.Tests.Services;

public class ProgramServiceTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;
    private readonly IClock _clock;
    private readonly Mock<ICsvParser> _csvParser;
    private readonly Mock<ICreateProgramService> _programCreate;

    public ProgramServiceTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
        _csvParser = new Mock<ICsvParser>();
        _programCreate = new Mock<ICreateProgramService>();
    }

    [Theory]
    [InlineData("")]
    [InlineData(null)]
    public async Task WhenSearchingWithNoSearchTerm_ReturnsAllProgramSummaries(string? searchTerm)
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Program.AddRange(programs);
        await dbContext.SaveChangesAsync();

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        var programSummaries = await programService.GetAllThatMatchSearchTermAsync(searchTerm, new SearchProgramsFilter { ShowClosedPrograms = true });

        programSummaries.Should().BeEquivalentTo(_mapper.Map<List<ProgramSummary>>(programs)).And.BeInDescendingOrder(x => x.CommencementDate);
    }

    [Fact]
    public async Task WhenSearchingWithSearchTermThatMatchesSomePrograms_ReturnsMatchingProgramSummaries()
    {
        var programs = new List<ProgramDataModel> {
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Foo").Create(),
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Bar").Create(),
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Baz").Create()
        }.ToList();
        var dbContext = CreateDbContext();
        dbContext.Program.AddRange(programs);
        await dbContext.SaveChangesAsync();

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        var programSummaries = await programService.GetAllThatMatchSearchTermAsync("Ba", new SearchProgramsFilter { ShowClosedPrograms = true });

        programSummaries.Should().HaveCount(2)
            .And.BeEquivalentTo(_mapper.Map<List<ProgramSummary>>(programs.Where(x => x.Name.Contains("Ba", StringComparison.OrdinalIgnoreCase))))
            .And.BeInDescendingOrder(x => x.CommencementDate);
    }

    [Fact]
    public async Task WhenSearchingWithSearchTermThatDoesNotMatchAnyPrograms_ReturnsEmptySequence()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Program.AddRange(programs);
        await dbContext.SaveChangesAsync();

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        var programSummaries = await programService.GetAllThatMatchSearchTermAsync("foo", new SearchProgramsFilter { ShowClosedPrograms = true });

        programSummaries.Should().BeEmpty();
    }

    [Fact]
    public async Task WhenRetrievingProgramUsingIdOfExistingProgram_ReturnsExpectedProgram()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Program.AddRange(programs);
        await dbContext.SaveChangesAsync();
        var expectedResult = _mapper.Map<ProgramDto>(programs.ElementAt(1));

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        var actualResult = await programService.GetByIdAsync(expectedResult.Id);

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WhenUpdatingProgram_ReturnsProgram()
    {
        var utc = _clock.GetCurrentInstant().ToDateTimeUtc();

        var program = _objectFactory.Build<ProgramDataModel>()
            .With(x => x.IsCommenced, false).Create();

        var progUpdate = new ProgramUpdate {
            Name = "New Name",
            CommencementDate = utc.AddDays(1),
            SubmissionDeadline = utc.AddDays(4)
        };

        var expectedResult = _mapper.Map<ProgramUpdate>(progUpdate);

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(program);
        await dbContext.SaveChangesAsync();

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);


        var actualResult = await programService.UpdateProgramInformationAsync(program.Id, progUpdate);

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WhenRetrievingProgramNotUsingIdOfExistingProgram_ReturnsNull()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Program.AddRange(programs);
        await dbContext.SaveChangesAsync();

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        var actualResult = await programService.GetByIdAsync(_objectFactory.Create<Guid>());

        actualResult.Should().BeNull();
    }

    [Fact]
    public async Task CreateProgramValidCsvData_ReturnsTrue()
    {
        var program = _objectFactory.Create<ProgramDataModel>();
        var fileUpload = CreateFile.CreateFileUploadModel();
        var csvRows = CreateData.CreateValidCsvRows();
        var dbContext = CreateDbContext();

        await using var ms = new MemoryStream();
        await fileUpload.File.CopyToAsync(ms);
        ms.Seek(0, SeekOrigin.Begin);

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);

        _programCreate.Setup(x => x.InsertProgramData(fileUpload)).ReturnsAsync(program);
        _csvParser.Setup(x => x.GetRecordsAsync<InviteCsvRow>(It.IsAny<IFormFile>())).ReturnsAsync(csvRows);

        var result = await programService.CreateProgramAsync(fileUpload);

        result.Item1.Should().BeTrue();
    }

    [Fact]
    public async Task CreateProgramInvalidCsvData_ReturnsFalse()
    {
        var fileUpload = CreateFile.CreateFileUploadModel();
        var dbContext = CreateDbContext();

        _csvParser.Setup(x => x.GetRecordsAsync<InviteCsvRow>(It.IsAny<IFormFile>())).ReturnsAsync(CreateData.CreateInvalidCsvRows);

        var programService = new ProgramService(_mapper, dbContext, _csvParser.Object, _programCreate.Object);
        var result = await programService.CreateProgramAsync(fileUpload);

        result.Item1.Should().BeFalse();
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        _clock,
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));
}
