﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using SecureFileUploader.Data;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    [DbContext(typeof(SecureFileUploaderContext))]
    [Migration("20221024022856_NullableLogo")]
    partial class NullableLogo
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("SecureFileUploader.Data.Models.AccessToken", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier")
                        .HasDefaultValueSql("(newid())");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("EndsOn")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("GeneratedOn")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("InviteeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<bool>("IsActive")
                        .HasColumnType("bit");

                    b.Property<bool>("IsSentToMailProvider")
                        .HasColumnType("bit");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("StartsOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("Token")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("InviteeId");

                    b.ToTable("AccessToken");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Invitee", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier")
                        .HasDefaultValueSql("(newid())");

                    b.Property<string>("ContainerName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("CrmId")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("IsFileUploaded")
                        .HasColumnType("bit");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PHN")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PracticeId")
                        .IsRequired()
                        .HasMaxLength(4000)
                        .HasColumnType("nvarchar(4000)");

                    b.Property<Guid>("ProgramId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("ReportingQuarter")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ProgramId");

                    b.ToTable("Invitee");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.InviteeEvent", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier")
                        .HasDefaultValueSql("(newid())");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("EventTypeId")
                        .HasColumnType("int");

                    b.Property<Guid>("InviteeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("PerformedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("PerformedOn")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("EventTypeId");

                    b.HasIndex("InviteeId");

                    b.ToTable("InviteeEvent");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.InviteeEventType", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("InviteeEventType");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Program", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier")
                        .HasDefaultValueSql("(newid())");

                    b.Property<DateTime>("CommencementDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsCommenced")
                        .HasColumnType("bit");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("SubmissionDeadline")
                        .HasColumnType("datetime2");

                    b.Property<string>("TimeZone")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Program");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.ProgramEvent", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("EventTypeId")
                        .HasColumnType("int");

                    b.Property<string>("PerformedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("PerformedOn")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("ProgramId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("EventTypeId");

                    b.HasIndex("ProgramId");

                    b.ToTable("ProgramEvent");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.ProgramEventType", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("ProgramEventType");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.ProgramSettingsSnapshot", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("ProgramId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("SnapshotOn")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("ProgramId");

                    b.ToTable("ProgramSettingsSnapshot");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.SendGridEmail", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier")
                        .HasDefaultValueSql("(newid())");

                    b.Property<DateTime?>("BouncedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("BouncedReason")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("InviteeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("SendGridId")
                        .HasMaxLength(500)
                        .HasColumnType("nvarchar(500)");

                    b.Property<DateTime>("SentOn")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("InviteeId");

                    b.ToTable("SendGridEmail");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Settings", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<bool>("AllowCsvFiles")
                        .HasColumnType("bit");

                    b.Property<bool>("AllowJsonFiles")
                        .HasColumnType("bit");

                    b.Property<bool>("AllowZippedFiles")
                        .HasColumnType("bit");

                    b.Property<string>("BounceNotificationEmailAddress")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ConfirmationNotificationSendGridTemplateId")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("FileUnit")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("InviteNotificationSendGridTemplateId")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("InviteTimeToLiveDays")
                        .HasColumnType("int");

                    b.Property<string>("LastModifiedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LastModifiedOn")
                        .HasColumnType("datetime2");

                    b.Property<int>("MaxFileSizeBytes")
                        .HasColumnType("int");

                    b.Property<int>("MinFileSizeBytes")
                        .HasColumnType("int");

                    b.Property<string>("NotificationFromDisplayName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("NotificationFromEmailAddress")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("PhnLogo")
                        .HasColumnType("varbinary(max)");

                    b.HasKey("Id");

                    b.ToTable("Settings");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.AccessToken", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.Invitee", "Invitee")
                        .WithMany("AccessTokens")
                        .HasForeignKey("InviteeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Invitee");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Invitee", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.Program", "Program")
                        .WithMany("Invitees")
                        .HasForeignKey("ProgramId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Program");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.InviteeEvent", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.InviteeEventType", "EventType")
                        .WithMany("InviteeEvents")
                        .HasForeignKey("EventTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SecureFileUploader.Data.Models.Invitee", "Invitee")
                        .WithMany("InviteeEvents")
                        .HasForeignKey("InviteeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("EventType");

                    b.Navigation("Invitee");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.ProgramEvent", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.ProgramEventType", "EventType")
                        .WithMany()
                        .HasForeignKey("EventTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SecureFileUploader.Data.Models.Program", "Program")
                        .WithMany("ProgramEvents")
                        .HasForeignKey("ProgramId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("EventType");

                    b.Navigation("Program");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.ProgramSettingsSnapshot", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.Program", "Program")
                        .WithMany()
                        .HasForeignKey("ProgramId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.OwnsOne("SecureFileUploader.Data.Models.SettingsValues", "Settings", b1 =>
                        {
                            b1.Property<Guid>("ProgramSettingsSnapshotId")
                                .HasColumnType("uniqueidentifier");

                            b1.Property<bool>("AllowCsvFiles")
                                .HasColumnType("bit");

                            b1.Property<bool>("AllowJsonFiles")
                                .HasColumnType("bit");

                            b1.Property<bool>("AllowZippedFiles")
                                .HasColumnType("bit");

                            b1.Property<string>("ConfirmationNotificationSendGridTemplateId")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<string>("FileUnit")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<string>("InviteNotificationSendGridTemplateId")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<int>("InviteTimeToLiveDays")
                                .HasColumnType("int");

                            b1.Property<int>("MaxFileSizeBytes")
                                .HasColumnType("int");

                            b1.Property<int>("MinFileSizeBytes")
                                .HasColumnType("int");

                            b1.Property<string>("NotificationFromDisplayName")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<string>("NotificationFromEmailAddress")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<byte[]>("PhnLogo")
                                .HasColumnType("varbinary(max)");

                            b1.HasKey("ProgramSettingsSnapshotId");

                            b1.ToTable("ProgramSettingsSnapshot");

                            b1.WithOwner()
                                .HasForeignKey("ProgramSettingsSnapshotId");
                        });

                    b.Navigation("Program");

                    b.Navigation("Settings")
                        .IsRequired();
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.SendGridEmail", b =>
                {
                    b.HasOne("SecureFileUploader.Data.Models.Invitee", "Invitee")
                        .WithMany()
                        .HasForeignKey("InviteeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Invitee");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Invitee", b =>
                {
                    b.Navigation("AccessTokens");

                    b.Navigation("InviteeEvents");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.InviteeEventType", b =>
                {
                    b.Navigation("InviteeEvents");
                });

            modelBuilder.Entity("SecureFileUploader.Data.Models.Program", b =>
                {
                    b.Navigation("Invitees");

                    b.Navigation("ProgramEvents");
                });
#pragma warning restore 612, 618
        }
    }
}
