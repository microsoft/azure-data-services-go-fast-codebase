using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class RenameMinAndMaxFileSize : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MinFileSizeBytes",
                table: "Settings",
                newName: "MinFileSize");

            migrationBuilder.RenameColumn(
                name: "MaxFileSizeBytes",
                table: "Settings",
                newName: "MaxFileSize");

            migrationBuilder.RenameColumn(
                name: "Settings_MinFileSizeBytes",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_MinFileSize");

            migrationBuilder.RenameColumn(
                name: "Settings_MaxFileSizeBytes",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_MaxFileSize");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MinFileSize",
                table: "Settings",
                newName: "MinFileSizeBytes");

            migrationBuilder.RenameColumn(
                name: "MaxFileSize",
                table: "Settings",
                newName: "MaxFileSizeBytes");

            migrationBuilder.RenameColumn(
                name: "Settings_MinFileSize",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_MinFileSizeBytes");

            migrationBuilder.RenameColumn(
                name: "Settings_MaxFileSize",
                table: "ProgramSettingsSnapshot",
                newName: "Settings_MaxFileSizeBytes");
        }
    }
}
