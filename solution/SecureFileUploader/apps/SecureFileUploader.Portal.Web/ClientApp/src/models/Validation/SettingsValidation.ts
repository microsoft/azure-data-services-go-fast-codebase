import {number, object, ref, string, ValidationError} from 'yup';
import isEmailValidator from 'validator/lib/isEmail';


export const settingsScheme = object().shape({
    minFileSize: number().required("Min File Size is a required field").max(ref('maxFileSize'), "Min File Size must be less than Max File Size"),
    maxFileSize: number().required("Max File Size is a required field").min(ref('minFileSize'), "Max File Size must be greater than Min File Size"),
    fileUnit: string().required("File Units is a required field"),
    notificationFromEmailAddress: string().required("Notification Email Address is a required field")
        .email("Invalid email format")
        // Yup doesn't have a good email validation so we use a different email validator here
        // https://github.com/jquense/yup/issues/507#issuecomment-1033404877
        .test("isValid", (message) => `${message.path} is invalid`, (value) => value ? isEmailValidator(value) : new ValidationError("Invalid Value")),
    notificationFromDisplayName: string().required("Notification Email Display Name is a required field"),
    inviteNotificationSendGridTemplateId: string().required("Invite Email SendGrid TemplateId is a required field"),
    confirmationNotificationSendGridTemplateId: string().required("Confirmation Email SendGrid TemplateId is a required field"),
    inviteTimeToLiveDays: string().required("Invite TimeTo Live Days is a required field"),
});
