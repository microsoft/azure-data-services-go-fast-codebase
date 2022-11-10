using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddSendGridMessageTracking : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "SendGridEmail",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "(newid())"),
                    InviteeId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    SendGridId = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    SentOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    BouncedOn = table.Column<DateTime>(type: "datetime2", nullable: true),
                    BouncedReason = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastModifiedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SendGridEmail", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SendGridEmail_Invitee_InviteeId",
                        column: x => x.InviteeId,
                        principalTable: "Invitee",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_SendGridEmail_InviteeId",
                table: "SendGridEmail",
                column: "InviteeId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SendGridEmail");
        }
    }
}
