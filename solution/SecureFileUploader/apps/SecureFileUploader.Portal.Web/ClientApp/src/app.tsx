import { ChakraProvider, Container } from '@chakra-ui/react';
import { AppRoutes } from './app-routes';
import { Header } from './components/layouts/main-layout/header';

export const App = () => {
    return (
        <ChakraProvider>
            <Header></Header>
            <Container minWidth={1100} p={4}>
                <AppRoutes />
            </Container>
        </ChakraProvider>
    );
};
