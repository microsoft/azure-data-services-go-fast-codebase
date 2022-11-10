using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class RenameProgramEventModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEventModel_Program_ProgramId",
                table: "ProgramEventModel");

            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEventModel_ProgramEventTypeModel_EventTypeId",
                table: "ProgramEventModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProgramEventTypeModel",
                table: "ProgramEventTypeModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProgramEventModel",
                table: "ProgramEventModel");

            migrationBuilder.RenameTable(
                name: "ProgramEventTypeModel",
                newName: "ProgramEventType");

            migrationBuilder.RenameTable(
                name: "ProgramEventModel",
                newName: "ProgramEvent");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEventModel_ProgramId",
                table: "ProgramEvent",
                newName: "IX_ProgramEvent_ProgramId");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEventModel_EventTypeId",
                table: "ProgramEvent",
                newName: "IX_ProgramEvent_EventTypeId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProgramEventType",
                table: "ProgramEventType",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProgramEvent",
                table: "ProgramEvent",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEvent_Program_ProgramId",
                table: "ProgramEvent",
                column: "ProgramId",
                principalTable: "Program",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEvent_ProgramEventType_EventTypeId",
                table: "ProgramEvent",
                column: "EventTypeId",
                principalTable: "ProgramEventType",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEvent_Program_ProgramId",
                table: "ProgramEvent");

            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEvent_ProgramEventType_EventTypeId",
                table: "ProgramEvent");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProgramEventType",
                table: "ProgramEventType");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProgramEvent",
                table: "ProgramEvent");

            migrationBuilder.RenameTable(
                name: "ProgramEventType",
                newName: "ProgramEventTypeModel");

            migrationBuilder.RenameTable(
                name: "ProgramEvent",
                newName: "ProgramEventModel");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEvent_ProgramId",
                table: "ProgramEventModel",
                newName: "IX_ProgramEventModel_ProgramId");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEvent_EventTypeId",
                table: "ProgramEventModel",
                newName: "IX_ProgramEventModel_EventTypeId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProgramEventTypeModel",
                table: "ProgramEventTypeModel",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProgramEventModel",
                table: "ProgramEventModel",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEventModel_Program_ProgramId",
                table: "ProgramEventModel",
                column: "ProgramId",
                principalTable: "Program",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEventModel_ProgramEventTypeModel_EventTypeId",
                table: "ProgramEventModel",
                column: "EventTypeId",
                principalTable: "ProgramEventTypeModel",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
