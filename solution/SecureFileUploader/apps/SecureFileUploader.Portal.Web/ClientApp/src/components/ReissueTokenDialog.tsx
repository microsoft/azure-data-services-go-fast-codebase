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

export const ReissueTokenDialog: React.FC<{
    invitee: InviteeState | null;
    cancelRef: React.MutableRefObject<HTMLElement>;
}> = (props) => {
    const { isOpen, onOpen, onClose } = useDisclosure();
    const toast = useToast();

    function onProceed() {
        toast({
            title: 'New token issued',
            description: 'A new token has been issued for this invitee',
            status: 'success',
            duration: 9000,
            isClosable: true,
        });

        onClose();
    }

    return (
        <>
            <Button colorScheme="blue" width={130} onClick={onOpen}>
                Reissue token
            </Button>

            <AlertDialog
                isOpen={isOpen}
                leastDestructiveRef={props.cancelRef}
                onClose={onClose}
            >
                <AlertDialogOverlay>
                    <AlertDialogContent>
                        <AlertDialogHeader fontSize="lg" fontWeight="bold">
                            Reissue access token
                        </AlertDialogHeader>

                        <AlertDialogBody>
                            Are you sure you wish to reissue an access token to
                            this invitee?
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
