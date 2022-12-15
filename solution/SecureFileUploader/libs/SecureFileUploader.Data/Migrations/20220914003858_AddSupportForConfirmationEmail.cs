using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddSupportForConfirmationEmail : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "InviteSendGridTemplateId",
                table: "Settings",
                newName: "NotificationFromEmailAddress");

            migrationBuilder.RenameColumn(
                name: "InviteFromEmailAddress",
                table: "Settings",
                newName: "NotificationFromDisplayName");

            migrationBuilder.RenameColumn(
                name: "InviteFromDisplayName",
                table: "Settings",
                newName: "InviteNotificationSendGridTemplateId");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteSendGridTemplateId",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_NotificationFromEmailAddress");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteFromEmailAddress",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_NotificationFromDisplayName");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteFromDisplayName",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteNotificationSendGridTemplateId");

            migrationBuilder.AddColumn<string>(
                name: "ConfirmationNotificationSendGridTemplateId",
                table: "Settings",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Settings_ConfirmationNotificationSendGridTemplateId",
                table: "ProgramSettingsSnapshot",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ConfirmationNotificationSendGridTemplateId",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "Settings_ConfirmationNotificationSendGridTemplateId",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.RenameColumn(
                name: "NotificationFromEmailAddress",
                table: "Settings",
                newName: "InviteSendGridTemplateId");

            migrationBuilder.RenameColumn(
                name: "NotificationFromDisplayName",
                table: "Settings",
                newName: "InviteFromEmailAddress");

            migrationBuilder.RenameColumn(
                name: "InviteNotificationSendGridTemplateId",
                table: "Settings",
                newName: "InviteFromDisplayName");

            migrationBuilder.RenameColumn(
                name: "Settings_NotificationFromEmailAddress",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteSendGridTemplateId");

            migrationBuilder.RenameColumn(
                name: "Settings_NotificationFromDisplayName",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteFromEmailAddress");

            migrationBuilder.RenameColumn(
                name: "Settings_InviteNotificationSendGridTemplateId",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_InviteFromDisplayName");
        }
    }
}
