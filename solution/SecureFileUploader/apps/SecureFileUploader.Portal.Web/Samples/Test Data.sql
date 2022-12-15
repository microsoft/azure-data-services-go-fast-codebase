DELETE FROM Program;

DELETE FROM InviteeEvent;
DELETE FROM AccessToken;
DELETE FROM Invitee;

DELETE FROM InviteeEventType;

DELETE FROM Settings;

DECLARE @utcNow DATETIME
SELECT @utcNow = GETDATE() AT TIME ZONE 'W. Australia Standard Time' AT TIME ZONE 'UTC'

INSERT INTO [dbo].[Program]
    ([Id], [Name], [CommencementDate], [SubmissionDeadline], [IsCommenced], [Timezone], [CreatedOn], [CreatedBy], [LastModifiedOn], [LastModifiedBy])
VALUES
    ('29c5f646-9a61-4cc1-931a-081f4ec37e3c', 'Pending program', @utcNow + 2, @utcNow + 60, 0, 'Australia/Perth', @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('6df821c5-0586-46b0-be73-484d3aac7458', 'Open program', @utcNow - 30, @utcNow + 30, 1, 'Australia/Perth', @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('740bb128-18b6-4955-a054-bb58206ff1f9', 'Closed program', @utcNow - 60, @utcNow - 1, 1, 'Australia/Perth', @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER)

INSERT INTO [dbo].[Invitee]
    ([Id], [ProgramId], [CrmId], [PHN], [PracticeId], [Name], [ContainerName], [Email], [IsFileUploaded], [CreatedOn], [CreatedBy], [LastModifiedOn], [LastModifiedBy])
VALUES
    ('69b8fa7b-879c-46dc-84bd-6d4cb1ed0042', '29c5f646-9a61-4cc1-931a-081f4ec37e3c', 'O01697', 'CountryWA', 'BPS7274', 'Test Practice_1', 'TestPractice_1', 'person@emaple.com', 0, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('bf91fd8c-5d55-49e0-a082-36c6aaf1ee16', '29c5f646-9a61-4cc1-931a-081f4ec37e3c', 'O01679', 'PerthNorth', '534', 'Test Practice_2', 'TestPractice_2', 'person@emaple.com', 0, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('9f787955-f1f7-4eb4-a771-2aad159399f0', '6df821c5-0586-46b0-be73-484d3aac7458', 'O01697', 'CountryWA', 'BPS7274', 'Test Practice_1', 'TestPractice_1', 'person@emaple.com', 1, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('9fa6b561-f136-42e7-8265-0cc447b98a89', '6df821c5-0586-46b0-be73-484d3aac7458', 'O01679', 'PerthNorth', '534', 'Test Practice_2', 'TestPractice_2', 'person@emaple.com', 1, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('609f1dd4-b8fc-4a04-b5c4-bc690cfa8666', '740bb128-18b6-4955-a054-bb58206ff1f9', 'O01697', 'CountryWA', 'BPS7274', 'Test Practice_1', 'TestPractice_1', 'person@emaple.com', 0, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER),
    ('0a39c025-7ecc-4434-be6b-3358b7b590df', '740bb128-18b6-4955-a054-bb58206ff1f9', 'O01679', 'PerthNorth', '534', 'Test Practice_2', 'TestPractice_2', 'person@emaple.com', 1, @utcNow, SYSTEM_USER, @utcNow, SYSTEM_USER)

INSERT INTO [dbo].[Settings]
    ([Id], [MinFileSize], [MaxFileSize], [NotificationFromEmailAddress], [NotificationFromDisplayName], [InviteNotificationSendGridTemplateId], [InviteTimeToLiveDays], [ConfirmationNotificationSendGridTemplateId])
VALUES
    -- replace with real SendGrid id's
    ('ed6e9e59-1c8a-45c0-a5ad-0a64311a3e02', 0, 0, 'person@emaple.com', 'Example Person', 'd-7703b1a58b0d49be91cfe14a89570a9a', 7, 'd-0262a89928444797ba826ab8a6cee482')
