import { ChakraProvider } from "@chakra-ui/react";
import React from "react";
import { BrowserRouter } from "react-router-dom";
import { App } from "./app";
import Fonts from "./fonts/fonts";
import { theme } from "./theme/theme";

import { createRoot } from 'react-dom/client';
const container = document.getElementById('root');
const root = createRoot(container!)
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <ChakraProvider theme={theme}>
        <Fonts />
        <App />
      </ChakraProvider>
    </BrowserRouter>
  </React.StrictMode>
);