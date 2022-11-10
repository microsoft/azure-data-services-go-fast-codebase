using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class Initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "InviteeEventType",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InviteeEventType", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Program",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SubmissionDeadline = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsSent = table.Column<bool>(type: "bit", nullable: false),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastModifiedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Program", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ProgramEventTypeModel",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProgramEventTypeModel", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Settings",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    MinFileSizeBytes = table.Column<int>(type: "int", nullable: false),
                    MaxFileSizeBytes = table.Column<int>(type: "int", nullable: false),
                    InviteFromAddress = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    InviteTimeToLiveDays = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Settings", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Invitee",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ProgramId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CrmId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PHN = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ContainerName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastModifiedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Invitee", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Invitee_Program_ProgramId",
                        column: x => x.ProgramId,
                        principalTable: "Program",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProgramSettingsSnapshot",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ProgramId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Settings_MinFileSizeBytes = table.Column<int>(type: "int", nullable: false),
                    Settings_MaxFileSizeBytes = table.Column<int>(type: "int", nullable: false),
                    Settings_InviteFromAddress = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Settings_InviteTimeToLiveDays = table.Column<int>(type: "int", nullable: false),
                    SnapshotOn = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProgramSettingsSnapshot", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProgramSettingsSnapshot_Program_ProgramId",
                        column: x => x.ProgramId,
                        principalTable: "Program",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AccessToken",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    InviteeId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    Token = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    GeneratedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    StartsOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndsOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastModifiedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AccessToken", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AccessToken_Invitee_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Invitee",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Email",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    InviteeId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    SentOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Email", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Email_Invitee_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Invitee",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "InviteeEvent",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    InviteeId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    EventTypeId = table.Column<int>(type: "int", nullable: false),
                    PerformedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PerformedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InviteeEvent", x => x.Id);
                    table.ForeignKey(
                        name: "FK_InviteeEvent_Invitee_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Invitee",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_InviteeEvent_InviteeEventType_EventTypeId",
                        column: x => x.EventTypeId,
                        principalTable: "InviteeEventType",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProgramEventModel",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    InviteeId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    EventTypeId = table.Column<int>(type: "int", nullable: false),
                    PerformedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PerformedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProgramEventModel", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProgramEventModel_Invitee_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Invitee",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProgramEventModel_ProgramEventTypeModel_EventTypeId",
                        column: x => x.EventTypeId,
                        principalTable: "ProgramEventTypeModel",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AccessToken_InviteeId",
                table: "AccessToken",
                column: "InviteeId");

            migrationBuilder.CreateIndex(
                name: "IX_Email_InviteeId",
                table: "Email",
                column: "InviteeId");

            migrationBuilder.CreateIndex(
                name: "IX_Invitee_ProgramId",
                table: "Invitee",
                column: "ProgramId");

            migrationBuilder.CreateIndex(
                name: "IX_InviteeEvent_EventTypeId",
                table: "InviteeEvent",
                column: "EventTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_InviteeEvent_InviteeId",
                table: "InviteeEvent",
                column: "InviteeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProgramEventModel_EventTypeId",
                table: "ProgramEventModel",
                column: "EventTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProgramEventModel_InviteeId",
                table: "ProgramEventModel",
                column: "InviteeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProgramSettingsSnapshot_ProgramId",
                table: "ProgramSettingsSnapshot",
                column: "ProgramId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AccessToken");

            migrationBuilder.DropTable(
                name: "Email");

            migrationBuilder.DropTable(
                name: "InviteeEvent");

            migrationBuilder.DropTable(
                name: "ProgramEventModel");

            migrationBuilder.DropTable(
                name: "ProgramSettingsSnapshot");

            migrationBuilder.DropTable(
                name: "Settings");

            migrationBuilder.DropTable(
                name: "InviteeEventType");

            migrationBuilder.DropTable(
                name: "Invitee");

            migrationBuilder.DropTable(
                name: "ProgramEventTypeModel");

            migrationBuilder.DropTable(
                name: "Program");
        }
    }
}
