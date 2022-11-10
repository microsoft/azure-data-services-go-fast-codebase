import {ChevronDownIcon, ChevronUpIcon} from '@chakra-ui/icons';
import {Badge, Box, Heading, Table, TableContainer, Tbody, Td, Th, Thead, Tr,} from '@chakra-ui/react';
import React from 'react';
import {InviteeStatus, ProgramState} from '../models/ProgramState';
import {InviteeDetails} from './InviteeDetails';

export const InviteeList: React.FC<{
    program: ProgramState;
    toggleInviteeDetailRow(index: number, isOpen: boolean): void;
}> = (props) => {
    function getStatusInviteeTag(status: InviteeStatus) {
        switch (status) {
            case InviteeStatus.Pending:
                return (
                    <Badge borderRadius="full" px="2" color={'blue'}>
                        Pending
                    </Badge>
                );
            case InviteeStatus.Completed:
                return (
                    <Badge borderRadius="full" px="2" color={'green'}>
                        Completed
                    </Badge>
                );
            case InviteeStatus.Bounced:
                return (
                    <Badge borderRadius="full" px="2" color={'red'}>
                        Bounced
                    </Badge>
                );
        }
    }

    return (
        <>
            <Heading size={'lg'}>
                Invitees ({props.program.invitees.length})
            </Heading>
            <Box p={4}>
                <TableContainer>
                    <Table>
                        <Thead>
                            <Tr>
                                <Th>Practice name</Th>
                                <Th>Email address</Th>
                                <Th>Status</Th>
                                <Th></Th>
                            </Tr>
                        </Thead>
                        <Tbody>
                            {props.program.invitees.map((invitee) => (
                                <>
                                    <Tr
                                        onClick={() => {
                                            props.toggleInviteeDetailRow(
                                                props.program.invitees.indexOf(
                                                    invitee
                                                ),
                                                invitee.isOpen
                                            );
                                        }}
                                    >
                                        <Td>{invitee.name}</Td>
                                        <Td>{invitee.emailAddress.split(',').map(invitee => <p>{invitee}</p>)}</Td>
                                        <Td>
                                            {getStatusInviteeTag(
                                                invitee.status
                                            )}
                                        </Td>
                                        <Td>
                                            {invitee.isOpen ? (
                                                <ChevronUpIcon></ChevronUpIcon>
                                            ) : (
                                                <ChevronDownIcon></ChevronDownIcon>
                                            )}
                                        </Td>
                                    </Tr>
                                    <Tr
                                        visibility={
                                            invitee.isOpen
                                                ? 'visible'
                                                : 'collapse'
                                        }
                                    >
                                        <Td colSpan={4}>
                                            <InviteeDetails
                                                inviteeId={invitee.id}
                                                load={invitee.isLoaded}
                                            ></InviteeDetails>
                                        </Td>
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
