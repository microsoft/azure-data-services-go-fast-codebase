import { Heading, Progress, VStack } from "@chakra-ui/react";
import React from "react";

/**
 * LoadingPage
 * Provides a loading page when a pages content is loading
 */
export const LoadingPage: React.FC = () => (
  <VStack
    height="100vh"
    paddingX="10vw"
    gap={4}
    justifyContent="center"
    alignItems="start"
  >
    <Heading>Loading</Heading>
    <Progress size="sm" alignSelf="stretch" isIndeterminate />
  </VStack>
);
