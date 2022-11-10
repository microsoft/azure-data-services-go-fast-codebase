using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddCommencementAndIsFileUploaded : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IsSent",
                table: "Program",
                newName: "IsCommenced");

            migrationBuilder.AddColumn<DateTime>(
                name: "CommencementDate",
                table: "Program",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<bool>(
                name: "IsFileUploaded",
                table: "Invitee",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CommencementDate",
                table: "Program");

            migrationBuilder.DropColumn(
                name: "IsFileUploaded",
                table: "Invitee");

            migrationBuilder.RenameColumn(
                name: "IsCommenced",
                table: "Program",
                newName: "IsSent");
        }
    }
}
