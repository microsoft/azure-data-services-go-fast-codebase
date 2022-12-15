import {Box, Center,  SimpleGrid} from "@chakra-ui/react";
import {Card} from "../components/Card";
import {ListAltLargeIcon, SettingsLargeIcon} from "../components/Icons";

export const Home = () => {
    return(
        <Box>
            <Box p={4}>
                <Center>
                    <SimpleGrid columns={2} spacing={5}>
                        <Card
                            title={"Programs"}
                            icon={ListAltLargeIcon}
                            link={'/programs'}/>
                        <Card
                            title={"Settings"}
                            icon={SettingsLargeIcon}
                            link={'/settings'} />
                    </SimpleGrid>
                </Center>
            </Box>
        </Box>
    )
}
