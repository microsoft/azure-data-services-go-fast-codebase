using AutoFixture;

namespace SecureFileUploader.Common.Tests.Infrastructure;

public class ObjectFactoryFixture
{
    public ObjectFactoryFixture()
    {
        ObjectFactory = new Fixture();

        ObjectFactory.Behaviors.OfType<ThrowingRecursionBehavior>().ToList()
            .ForEach(b => ObjectFactory.Behaviors.Remove(b));
        ObjectFactory.Behaviors.Add(new OmitOnRecursionBehavior());

        var utcNow = DateTime.UtcNow;
        ObjectFactory.Register(() => utcNow);
    }

    public Fixture ObjectFactory { get; }
}
