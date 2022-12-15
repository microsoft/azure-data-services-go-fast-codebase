using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SecureFileUploader.Data.Migrations
{
    public partial class AddProgramToProgramEvent : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEventModel_Invitee_InviteeId",
                table: "ProgramEventModel");

            migrationBuilder.RenameColumn(
                name: "InviteeId",
                table: "ProgramEventModel",
                newName: "ProgramId");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEventModel_InviteeId",
                table: "ProgramEventModel",
                newName: "IX_ProgramEventModel_ProgramId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEventModel_Program_ProgramId",
                table: "ProgramEventModel",
                column: "ProgramId",
                principalTable: "Program",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProgramEventModel_Program_ProgramId",
                table: "ProgramEventModel");

            migrationBuilder.RenameColumn(
                name: "ProgramId",
                table: "ProgramEventModel",
                newName: "InviteeId");

            migrationBuilder.RenameIndex(
                name: "IX_ProgramEventModel_ProgramId",
                table: "ProgramEventModel",
                newName: "IX_ProgramEventModel_InviteeId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProgramEventModel_Invitee_InviteeId",
                table: "ProgramEventModel",
                column: "InviteeId",
                principalTable: "Invitee",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
