using AutoFixture;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeAccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;

namespace SecureFileUploader.Common.Tests.Extensions;

public static class ObjectFactoryExtensions
{
    public static DateTime UtcNow(this Fixture objectFactory) => objectFactory.Create<DateTime>();

    public static InviteeAccessTokenDataModel CreatePendingInviteeAccessTokenDataModel(this Fixture objectFactory)
    {
        var utcNow = objectFactory.Create<DateTime>();
        var invitee = objectFactory.Build<InviteeDataModel>()
            .Without(x => x.AccessTokens)
            .Without(x => x.InviteeEvents).Create();
        var accessToken = objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, true)
            .With(x => x.StartsOn, utcNow.AddDays(-1))
            .With(x => x.EndsOn, utcNow.AddDays(1))
            .With(x => x.IsSentToMailProvider, false)
            .With(x => x.Invitee, invitee)
            .Create();
        return accessToken;
    }

    public static InviteeAccessTokenDataModel CreateActiveInviteeAccessTokenDataModel(this Fixture objectFactory)
    {
        var utcNow = objectFactory.Create<DateTime>();
        var invitee = objectFactory.Build<InviteeDataModel>()
            .Without(x => x.AccessTokens)
            .Without(x => x.InviteeEvents).Create();

        var accessToken = objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, true)
            .With(x => x.StartsOn, utcNow.AddDays(-1))
            .With(x => x.EndsOn, utcNow.AddDays(1))
            .With(x => x.IsSentToMailProvider, true)
            .With(x => x.Invitee, invitee)
            .Create();
        return accessToken;
    }

    public static InviteeAccessTokenDataModel CreateExpiredInviteeAccessTokenDataModel(this Fixture objectFactory)
    {
        var utcNow = objectFactory.Create<DateTime>();
        var invitee = objectFactory.Build<InviteeDataModel>()
            .Without(x => x.AccessTokens)
            .Without(x => x.InviteeEvents).Create();

        var accessToken = objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, false)
            .With(x => x.StartsOn, utcNow.AddDays(-2))
            .With(x => x.EndsOn, utcNow.AddDays(-1))
            .With(x => x.IsSentToMailProvider, true)
            .With(x => x.Invitee, invitee)
            .Create();
        return accessToken;
    }
}
