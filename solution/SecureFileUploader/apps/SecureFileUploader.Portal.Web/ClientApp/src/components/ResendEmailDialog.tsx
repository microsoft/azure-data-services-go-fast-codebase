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
import { InviteeState } from '../models/ProgramState';

export const ResendEmailDialog: React.FC<{
    invitee: InviteeState | null;
    cancelRef: React.MutableRefObject<HTMLElement>;
}> = (props) => {
    const { isOpen, onOpen, onClose } = useDisclosure();
    const toast = useToast();

    function onProceed() {
        toast({
            title: 'Email sent',
            description: 'A new email invite has been sent',
            status: 'success',
            duration: 9000,
            isClosable: true,
        });

        onClose();
    }

    return (
        <>
            <Button colorScheme="blue" width={130} onClick={onOpen}>
                Resend email
            </Button>

            <AlertDialog
                isOpen={isOpen}
                leastDestructiveRef={props.cancelRef}
                onClose={onClose}
            >
                <AlertDialogOverlay>
                    <AlertDialogContent>
                        <AlertDialogHeader fontSize="lg" fontWeight="bold">
                            Resend email
                        </AlertDialogHeader>

                        <AlertDialogBody>
                            Are you sure you wish to resend the invitation email
                            to this invitee? The email will be sent to "
                            {props.invitee?.emailAddress}"
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
