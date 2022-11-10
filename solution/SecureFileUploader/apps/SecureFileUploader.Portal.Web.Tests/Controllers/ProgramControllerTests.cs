using System.Net;
using System.Net.Http.Headers;
using System.Text;
using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Tests.Extensions;
using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Dtos.Request;
using SecureFileUploader.Portal.Web.Tests.Extensions;
using SecureFileUploader.Portal.Web.Tests.Infrastructure;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramDto = SecureFileUploader.Portal.Web.Dtos.Program;

namespace SecureFileUploader.Portal.Web.Tests.Controllers;

public class ProgramControllerTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;

    public ProgramControllerTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WhenFileEndpointHit_Return200()
    {
        var file = MockIFormFile.GetFileMock("text/csv",
            "CrmId,Phn,PracticeId,GeneralPracticeName,FolderName,GenericEmailAddress,some_field,ReportingQuarter\n" +
            string.Join("\n",
                CreateData.CreateValidCsvRows().Select(x => $"{x.CrmId},{x.Phn},{x.PracticeId},{x.GeneralPracticeName},{x.FolderName},{x.GenericEmailAddress},some_field,{x.ReportingQuarter}")));

        var stream = new StreamContent(file.OpenReadStream());
        stream.Headers.ContentType = new MediaTypeHeaderValue(file.ContentType);

        var data = new MultipartFormDataContent();

        data.Add(new StringContent("Test"), "Name");
        data.Add(new StringContent(DateTime.UtcNow.AddDays(1).ToString()), "commencementDate");
        data.Add(new StringContent(DateTime.UtcNow.AddDays(2).ToString()), "submissionDeadline");
        data.Add(new StringContent("Australia/Perth"), "timezone");
        data.Add(stream, "File", file.FileName);

        using var client = TestHostFactory.CreateTestClient(UsingEmptyDbContext());
        var response = await client.PostAsync("api/programs/file", data);

        response.StatusCode.Should().Be(HttpStatusCode.Created);
    }

    [Fact]
    public async Task WhenUpdateEndpointHit_Return200()
    {
        var program = _objectFactory.Build<ProgramDataModel>().With(x => x.IsCommenced, false).Create();
        var data = new MultipartFormDataContent();

        data.Add(new StringContent("Test"), "Name");
        data.Add(new StringContent(DateTime.UtcNow.AddDays(1).ToString()), "commencementDate");
        data.Add(new StringContent(DateTime.UtcNow.AddDays(2).ToString()), "submissionDeadline");
        data.Add(new StringContent("Australia/Perth"), "timezone");

        using var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(program));

        var response = await client.PutAsync($"api/programs/{program.Id}", data);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            content.Should().Contain(program.Id.ToString());
        }
    }

    [Fact]
    public async Task WhenSearchEndpointHitWithNoSearchTerm_ReturnsOkResponseContainingAllProgramSummaries()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(programs));

        var searchProgramsFilter = JsonConvert.SerializeObject(new SearchProgramsFilter { ShowClosedPrograms = true });
        var buffer = Encoding.UTF8.GetBytes(searchProgramsFilter);
        var byteContent = new ByteArrayContent(buffer);
        byteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

        var response = await client.PostAsync("api/programs/search", byteContent);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var programSummaries = JsonConvert.DeserializeObject<List<ProgramSummary>>(content);
            programSummaries.Should().BeEquivalentTo(_mapper.Map<List<ProgramSummary>>(programs)).And.BeInDescendingOrder(x => x.CommencementDate);
        }
    }

    [Fact]
    public async Task WhenSearchEndpointHitWithSearchTermThatMatchesSomePrograms_ReturnsOkResponseContainingMatchingProgramSummaries()
    {
        var programs = new List<ProgramDataModel> {
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Foo").Create(),
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Bar").Create(),
            _objectFactory.Build<ProgramDataModel>().With(x => x.Name, "Baz").Create()
        }.ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(programs));

        var searchProgramsFilter = JsonConvert.SerializeObject(new SearchProgramsFilter { ShowClosedPrograms = true });
        var buffer = Encoding.UTF8.GetBytes(searchProgramsFilter);
        var byteContent = new ByteArrayContent(buffer);
        byteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

        var response = await client.PostAsync("api/programs/search?searchTerm=Ba", byteContent);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var programSummaries = JsonConvert.DeserializeObject<List<ProgramSummary>>(content);
            programSummaries.Should().HaveCount(2)
                .And.BeEquivalentTo(_mapper.Map<List<ProgramSummary>>(programs.Where(x => x.Name.Contains("Ba", StringComparison.OrdinalIgnoreCase))))
                .And.BeInDescendingOrder(x => x.CommencementDate);
        }
    }

    [Fact]
    public async Task WhenSearchEndpointHitWithSearchTermThatDoesNotMatchAnyPrograms_ReturnsOkResponseContainingAnEmptySequence()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(programs));

        var searchProgramsFilter = JsonConvert.SerializeObject(new SearchProgramsFilter { ShowClosedPrograms = true });
        var buffer = Encoding.UTF8.GetBytes(searchProgramsFilter);
        var byteContent = new ByteArrayContent(buffer);
        byteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

        var response = await client.PostAsync("api/programs/search?searchTerm=foo", byteContent);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var programSummaries = JsonConvert.DeserializeObject<List<ProgramSummary>>(content);
            programSummaries.Should().BeEmpty();
        }
    }

    [Fact]
    public async Task WhenGetByIdEndpointHitUsingIdOfExistingProgram_ReturnsOkResponseContainingExpectedProgram()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(programs));
        var programToGet = programs.ElementAt(1);
        var expectedResult = _mapper.Map<ProgramDto>(programToGet);

        var response = await client.GetAsync($"api/programs/{programToGet.Id}");

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var actualResult = JsonConvert.DeserializeObject<ProgramDto>(content);
            actualResult.Should().BeEquivalentTo(expectedResult);
        }
    }

    [Fact]
    public async Task WhenGetByIdEndpointHitNotUsingIdOfExistingProgram_ReturnsNotFoundResponse()
    {
        var programs = _objectFactory.CreateMany<ProgramDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(programs));

        var response = await client.GetAsync($"api/programs/{_objectFactory.Create<Guid>()}");

        response.StatusCode.Should().Be(HttpStatusCode.NotFound);
    }

    [Fact]
    public async Task WhenStageFileEndpointHitWithValidFile_ReturnsOkResponseContainingInviteeData()
    {
        var client = TestHostFactory.CreateTestClient();

        var expectedResult = CreateData.CreateValidCsvRows();
        var file = MockIFormFile.GetFileMock("text/csv",
            "CrmId,Phn,PracticeId,GeneralPracticeName,FolderName,GenericEmailAddress,some_field,ReportingQuarter\n" +
            string.Join("\n", expectedResult.Select(x => $"{x.CrmId},{x.Phn},{x.PracticeId},{x.GeneralPracticeName},{x.FolderName},{x.GenericEmailAddress},some_field,{x.ReportingQuarter}")));

        var stream = new StreamContent(file.OpenReadStream());
        stream.Headers.ContentType = new MediaTypeHeaderValue(file.ContentType);

        var response = await client.PostAsync("api/programs/stage-file", new MultipartFormDataContent
        {
            {stream, "file", file.FileName}
        });

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var actualResult = JsonConvert.DeserializeObject<List<InviteCsvRow>>(content);
            actualResult.Should().BeEquivalentTo(expectedResult);
        }
    }

    private TestHostFactory.TestClientCreateOptions UsingEmptyDbContext()
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName)
            }
        };
    }

    private TestHostFactory.TestClientCreateOptions UsingDbContextSeededWith(IEnumerable<ProgramDataModel> programs)
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName),
                InitializationStepsForTests = dbContext =>
                {
                    dbContext.Set<ProgramDataModel>().AddRange(programs);
                    dbContext.SaveChanges();
                }
            }
        };
    }

    private TestHostFactory.TestClientCreateOptions UsingDbContextSeededWith(ProgramDataModel program)
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName),
                InitializationStepsForTests = dbContext =>
                {
                    dbContext.Set<ProgramDataModel>().Add(program);
                    dbContext.SaveChanges();
                }
            }
        };
    }
}
