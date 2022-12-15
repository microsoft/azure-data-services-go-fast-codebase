import {
    Box,
    Button,
    FormControl,
    FormLabel,
    Heading,
    HStack,
    Input,
    useToast,
    FormErrorMessage, VStack, Select
} from '@chakra-ui/react';
import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import {
    CloudUploadIcon,
    EmailReturnedIcon,
    PersonAltIcon,
} from '../../components/Icons';
import { InviteeList } from '../../components/InviteeList';
import {
    castProgramFromDto,
    initProgram,
    ProgramState,
    ProgramStatus,
} from '../../models/ProgramState';
import { programScheme } from '../../models/Validation/programValidation';
import { Api } from '../../services/api/api-client';
import { useFormik } from 'formik';
import {
    convertSpecificTimeZoneDateTimeToUtcDateTime, convertUtcDateTimeToSpecificTimeZoneDateTime,
} from "../../services/DateConversion";
import {TimezoneOptions} from "../../components/TimeZoneSelectorOptions";

export function EditProgram() {
    const params = useParams();
    const programId = String(params.id);

    const [program, setProgram] = useState<ProgramState>(initProgram);

    const formik = useFormik({
        initialValues: program,
        enableReinitialize: true,
        validationSchema: programScheme,
        onSubmit: async values => {
            await saveProgram(values.name,
                convertSpecificTimeZoneDateTimeToUtcDateTime(values.opens, values.timeZone),
                convertSpecificTimeZoneDateTimeToUtcDateTime(values.closes, values.timeZone),
                values.timeZone);
        },
    });

    const api = new Api();
    api.baseUrl = process.env.REACT_APP_API_URL || '';

    useEffect(() => {
        loadProgram();
    }, [programId]);

    const toast = useToast();

    function loadProgram() {
        api.api.programsDetail(programId).then((response) => {
            let data = castProgramFromDto(response.data);
            data.opens = convertUtcDateTimeToSpecificTimeZoneDateTime(data.opens, data.timeZone);
            data.closes = convertUtcDateTimeToSpecificTimeZoneDateTime(data.closes, data.timeZone);
            setProgram(data);
        });
    }

    function toggleInviteeDetailRow(index: number, isOpen: boolean) {
        const invitees = program.invitees.slice();
        invitees[index].isOpen = !isOpen;
        invitees[index].isLoaded = true;
        setProgram({ ...program, invitees: invitees });
    }

    async function saveProgram(name: string, commencementDate: string, submissionDeadline: string, timeZone: string) {
        const programToUpdate = {
            Name: name,
            CommencementDate: commencementDate,
            SubmissionDeadline: submissionDeadline,
            TimeZone: timeZone
        }

        try {

            await api.api.programsUpdate(programId, programToUpdate);

            toast({
                title: 'Program updated',
                description: 'Your program has been successfully updated',
                status: 'success',
                duration: 9000,
                isClosable: true,
            });

        } catch (error: any) {
            toast({
                title: 'Error',
                description: error.message,
                status: 'error',
                duration: 5000,
                isClosable: true,
            });
        }
    }
    return (
        <Box>
            <Heading size={'lg'}>Program</Heading>
            <form onSubmit={formik.handleSubmit}>
                <Box p={4}>
                    <VStack spacing={'4'} width={'lg'}>
                        <FormControl isInvalid={!!formik.touched.name && !!formik.errors.name}>
                            <FormLabel htmlFor="name">Name</FormLabel>
                            <Input
                                id="name"
                                type="text"
                                width={'lg'}
                                {...formik.getFieldProps('name')}
                                placeholder={formik.values.name}
                            />
                            <FormErrorMessage>{formik.errors.name}</FormErrorMessage>
                        </FormControl>
                        <HStack spacing={10}>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.opens && !!formik.errors.opens}>
                                    <FormLabel htmlFor="opens">Opens</FormLabel>
                                    <Input
                                        id="opens"
                                        type="datetime-local"
                                        width={237}
                                        {...formik.getFieldProps('opens')}
                                    />
                                    <FormErrorMessage>{formik.errors.opens}</FormErrorMessage>
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl isInvalid={!!formik.touched.closes && !!formik.errors.closes}>
                                    <FormLabel htmlFor="closes">Closes</FormLabel>
                                    <Input
                                        id="closes"
                                        type="datetime-local"
                                        width={237}
                                        {...formik.getFieldProps('closes')}
                                    />
                                    <FormErrorMessage>{formik.errors.closes}</FormErrorMessage>
                                </FormControl>
                            </Box>
                        </HStack>
                        <Box width={'lg'}>
                            <FormControl>
                                <FormLabel htmlFor="timeZone">Time Zone</FormLabel>
                                <Select
                                    id="timeZone"
                                    {...formik.getFieldProps('timeZone')}>
                                    {/*Use the timezones from TimezoneOptions()*/}
                                    {TimezoneOptions()}
                                </Select>
                                <FormErrorMessage>{formik.errors.timeZone}</FormErrorMessage>
                            </FormControl>
                        </Box>
                        <HStack spacing={20} width={'lg'}>
                            <Box>
                                <FormControl>
                                    <FormLabel>Invites sent</FormLabel>
                                    <PersonAltIcon></PersonAltIcon>
                                    {program.invitesSent}
                                </FormControl>
                            </Box>
                            <Box>
                                <FormControl>
                                    <FormLabel>Files uploaded</FormLabel>
                                    <CloudUploadIcon></CloudUploadIcon>
                                    {program.invitesUploaded}
                                </FormControl>
                            </Box>
                        </HStack>
                    </VStack>
                </Box>
                <br></br>
                <InviteeList
                    program={program}
                    toggleInviteeDetailRow={toggleInviteeDetailRow}
                ></InviteeList>
                <HStack>
                    {program.status === ProgramStatus.Pending ? (
                        <Button
                            colorScheme="blue"
                            width={130}
                            type={"submit"}
                        >
                            Save
                        </Button>
                    ) : (
                        <></>
                    )}
                    <Link to={`/programs`}>
                        <Button width={130} colorScheme="gray">
                            Back
                        </Button>
                    </Link>
                </HStack>
            </form>
        </Box>
    );
}
