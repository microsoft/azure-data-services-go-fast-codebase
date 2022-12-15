import {
    Box,
    Button,
    FormControl,
    FormLabel,
    Heading,
    HStack,
    Input,
    Spacer,
    useToast,
    FormErrorMessage,
    Select,
    VStack
} from '@chakra-ui/react';
import {useState} from 'react';
import { Link, useNavigate } from 'react-router-dom';
import FileDrop from '../../components/fileDrop/FileDrop';
import { ImportInviteeList } from '../../components/ImportInviteeList';
import {
    initProgram,
    InviteeState,
} from '../../models/ProgramState';
import { programScheme } from '../../models/Validation/programValidation';
import { Api } from '../../services/api/api-client';
import { useFormik } from 'formik';
import {convertSpecificTimeZoneDateTimeToUtcDateTime} from "../../services/DateConversion";
import {TimezoneOptions} from "../../components/TimeZoneSelectorOptions";

export const CreateProgram = () => {
    const [invitees, setInvitees] = useState<InviteeState[]>([]);
    const [file, setFile] = useState<File | null>(null);

    const api = new Api();
    api.baseUrl = process.env.REACT_APP_API_URL || '';

    const toast = useToast();
    const history = useNavigate();

    async function createProgram(name: string, commencementDate: string, submissionDeadline: string, timeZone: string) {
        const programToSend = {
            Name: name,
            CommencementDate: commencementDate,
            SubmissionDeadline: submissionDeadline,
            TimeZone: timeZone,
            File: file as File,
        }

        try {
            const program = await api.api.programsFileCreate(programToSend);

            toast({
                title: 'Program created',
                description: 'Program created successfully',
                status: 'success',
                duration: 5000,
                isClosable: true,
            });

            history(`/programs/${program.data.id}`);

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

    const formik = useFormik({
        initialValues: {...initProgram},
        validationSchema: programScheme,
        onSubmit: async values => {
            await createProgram(values.name,
                convertSpecificTimeZoneDateTimeToUtcDateTime(values.opens, values.timeZone),
                convertSpecificTimeZoneDateTimeToUtcDateTime(values.closes, values.timeZone),
                values.timeZone);
        },
    });

    return (
        <Box>
            <form onSubmit={formik.handleSubmit}>
                <Heading size={'lg'}>Program</Heading>
                <Box p={4}>
                    <VStack width={'lg'} spacing={'5'}>
                        <FormControl isInvalid={!!formik.touched.name && !!formik.errors.name}>
                            <FormLabel htmlFor="name">Name</FormLabel>
                            <Input
                                id="name"
                                type="text"
                                width={'lg'}
                                placeholder="Name"
                                {...formik.getFieldProps('name')}
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
                                        placeholder="Opens"
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
                                        placeholder="Closes"
                                        {...formik.getFieldProps('closes')}
                                    />
                                    <FormErrorMessage>{formik.errors.closes}</FormErrorMessage>
                                </FormControl>
                            </Box>
                        </HStack>
                        <Box width={'lg'}>
                            <FormControl>
                                <FormLabel htmlFor="Time zone">Timezone</FormLabel>
                                <Select
                                    id="timeZone"
                                    {...formik.getFieldProps('timeZone')}>
                                    {/*Use the timezones from TimezoneOptions()*/}
                                    {TimezoneOptions()}
                                </Select>
                                <FormErrorMessage>{formik.errors.timeZone}</FormErrorMessage>
                            </FormControl>
                        </Box>
                    </VStack>
                </Box>
                <br></br>
                <Heading size={'lg'}>Invitees</Heading>
                {invitees.length === 0 ? (
                    <>
                        <Box p={4}>
                            <Box>
                                Drag a CSV file in to the file drop box to upload a list of invitees
                            </Box>
                            <br />
                            <FileDrop
                                setStateInvitees={setInvitees}
                                setStateFile={setFile}
                            />
                        </Box>
                    </>
                ) : (
                    <>
                        <Box p={4}>
                            <HStack>
                                <Box>
                                    Review your invitees below and create your
                                    program. Alternatively, clear your invitee list
                                    and reimport them.
                                </Box>
                                <Spacer></Spacer>
                                <Box>
                                    <Button
                                        colorScheme="blue"
                                        width={150}
                                        onClick={() => {
                                            setInvitees([]);
                                        }}
                                    >
                                        Clear invitees
                                    </Button>
                                </Box>
                            </HStack>
                            <ImportInviteeList
                                invitees={invitees}
                            ></ImportInviteeList>
                        </Box>
                    </>
                )}

                <HStack>
                    {invitees.length !== 0 &&
                        <Button colorScheme="blue" width={150} type={"submit"}>Create</Button>
                    }
                    <Link to={`/programs`}>
                        <Button width={150}>Cancel</Button>
                    </Link>
                </HStack>
            </form>
        </Box>
    );
};
