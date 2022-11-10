using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddSupportForNotificationService : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "InviteFromAddress",
                table: "Settings",
                newName: "InviteSendGridTemplateId");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteFromAddress",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteSendGridTemplateId");

            migrationBuilder.AddColumn<string>(
                name: "InviteFromDisplayName",
                table: "Settings",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "InviteFromEmailAddress",
                table: "Settings",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Settings_InviteFromDisplayName",
                table: "ProgramSettingsSnapshot",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Settings_InviteFromEmailAddress",
                table: "ProgramSettingsSnapshot",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                table: "InviteeEvent",
                type: "uniqueidentifier",
                nullable: false,
                defaultValueSql: "(newid())",
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AddColumn<bool>(
                name: "IsSentToMailProvider",
                table: "AccessToken",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InviteFromDisplayName",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "InviteFromEmailAddress",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "Settings_InviteFromDisplayName",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "Settings_InviteFromEmailAddress",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "IsSentToMailProvider",
                table: "AccessToken");

            migrationBuilder.RenameColumn(
                name: "InviteSendGridTemplateId",
                table: "Settings",
                newName: "InviteFromAddress");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteSendGridTemplateId",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteFromAddress");

            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                table: "InviteeEvent",
                type: "uniqueidentifier",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldDefaultValueSql: "(newid())");
        }
    }
}
