import { SearchIcon } from '@chakra-ui/icons';
import {
    Table,
    Thead,
    Tr,
    Th,
    Tbody,
    Td,
    Box,
    Center,
    Input,
    Button,
    Flex,
    Spacer,
    InputGroup,
    InputRightElement,
    Badge,
    HStack,
    Checkbox,
} from '@chakra-ui/react';
import moment from 'moment';
import { useEffect, useState } from 'react';
import { Link, Router } from 'react-router-dom';
import { CloudUploadIcon, PersonAltIcon } from '../../components/Icons';
import {
    Api,
    ProgramStatus,
    ProgramSummary,
} from '../../services/api/api-client';

export const ListPrograms = () => {
    const [programSummaryList, setProgramList] = useState<ProgramSummary[]>();
    const [searchTerm, setSearchTerm] = useState('');
    const [showClosedPrograms, setShowClosedPrograms] = useState(false);

    // TODO: can this be tidied up with useMemo?
    const api = new Api();
    api.baseUrl = process.env.REACT_APP_API_URL || '';

    useEffect(() => {
        api.api
            .programsSearchCreate(
                { showClosedPrograms: showClosedPrograms },
                { searchTerm: searchTerm }
            )
            .then((response) => {
                setProgramList(response.data);
            });
        // do not re-run - could be neater. Tie to api.program somehow?
    }, [searchTerm, showClosedPrograms]);

    function calculateUploadPercentage(
        invitees: number,
        uploaded: number
    ): string {
        return ((uploaded / invitees) * 100).toFixed(0) + '%';
    }

    function getStatusTag(status: ProgramStatus) {
        switch (status) {
            case ProgramStatus.Pending:
                return (
                    <Badge borderRadius="full" px="2" color={'blue'}>
                        Pending
                    </Badge>
                );
            case ProgramStatus.Open:
                return (
                    <Badge borderRadius="full" px="2" color={'green'}>
                        Open
                    </Badge>
                );
            default:
                return (
                    <Badge borderRadius="full" px="2" color={'grey'}>
                        Closed
                    </Badge>
                );
        }
    }

    return (
        // this box is not big enough
        <form>
            <Box>
                <Flex>
                    <InputGroup width={'xs'}>
                        <Input
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            placeholder={'Search programs'}
                        />
                        <InputRightElement
                            pointerEvents="none"
                            children={<SearchIcon color="gray.300" />}
                        />
                    </InputGroup>
                    <Spacer></Spacer>
                    <Checkbox
                        isChecked={showClosedPrograms}
                        onChange={(e) =>
                            setShowClosedPrograms(e.target.checked)
                        }
                    >
                        Show closed programs
                    </Checkbox>
                    <Spacer></Spacer>
                    <HStack spacing={2}>
                        <Link to={`/programs/create`}>
                            <Button colorScheme="blue">Create program</Button>
                        </Link>
                    </HStack>
                </Flex>
            </Box>
            <br />
            <Box>
                <Center>
                    <Table>
                        <Thead>
                            <Tr>
                                <Th>Name</Th>
                                <Th width={40}>Opens</Th>
                                <Th width={40}>Closes</Th>
                                <Th width={10}>Progress</Th>
                                <Th width={10}>Invitees</Th>
                                <Th width={10}>Uploaded</Th>
                                <Th width={40}>Status</Th>
                            </Tr>
                        </Thead>
                        <Tbody>
                            {programSummaryList?.map((programSummary) => (
                                <Tr key={programSummary.id}>
                                    <Link to={`/programs/${programSummary.id}`}>
                                        <Td>{programSummary.name}</Td>
                                    </Link>
                                    <Td>
                                        {moment(
                                            programSummary.commencementDate
                                        ).format('DD MMM yyyy')}
                                    </Td>
                                    <Td>
                                        {moment(
                                            programSummary.submissionDeadline
                                        ).format('DD MMM yyyy')}
                                    </Td>
                                    <Td>
                                        {calculateUploadPercentage(
                                            programSummary.numberOfInvitees ??
                                                0,
                                            programSummary.numberOfInviteesThatHaveUploaded ??
                                                0
                                        )}
                                    </Td>
                                    <Td>
                                        <PersonAltIcon></PersonAltIcon>
                                        {programSummary.numberOfInvitees}
                                    </Td>
                                    <Td>
                                        <CloudUploadIcon></CloudUploadIcon>
                                        {
                                            programSummary.numberOfInviteesThatHaveUploaded
                                        }
                                    </Td>
                                    <Link to={`/programs/${programSummary.id}`}>
                                        <Td>
                                            {getStatusTag(
                                                programSummary.status ??
                                                    ProgramStatus.Pending
                                            )}
                                        </Td>
                                    </Link>
                                </Tr>
                            ))}
                        </Tbody>
                    </Table>
                </Center>
                <br />
            </Box>
        </form>
    );
};
