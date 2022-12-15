import {Settings, SettingsSummary} from "../services/api/api-client";

export type SettingsState = {
    minFileSize: number;
    maxFileSize: number;
    fileUnit: string;
    notificationFromEmailAddress: string;
    notificationFromDisplayName: string;
    inviteNotificationSendGridTemplateId: string;
    confirmationNotificationSendGridTemplateId: string;
    inviteTimeToLiveDays: number;
    phnLogo: string;
    allowCsvFiles: boolean;
    allowJsonFiles: boolean;
    allowZippedFiles: boolean;
    bounceNotificationEmailAddress: string;
};

export const initSettings: SettingsState = {
    minFileSize: 0,
    maxFileSize: 0,
    fileUnit: '',
    notificationFromEmailAddress: '',
    notificationFromDisplayName: '',
    inviteNotificationSendGridTemplateId: '',
    confirmationNotificationSendGridTemplateId: '',
    inviteTimeToLiveDays: 0,
    phnLogo: '',
    allowCsvFiles: false,
    allowJsonFiles: false,
    allowZippedFiles: false,
    bounceNotificationEmailAddress: ''
};

export function castSettingsFromDto(settingsDto: Settings): SettingsState {
    return {
        minFileSize: settingsDto.minFileSize,
        maxFileSize: settingsDto.maxFileSize,
        fileUnit: settingsDto.fileUnit,
        notificationFromEmailAddress: settingsDto.notificationFromEmailAddress,
        notificationFromDisplayName: settingsDto.notificationFromDisplayName,
        inviteNotificationSendGridTemplateId: settingsDto.inviteNotificationSendGridTemplateId,
        confirmationNotificationSendGridTemplateId: settingsDto.confirmationNotificationSendGridTemplateId,
        inviteTimeToLiveDays: settingsDto.inviteTimeToLiveDays,
        phnLogo: settingsDto.phnLogo || '',
        allowCsvFiles: settingsDto.allowCsvFiles,
        allowJsonFiles: settingsDto.allowJsonFiles,
        allowZippedFiles: settingsDto.allowZippedFiles,
        bounceNotificationEmailAddress: settingsDto.bounceNotificationEmailAddress
    }
}

export function castLogoFromDto(settingsDto: SettingsSummary): SettingsSummary {
    return {
        logo: settingsDto.logo || ''
    }
}
