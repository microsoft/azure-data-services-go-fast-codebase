using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AllowedFileTypes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "AllowCsvFiles",
                table: "Settings",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "AllowJsonFiles",
                table: "Settings",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "AllowZippedFiles",
                table: "Settings",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Settings_AllowCsvFiles",
                table: "ProgramSettingsSnapshot",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Settings_AllowJsonFiles",
                table: "ProgramSettingsSnapshot",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Settings_AllowZippedFiles",
                table: "ProgramSettingsSnapshot",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AllowCsvFiles",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "AllowJsonFiles",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "AllowZippedFiles",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "Settings_AllowCsvFiles",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "Settings_AllowJsonFiles",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "Settings_AllowZippedFiles",
                table: "ProgramSettingsSnapshot");
        }
    }
}
