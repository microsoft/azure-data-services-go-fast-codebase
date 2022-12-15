using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using NodaTime;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Data.Models;
using SecureFileUploader.Data.Resources;

namespace SecureFileUploader.Data;

public class SecureFileUploaderContext : DbContext
{
    private readonly IClock _clock;
    private readonly IHostEnvironment _hostEnvironment;
    private readonly IRequestContext _requestContext;
    private readonly ILogger<SecureFileUploaderContext> _logger;

    public SecureFileUploaderContext(DbContextOptions<SecureFileUploaderContext> options, ILogger<SecureFileUploaderContext> logger, IClock clock,
        IHostEnvironment hostEnvironment, IRequestContext requestContext) : base(options)
    {
        _logger = logger;
        _clock = clock;
        _hostEnvironment = hostEnvironment;
        _requestContext = requestContext;
    }

    public DbSet<AccessToken> AccessToken { get; set; }
    public DbSet<Invitee> Invitee { get; set; }
    public DbSet<InviteeEvent> InviteeEvent { get; set; }
    public DbSet<InviteeEventType> InviteeEventType { get; set; }
    public DbSet<Program> Program { get; set; }
    public DbSet<ProgramEvent> ProgramEvent { get; set; }
    public DbSet<ProgramEventType> ProgramEventType { get; set; }
    public DbSet<ProgramSettingsSnapshot> ProgramSettingsSnapshot { get; set; }
    public DbSet<Settings> Settings { get; set; }
    public DbSet<SendGridEmail> SendGridEmail { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        var dateTimeConverter = new ValueConverter<DateTime, DateTime>(
            v => v, v => DateTime.SpecifyKind(v, DateTimeKind.Utc));

        foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        foreach (var property in entityType.GetProperties())
            if (property.ClrType == typeof(DateTime) || property.ClrType == typeof(DateTime?))
                property.SetValueConverter(dateTimeConverter);

        modelBuilder.Entity<Program>(e =>
        {
            e.HasKey(x => x.Id);
            e.Property(x => x.Id).HasDefaultValueSql("(newid())");
        });

        modelBuilder.Entity<ProgramSettingsSnapshot>()
            .OwnsOne(a => a.Settings);

        modelBuilder.Entity<ProgramEvent>().HasOne(x => x.Program).WithMany(x => x.ProgramEvents);

        modelBuilder.Entity<Invitee>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasDefaultValueSql("(newid())");
            entity.HasOne(x => x.Program).WithMany(x => x.Invitees);
            // Set property PracticeID MaxLength to nvarchar(max)
            // EF won't allow the property to reach MAX in a single migration, so we set it to the max value of SQL server
            entity.Property(x => x.PracticeId).HasMaxLength(4000);
        });

        modelBuilder.Entity<AccessToken>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasDefaultValueSql("(newid())");
            entity.HasOne(x => x.Invitee).WithMany(x => x.AccessTokens).HasForeignKey(x => x.InviteeId);
        });

        modelBuilder.Entity<InviteeEvent>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasDefaultValueSql("(newid())");
            entity.HasOne(x => x.Invitee).WithMany(x => x.InviteeEvents).HasForeignKey(x => x.InviteeId);
        });

        modelBuilder.Entity<InviteeEventType>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).UseIdentityColumn();
            entity.HasMany(x => x.InviteeEvents).WithOne(x => x.EventType).HasForeignKey(x => x.EventTypeId);
        });

        modelBuilder.Entity<SendGridEmail>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasDefaultValueSql("(newid())");
            // We may need to keep a link in future on Invitee back to Email, will likely be 1..n SendGridEmails with the retry function
            entity.HasOne(x => x.Invitee);
            entity.Property(x => x.SendGridId).HasMaxLength(500);
        });
    }

    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = new())
    {
        var utcTime = _clock.GetCurrentInstant().ToDateTimeUtc();

        foreach (var entry in ChangeTracker.Entries<IAuditable>())
        {
            if (entry.State.Equals(EntityState.Added))
            {
                entry.Entity.CreatedOn = utcTime;
                entry.Entity.CreatedBy = _requestContext.DisplayName;
            }

            if (entry.State.Equals(EntityState.Added) || entry.State.Equals(EntityState.Modified))
            {
                entry.Entity.LastModifiedOn = utcTime;
                entry.Entity.LastModifiedBy = _requestContext.DisplayName;
            }

            // Development guard against persisting non UTC dates
            if (_hostEnvironment.IsDevelopment())
            {
                var nonUtcDates = entry.Entity
                    .GetType()
                    .GetProperties()
                    .Where(x => x.PropertyType == typeof(DateTime) && ((DateTime)x.GetValue(entry.Entity)).Kind != DateTimeKind.Utc)
                    .ToList();

                if (nonUtcDates.Any())
                {
                    _logger.LogError(LogMessages.NonUtcDateFound,
                        entry.Entity.GetType().Name,
                        string.Join(", ", nonUtcDates.Select(x => x.Name)));
                    throw new ApplicationException(
                        $"entity '{entry.Entity.GetType().Name}' DateTime property/ies '{string.Join(", ", nonUtcDates.Select(x => x.Name))}' have a value with a DateTimeKind other than UTC");
                }
            }
        }

        return base.SaveChangesAsync(cancellationToken);
    }
}
