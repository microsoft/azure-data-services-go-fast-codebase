import {Flex, useColorModeValue, Text, Center, HStack, Box} from "@chakra-ui/react";
import {Link} from "react-router-dom";

interface IProps {
    title: string;
    // Not sure what type to use here for the icon
    icon: any;
    link: string;
}

export const Card = (props: IProps) => {
    // useColorModeValue is for if we want to support dark mode
    let flexBackground = useColorModeValue("#F2F3F9 !important", "#F2F3F9 !important")
    let borderColour = useColorModeValue("black !important", "black !important")

    return(
        <Link to={props.link}>
            <Flex
                borderRadius={20}
                bg={flexBackground}
                borderColor={borderColour}
                borderWidth={1}
                padding={10}
                height={150}
                width={{base: 215, md: 245}}
                alignItems={'center'}
                direction={'column'}>
                <Box>
                    {<props.icon/>}
                </Box>
                <Flex flexDirection={'column'} mb={30}>
                    <Text
                        fontWeight={600}
                        color={'blackAlpha.900'}
                        textAlign={'center'}
                        fontSize={'xl'}>
                        {props.title}
                    </Text>
                    <Text
                        color={'blackAlpha.800'}
                        textAlign={'center'}
                        fontSize={'sm'}
                        fontWeight={500}>
                        Click to go to {props.title}
                    </Text>
                </Flex>
            </Flex>
        </Link>
    )
}
