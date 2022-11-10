import {
    Box,
    Button,
    FormControl,
    FormErrorMessage,
    FormLabel, Heading,
    Input,
    Select, SimpleGrid,
    useToast,
    VStack
} from "@chakra-ui/react";
import React, {useEffect, useState} from "react";
import {useFormik} from "formik";
import {castSettingsFromDto, initSettings, SettingsState} from "../../models/SettingState";
import {settingsScheme} from "../../models/Validation/SettingsValidation";
import {Link, useNavigate} from "react-router-dom";
import {Api} from "../../services/api/api-client";
import {FileSizeUnitsOptions} from "../../components/FileUnitSelector";
import {ValidationError} from "yup";
import {FormikCheckbox} from "../../components/FormikCheckbox";
import LoadingPage from "../../components/pages/loading-page";

export const Settings = () => {
    const [settings, setSettings] = useState<SettingsState>(initSettings);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [file, setFile] = useState<File | null>(null);
    const [image, setImage] = useState<string | undefined>(undefined);

    const formik = useFormik({
        initialValues: settings,
        enableReinitialize: true,
        validationSchema: settingsScheme,
        onSubmit: async values => {
            await saveSettings(values.minFileSize, values.maxFileSize,
                values.fileUnit,
                values.notificationFromEmailAddress,
                values.notificationFromDisplayName,
                values.inviteNotificationSendGridTemplateId,
                values.confirmationNotificationSendGridTemplateId,
                values.inviteTimeToLiveDays,
                values.phnLogo,
                values.allowCsvFiles,
                values.allowJsonFiles,
                values.allowZippedFiles,
                values.bounceNotificationEmailAddress);
        }
    })

    const api = new Api();
    api.baseUrl = process.env.REACT_APP_API_URL || '';

    const toast = useToast();
    const history = useNavigate();

    useEffect(() => {
        loadSettings();
    }, []);

    function loadSettings() {
        api.api.settingsList().then(response => {
                let data = castSettingsFromDto(response.data);
                setSettings(data);
                setImage(data.phnLogo);
                setIsLoading(false);
            }
        )
    }

    function whenFileUnitChanged(value: string) {
        formik.setFieldValue("fileUnit", value);

        if (value === "Select an option") {
            toast({
                title: 'Error',
                description: "File Size Unit cannot be 'Select an option'",
                status: 'error',
                duration: 5000,
                isClosable: true,
            });
        }
    }

    function convertToBase64(file: File): Promise<any> {
        return new Promise((resolve, reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);

            fileReader.onload = () => {
                // trim the data: prefix off
                resolve(fileReader.result?.toString().replace(/^data:.+;base64,/, ''));
            };

            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    }


    async function saveSettings(minFileSize: number, maxFileSize: number, fileUnit: string, notificationEmail: string, notificationName: string, inviteTemplate: string, confirmationTemplate: string, timeToLive: number, logo: string, allowCsv: boolean, allowJson: boolean, allowZipped: boolean, bounceNotificationEmailAddress: string) {

        let base64Logo: any = null;

        if (file !== null) {
            if (file.type === "image/png" || file.type === "image/jpeg") {
                base64Logo = await convertToBase64(file);
            } else {
                toast({
                    title: 'Error',
                    description: "File must be a valid image",
                    status: 'error',
                    duration: 5000,
                    isClosable: true,
                });
                return;
            }
        }

        if (file === null && settings.phnLogo) {
            base64Logo = settings.phnLogo;
        }

        if (!base64Logo){
            base64Logo = '';
        }

        if (!allowCsv && !allowJson && !allowZipped) {
            toast({
                title: 'Error',
                description: "At least one file type must be allowed",
                status: 'error',
                duration: 5000,
                isClosable: true,
            });
            return;
        }

        const settingsToUpdate = {
            MinFileSize: minFileSize,
            MaxFileSize: maxFileSize,
            FileUnit: fileUnit,
            NotificationFromEmailAddress: notificationEmail,
            NotificationFromDisplayName: notificationName,
            InviteNotificationSendGridTemplateId: inviteTemplate,
            ConfirmationNotificationSendGridTemplateId: confirmationTemplate,
            InviteTimeToLiveDays: timeToLive,
            PhnLogo: base64Logo,
            AllowCsvFiles: allowCsv,
            AllowJsonFiles: allowJson,
            AllowZippedFiles: allowZipped,
            BounceNotificationEmailAddress: bounceNotificationEmailAddress
        }

        try{
            // We do another just just in case the first one breaks
            if (fileUnit === "Select an option") {
                new ValidationError("Please select a file size unit", null, "fileUnit");
            }

            await api.api.settingsUpdate(settingsToUpdate);

            toast({
                title: "Settings saved.",
                description: "Your settings have been saved.",
                status: "success",
                duration: 9000,
                isClosable: true,
            });

            // We need to reload the website in order for the nav bar state to update
            window.location.reload();

        } catch (error: any){
            toast({
                title: 'Error',
                description: error.message,
                status: 'error',
                duration: 5000,
                isClosable: true,
            });
        }
    }

    async function whenLogoChanged(files: FileList | null) {
        if (files !== null) {
            let file = files[0];
            await formik.setFieldValue("phnLogo", file.name);
            // We set the File State here because formik doesn't pull the correct file data from values.phnLogo
            setFile(file);
            setImage(await convertToBase64(file));
        }
    }

    return (
    <Box>
        {isLoading &&
            <LoadingPage/>
        }
        {!isLoading &&
            <form onSubmit={formik.handleSubmit}>
                <Box p={4}>
                    <VStack spacing={10} alignItems={'flex-start'}>
                        <Heading size={'lg'}>File validation</Heading>
                        <SimpleGrid columns={3} spacing={10}>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.minFileSize && !!formik.errors.maxFileSize}>
                                    <FormLabel htmlFor="minFileSize">Minimum file size</FormLabel>
                                    <Input
                                        id="minFileSize"
                                        type="number"
                                        width={237}
                                        {...formik.getFieldProps('minFileSize')}
                                    />
                                    <FormErrorMessage>{formik.errors.minFileSize}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.maxFileSize && !!formik.errors.maxFileSize}>
                                    <FormLabel htmlFor="maxFileSize">Maximum file size</FormLabel>
                                    <Input
                                        id="maxFileSize"
                                        type="number"
                                        width={237}
                                        {...formik.getFieldProps('maxFileSize')}
                                    />
                                    <FormErrorMessage>{formik.errors.maxFileSize}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.fileUnit && !!formik.errors.fileUnit}>
                                    <FormLabel htmlFor="fileUnit">File size unit</FormLabel>
                                    <Select
                                        id="fileUnit"
                                        width={237}
                                        {...formik.getFieldProps('fileUnit')}
                                        onChange={(e) => whenFileUnitChanged(e.target.value)}
                                    >
                                        {FileSizeUnitsOptions()}
                                    </Select>
                                    <FormErrorMessage>{formik.errors.fileUnit}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl>
                                    <FormikCheckbox {...formik.getFieldProps('allowCsvFiles')}>
                                        Allow CSV files
                                    </FormikCheckbox>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl>
                                    <FormikCheckbox
                                        {...formik.getFieldProps('allowJsonFiles')}>
                                        Allow JSON files
                                    </FormikCheckbox>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl>
                                    <FormikCheckbox
                                        {...formik.getFieldProps('allowZippedFiles')}>
                                        Allow ZIP files
                                    </FormikCheckbox>
                                </FormControl>
                            </Box>
                        </SimpleGrid>
                        <Heading size={'lg'}>SendGrid options</Heading>
                        <SimpleGrid columns={3} spacing={10}>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.notificationFromEmailAddress && !!formik.errors.notificationFromEmailAddress}>
                                    <FormLabel htmlFor="notificationFromEmailAddress">SendGrid email address</FormLabel>
                                    <Input
                                        id="notificationFromEmailAddress"
                                        type="email"
                                        width={237}
                                        {...formik.getFieldProps('notificationFromEmailAddress')}
                                    />
                                    <FormErrorMessage>{formik.errors.notificationFromEmailAddress}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.notificationFromDisplayName && !!formik.errors.notificationFromDisplayName}>
                                    <FormLabel htmlFor="notificationFromDisplayName">Email address display name</FormLabel>
                                    <Input
                                        id="notificationFromDisplayName"
                                        type="text"
                                        width={237}
                                        {...formik.getFieldProps('notificationFromDisplayName')}
                                    />
                                    <FormErrorMessage>{formik.errors.notificationFromDisplayName}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.inviteNotificationSendGridTemplateId && !!formik.errors.inviteNotificationSendGridTemplateId}>
                                    <FormLabel htmlFor="inviteNotificationSendGridTemplateId">Invite sendgrid template ID</FormLabel>
                                    <Input
                                        id="inviteNotificationSendGridTemplateId"
                                        type="text"
                                        width={237}
                                        {...formik.getFieldProps('inviteNotificationSendGridTemplateId')}
                                    />
                                    <FormErrorMessage>{formik.errors.inviteNotificationSendGridTemplateId}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.confirmationNotificationSendGridTemplateId && !!formik.errors.confirmationNotificationSendGridTemplateId}>
                                    <FormLabel htmlFor="confirmationNotificationSendGridTemplateId">Confirmation sendgrid template ID</FormLabel>
                                    <Input
                                        id="confirmationNotificationSendGridTemplateId"
                                        type="text"
                                        width={237}
                                        {...formik.getFieldProps('confirmationNotificationSendGridTemplateId')}
                                    />
                                    <FormErrorMessage>{formik.errors.confirmationNotificationSendGridTemplateId}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl
                                    isInvalid={!!formik.touched.bounceNotificationEmailAddress && !!formik.errors.bounceNotificationEmailAddress}>
                                    <FormLabel htmlFor="bounceNotificationEmailAddress">Bounce notification email address</FormLabel>
                                    <Input
                                        id="bounceNotificationEmailAddress"
                                        type="string"
                                        width={237}
                                        {...formik.getFieldProps('bounceNotificationEmailAddress')}
                                    />
                                    <FormErrorMessage>{formik.errors.bounceNotificationEmailAddress}</FormErrorMessage>
                                </FormControl>
                            </Box>
                        </SimpleGrid>
                        <Heading size={'lg'}>Access token options</Heading>
                        <SimpleGrid columns={3} spacing={10}>
                            <Box>
                                <FormControl
                                    isInvalid={!!formik.touched.inviteTimeToLiveDays && !!formik.errors.inviteTimeToLiveDays}>
                                    <FormLabel htmlFor="inviteTimeToLiveDays">Invite time to live (Days)</FormLabel>
                                    <Input
                                        id="inviteTimeToLiveDays"
                                        type="number"
                                        width={237}
                                        {...formik.getFieldProps('inviteTimeToLiveDays')}
                                    />
                                    <FormErrorMessage>{formik.errors.inviteTimeToLiveDays}</FormErrorMessage>
                                </FormControl>
                            </Box>
                        </SimpleGrid>
                        <Heading size={'lg'}>Logo settings</Heading>
                        <VStack spacing={10}>
                            <Box>
                                <FormControl>
                                    <FormLabel htmlFor="phnLogo">Logo</FormLabel>
                                </FormControl>
                                <Input
                                    id="phnLogo"
                                    type="file"
                                    width={237}
                                    height={'auto'}
                                    onChange={(e) => whenLogoChanged(e.target.files)}
                                />
                            </Box>
                            {
                                image && (
                                    <Box>
                                        <FormControl>
                                            <FormLabel htmlFor="currentLogo">Current logo</FormLabel>
                                            <Box borderWidth={1}
                                                borderColor={'gray.600'}
                                                borderRadius={'20'}
                                                padding={'4'}>
                                                <img
                                                    id="currentLogo"
                                                    src={
                                                        `data:image/png;base64,${image}`
                                                    }
                                                    alt="Logo"
                                                    width={237}
                                                    height={'auto'}
                                                />
                                            </Box>
                                        </FormControl>
                                    </Box>
                                )
                            }
                        </VStack>
                        <SimpleGrid columns={1} spacing={5}>
                            <Box>
                                <Button
                                    colorScheme='blue'
                                    width={130}
                                    type='submit'>
                                    Save
                                </Button>
                            </Box>
                            <Box>
                                <Link to={`/programs`}>
                                    <Button width={130}>Back</Button>
                                </Link>
                            </Box>
                        </SimpleGrid>
                    </VStack>
                </Box>
            </form>
        }
    </Box>
    );
};
