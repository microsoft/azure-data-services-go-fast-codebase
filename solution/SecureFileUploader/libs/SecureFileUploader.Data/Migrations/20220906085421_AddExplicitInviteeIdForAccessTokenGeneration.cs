using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddExplicitInviteeIdForAccessTokenGeneration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                table: "AccessToken",
                type: "uniqueidentifier",
                nullable: false,
                defaultValueSql: "(newid())",
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                table: "AccessToken",
                type: "uniqueidentifier",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldDefaultValueSql: "(newid())");
        }
    }
}
