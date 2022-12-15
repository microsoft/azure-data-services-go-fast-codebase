import {
    useDisclosure,
    Button,
    AlertDialog,
    AlertDialogOverlay,
    AlertDialogContent,
    AlertDialogHeader,
    AlertDialogBody,
    AlertDialogFooter,
    useToast,
} from '@chakra-ui/react';
import React from 'react';
import { AccessTokenState, InviteeState } from '../models/ProgramState';

export const CancelTokenDialog: React.FC<{
    invitee: InviteeState;
    accessToken: AccessTokenState;
    cancelRef: React.MutableRefObject<HTMLElement>;
}> = (props) => {
    const { isOpen, onOpen, onClose } = useDisclosure();
    const toast = useToast();

    function onProceed() {
        toast({
            title: 'Access token cancelled',
            description: 'The access token is now inactive',
            status: 'success',
            duration: 9000,
            isClosable: true,
        });

        onClose();
    }

    return (
        <>
            <Button colorScheme="blue" width={130} onClick={onOpen}>
                Cancel token
            </Button>

            <AlertDialog
                isOpen={isOpen}
                leastDestructiveRef={props.cancelRef}
                onClose={onClose}
            >
                <AlertDialogOverlay>
                    <AlertDialogContent>
                        <AlertDialogHeader fontSize="lg" fontWeight="bold">
                            Cancel access token
                        </AlertDialogHeader>

                        <AlertDialogBody>
                            Are you sure you wish to cancel this invitees access
                            token? They will no longer be able to upload their
                            data using the invite code in their email.
                        </AlertDialogBody>

                        <AlertDialogFooter>
                            <Button size={'md'} onClick={onClose}>
                                Cancel
                            </Button>
                            <Button
                                size={'md'}
                                colorScheme="blue"
                                onClick={onProceed}
                                ml={3}
                            >
                                Proceed
                            </Button>
                        </AlertDialogFooter>
                    </AlertDialogContent>
                </AlertDialogOverlay>
            </AlertDialog>
        </>
    );
};
function toast(arg0: {
    title: string;
    description: string;
    status: string;
    duration: number;
    isClosable: boolean;
}) {
    throw new Error('Function not implemented.');
}
