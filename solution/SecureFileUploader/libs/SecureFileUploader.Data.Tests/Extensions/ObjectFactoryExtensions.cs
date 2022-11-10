using AutoFixture;

namespace SecureFileUploader.Data.Tests.Extensions;

public static class ObjectFactoryExtensions
{
    public static DateTime UtcNow(this Fixture objectFactory) => objectFactory.Create<DateTime>();
}
