using AutoFixture;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Tests.Extensions;
using SecureFileUploader.Common.Tests.Infrastructure;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Portal.Web.Tests.Extensions;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;

namespace SecureFileUploader.Portal.Web.Tests.Services;

public class CreateProgramTests : IClassFixture<ObjectFactoryFixture>
{
    private readonly Fixture _objectFactory;
    private readonly IClock _clock;

    public CreateProgramTests(ObjectFactoryFixture objectFactoryFixture)
    {
        _objectFactory = objectFactoryFixture.ObjectFactory;

        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
    }

    [Fact]
    public async Task WhenAddingProgramToDatabase_ReturnsProgramDataModel()
    {
        var createdData = CreateFile.CreateFileUploadModel();

        var dbContext = CreateDbContext();
        var upload = new CreateProgramService(dbContext);
        var result = await upload.InsertProgramData(createdData);
        await dbContext.SaveChangesAsync();

        result.Should().BeOfType<ProgramDataModel>();
    }

    [Fact]
    public async Task AddInviteesToDataBase_ShouldHaveProgramId()
    {
        var createdData = _objectFactory.Create<ProgramDataModel>();

        var rows = CreateData.CreateValidCsvRows();

        var dbContext = CreateDbContext();
        var upload = new CreateProgramService(dbContext);
        var list = await upload.InsertInviteeData(rows, createdData);
        await dbContext.SaveChangesAsync();

        list.Should().Contain(x => x.Program.Id == createdData.Id);
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        _clock,
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));
}
