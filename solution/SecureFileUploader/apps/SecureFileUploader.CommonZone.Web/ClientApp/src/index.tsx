import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import "./styles/globals.css";
import Home from './pages/home';
import Upload from './pages/upload';
import * as serviceWorkerRegistration from './serviceWorkerRegistration';
import reportWebVitals from './reportWebVitals';
import { ChakraProvider } from '@chakra-ui/react'
import {QueryClient, QueryClientProvider} from "@tanstack/react-query";

const rootElement = document.getElementById('root');
const queryClient = new QueryClient()

ReactDOM.render(
    <QueryClientProvider client={queryClient}>
        <BrowserRouter>
            <ChakraProvider>
                <Routes>
                    <Route index element={<Home/>}/>
                    <Route path="upload" element={<Upload/>}/>
                </Routes>
            </ChakraProvider>
        </BrowserRouter>
    </QueryClientProvider>,
    rootElement);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
