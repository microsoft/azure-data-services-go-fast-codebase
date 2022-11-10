import {
    TableContainer,
    Table,
    Thead,
    Tr,
    Th,
    Tbody,
    Td,
    Box,
} from '@chakra-ui/react';
import { InviteeState } from '../models/ProgramState';

export const ImportInviteeList: React.FC<{
    invitees: InviteeState[];
}> = (props) => {
    return (
        <>
            <Box p={4}>
                <TableContainer>
                    <Table>
                        <Thead>
                            <Tr>
                                <Th>Practice name</Th>
                                <Th>Email address</Th>
                                <Th>Folder name</Th>
                            </Tr>
                        </Thead>
                        <Tbody>
                            {props.invitees.map((invitee) => (
                                <>
                                    <Tr>
                                        <Td>{invitee.name}</Td>
                                        <Td>{invitee.emailAddress.split(',').map(invitee => <p>{invitee}</p>)}</Td>
                                        <Td>{invitee.details.folderName}</Td>
                                    </Tr>
                                </>
                            ))}
                        </Tbody>
                    </Table>
                </TableContainer>
                <br />
            </Box>
        </>
    );
};
