using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class UpdateSettingsAndSettingsSnapshot : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CreatedBy",
                table: "Settings",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedOn",
                table: "Settings",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "LastModifiedBy",
                table: "Settings",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "LastModifiedOn",
                table: "Settings",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "CreatedBy",
                table: "ProgramSettingsSnapshot",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedOn",
                table: "ProgramSettingsSnapshot",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "LastModifiedBy",
                table: "ProgramSettingsSnapshot",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "LastModifiedOn",
                table: "ProgramSettingsSnapshot",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CreatedBy",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "CreatedOn",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "LastModifiedBy",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "LastModifiedOn",
                table: "Settings");

            migrationBuilder.DropColumn(
                name: "CreatedBy",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "CreatedOn",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "LastModifiedBy",
                table: "ProgramSettingsSnapshot");

            migrationBuilder.DropColumn(
                name: "LastModifiedOn",
                table: "ProgramSettingsSnapshot");
        }
    }
}
