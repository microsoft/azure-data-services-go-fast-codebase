import { Box, Container, Heading, HStack, Image } from '@chakra-ui/react';
import React, {CSSProperties, useEffect, useState} from 'react';
import { Link, useLocation } from 'react-router-dom';
import {
    HomeLargeIcon,
    HomeSmallIcon,
    ListAltLargeIcon,
    ListAltSmallIcon,
    SettingsLargeIcon,
    SettingsSmallIcon,
} from '../../Icons';
import {Api} from "../../../services/api/api-client";
import {castLogoFromDto} from "../../../models/SettingState";

export type NavItem = 'home' | 'programs' | 'settings';

export const Header: React.FC<{}> = () => {
    const location = useLocation();
    let headerProperties = getHeaderProperties(location.pathname);

    const [image, setImage] = useState<string | undefined>(undefined);

    const api = new Api();
    api.baseUrl = process.env.REACT_APP_API_URL || '';

    useEffect(() => {
        loadImage();
    }, [])

    function loadImage() {
        api.api.settingsLogoList().then((response) => {
            // Check if there is any data in the response.data.logo
            if (response.data.logo) {
                let data = castLogoFromDto(response.data);
                // NPX may generate a slightly strange API spec for this...
                // Dodge it.
                if (typeof data.logo !== 'string') {
                    data.logo = ''
                }
                setImage(data.logo);
            }
        });
    }

    function getHeaderProperties(locationPathName: string): {
        headerText: string;
        selectedNavItem: NavItem;
    } {
        if (locationPathName === '/') {
            return { headerText: 'Home', selectedNavItem: 'home' };
        } else if (locationPathName.startsWith('/programs/list')) {
            return { headerText: 'Programs', selectedNavItem: 'programs' };
        } else if (locationPathName.startsWith('/programs/create')) {
            return {
                headerText: 'Create program',
                selectedNavItem: 'programs',
            };
        } else if (locationPathName.startsWith('/programs/')) {
            return { headerText: 'View program', selectedNavItem: 'programs' };
        } else {
            return { headerText: 'Settings', selectedNavItem: 'settings' };
        }
    }

    function getHeadingIcon(selectedNavItem: NavItem) {
        switch (selectedNavItem) {
            case 'home':
                return <HomeLargeIcon></HomeLargeIcon>;
            case 'programs':
                return <ListAltLargeIcon></ListAltLargeIcon>;
            case 'settings':
                return <SettingsLargeIcon></SettingsLargeIcon>;
        }
    }

    const DefaultColour: string = '#192541';
    const SelectedColour: string = '#3165BE';

    const navItemUnselected: CSSProperties = {
        color: DefaultColour,
    };

    const navItemSelected: CSSProperties = {
        color: SelectedColour,
    };

    return (
        <>
            <Container minWidth={1100}>
                <HStack spacing={6}>
                    <Link to={`/`}>
                        <Image
                            src={
                                image === undefined ? '/logo.png' : `data:image/png;base64,${image}`
                            }
                            alt="Home"
                            width={100}
                            height={10}
                            margin={0.5}
                        />
                    </Link>
                    <Box
                        style={
                            headerProperties.selectedNavItem === 'home'
                                ? navItemSelected
                                : navItemUnselected
                        }
                    >
                        <Link to={`/`}>
                            <HStack spacing={0}>
                                {HomeSmallIcon(
                                    headerProperties.selectedNavItem === 'home'
                                        ? SelectedColour
                                        : DefaultColour
                                )}
                                <Heading size={'sm'}>Home</Heading>
                            </HStack>
                        </Link>
                    </Box>
                    <Box
                        style={
                            headerProperties.selectedNavItem === 'programs'
                                ? navItemSelected
                                : navItemUnselected
                        }
                    >
                        <Link to={`/programs`}>
                            <HStack spacing={0}>
                                {ListAltSmallIcon(
                                    headerProperties.selectedNavItem ===
                                        'programs'
                                        ? SelectedColour
                                        : DefaultColour
                                )}
                                <Heading size={'sm'}>Programs</Heading>
                            </HStack>
                        </Link>
                    </Box>
                    <Box
                        style={
                            headerProperties.selectedNavItem === 'settings'
                                ? navItemSelected
                                : navItemUnselected
                        }
                    >
                        <Link to={`/settings`}>
                            <HStack spacing={0}>
                                {SettingsSmallIcon(
                                    headerProperties.selectedNavItem ===
                                        'settings'
                                        ? SelectedColour
                                        : DefaultColour
                                )}
                                <Heading size={'sm'}>Settings</Heading>
                            </HStack>
                        </Link>
                    </Box>
                </HStack>
            </Container>
            <Box
                w="100%"
                backgroundColor={'#F2F3F9'}
                color={'#192541'}
                height={20}
            >
                <Container minWidth={1100} p={4}>
                    <HStack spacing={2}>
                        {getHeadingIcon(headerProperties.selectedNavItem)}
                        <Heading>{headerProperties.headerText}</Heading>
                    </HStack>
                </Container>
            </Box>
        </>
    );
};
