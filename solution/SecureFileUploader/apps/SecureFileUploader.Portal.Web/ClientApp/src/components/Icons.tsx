import { Icon } from '@chakra-ui/icons';

export const PersonAltIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1}>
            <path
                fillRule="evenodd"
                clipRule="evenodd"
                d="M15.67 9.13C17.04 10.06 18 11.32 18 13V16H22V13C22 10.82 18.43 9.53 15.67 9.13Z"
                fill="black"
            />
            <path
                d="M8 8C10.2091 8 12 6.20914 12 4C12 1.79086 10.2091 0 8 0C5.79086 0 4 1.79086 4 4C4 6.20914 5.79086 8 8 8Z"
                fill="black"
            />
            <path
                fillRule="evenodd"
                clipRule="evenodd"
                d="M14 8C16.21 8 18 6.21 18 4C18 1.79 16.21 0 14 0C13.53 0 13.09 0.0999998 12.67 0.24C13.5 1.27 14 2.58 14 4C14 5.42 13.5 6.73 12.67 7.76C13.09 7.9 13.53 8 14 8Z"
                fill="black"
            />
            <path
                fillRule="evenodd"
                clipRule="evenodd"
                d="M8 9C5.33 9 0 10.34 0 13V16H16V13C16 10.34 10.67 9 8 9Z"
                fill="black"
            />
        </Icon>
    );
};

export const CloudUploadIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1}>
            <path
                d="M19.35 6.795C18.67 2.91375 15.64 0 12 0C9.11 0 6.6 1.845 5.35 4.545C2.34 4.905 0 7.77375 0 11.25C0 14.9737 2.69 18 6 18H19C21.76 18 24 15.48 24 12.375C24 9.405 21.95 6.9975 19.35 6.795ZM14 10.125V14.625H10V10.125H7L12 4.5L17 10.125H14Z"
                fill="black"
            />
        </Icon>
    );
};

export const EmailReturnedIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1} viewBox={'0 0 18 18'}>
            <rect width="18" height="18" fill="url(#pattern0)" />
            <defs>
                <pattern
                    id="pattern0"
                    patternContentUnits="objectBoundingBox"
                    width="1"
                    height="1"
                >
                    <use
                        xlinkHref="#image0_5_30"
                        transform="scale(0.0104167)"
                    />
                </pattern>
                <image
                    id="image0_5_30"
                    width="96"
                    height="96"
                    xlinkHref="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAAABmJLR0QA/wD/AP+gvaeTAAAFdElEQVR4nO2dS4gcRRjHf2Zk1HU3BwM+QqIiKMYIkSiCuoiCiAclF0NuHoKKQnRzC3iIioILgo9EwZwED6ISUAioKCroxUBIQkTYg4ivXcTEgzG6G7PLeKhumW17ut5dNTPfD/6Xpbr6q/9X018/qntBEARBEARBEARBEARBEARBEATh/2wG9gPfAmeA3pjrTOHFPuAGD1+1XIAyfiWDQeeqFeDVwqugdIGPMxjgsOijwrNgvJTBoIZNLzo5XcN1wHIGAxo2LQPX6sxdo2sAPAJ0DNoJq+kAD+samSTgLv9YxhatdyYz+yQwDaz1Dme8+AV4CpgL0dkEMIvUAhOtAAeINGFvAg5nMMhcdRy41dldQ9YAjwKnEw40N/0F7KHlk5X1wHsBBzGsOgRc5emlFw8AP5LeiLa1ADwUwL8gjFORjlpkfRn1In2MFopslUPAlRbtR7FIuxTZK4C3LNoPxDWAUSnStkW2nIB/FNt74/sTHNYiPY99kd0CfF3px5tqYGURmrLoY5iKtEuRLcd3rqY/b5pmyIOWfeVepF1+4fcDPzT06Y0uaNciXR4jc5BPkdX17U2sAeRSpGNPIG9i/4RTFelQRTarBPTIv0j7FFmX+LzxmWG5FekYRTbbBJTKoUjHLLLZJ8DVgPWEMSD1BPAm1Czs0W6Rnge2W+5rC+EPgd6EDKaHKmQvA5MWMUwBr2BWBJeLtjYnAZNFTCb9nwBmUGtkL670Mw38WWnvTegElPoJ2GYZy83AkYY+jxRtbNhWxKKLdwl4HP1SnmoSvImVgFLvAxss4ukAu1l9u/t08TebGrOh2LdJjEvA3RZ99yfBm9gJKA2cwc7AjcAHhTZabNcp9mXzvOIxi/5LyiR400YC+g8hW0MEPYCtNB/C6nQCsxWEdUx7xgsGAYZWjGeuPleyTwaMw4m2E1DKpUjXYVpkBynqWy8mpEpAKdsLqZJQF3I2p8tRSJ2AHnZX0m1fyc4atPEitfn90l1Jx7iZZ+JP1CSkNr2quiId83a2qT/RkpDa8EEqi7RvkQ2VgB7wjEH7VZxnuINR51fgc9Thaw74Hvgd9Q7wOc22VX+exSERuh2Mok6h3um9JYI/koAG/Yy6FTER2Z9gSUhtWCj9g5rxoc/rm/YZpDCnNi6E5lAPW2Kg27f3LyG1eb46SNyrWZMYvJKQ2kAfvQmc7zN4A0xjcT4cpTbRVW+4DtgSm5ickpDaSBcdxP6NxUlgB+oq+zDwG6pwh47N+nCU2kxbzWF3zL8U9R2k6sP0mLJKQmpDbXQW87OdLrCXdo13SkJqU230guGY1gFfZBDvbOwzhDaZB543aLcJ+BC4Om44RiyZNEo9S0w1YzCWdcB3GcTaA542iBcyCNREp9Df2+kCX2UQa48RLML7DMaxN4M4rc2H4XjhWndL+TKLcRwFdqFqRXXtZx1RzQf1UdLUBjdpAf2Dpf0G/SwCOw36qhLVfFArjVOb3KS3NfFPoj/X/xu4w8EbDGP0uhl3I3m/YK1bubbDoI+dLsYURDW/5HWDHaXSvZrYD2i2P4r72k80fQd7KtYFPtPsLJWu0cSuWye0y82S/4hufkkXeI38DkeXaOI+qdn+ekc/Sloxv5/NqG9Jf0O6G1n90n0k+6xme9+nZa2aP4zoEhgyAca3F8YJXQI2BepfZv4AdAl4IkD/MvMb0CXgGH6noTLzNUyh3i9oSoL2M/OCH+/QnIBFAr1QJ9RzH/pD0SLqn1X4HI6EBr7E7LriOOr+Ut2nCAQPbiPOv+ASLHgOSUBSOsCnSAKSMgF8giQgKRcC7yIJSM521Mt4koCErEUt6logQQJsVwCMMhcBdwL3ALcDl6OWs+iuBbw8/BerfJPRfSdgDwAAAABJRU5ErkJggg=="
                />
            </defs>
        </Icon>
    );
};

export function ListAltSmallIcon(colour: string) {
    return (
        <Icon marginRight={1} viewBox={'0 0 18 18'}>
            <path
                d="M16 2V16H2V2H16ZM17.1 0H0.9C0.4 0 0 0.4 0 0.9V17.1C0 17.5 0.4 18 0.9 18H17.1C17.5 18 18 17.5 18 17.1V0.9C18 0.4 17.5 0 17.1 0V0ZM8 4H14V6H8V4ZM8 8H14V10H8V8ZM8 12H14V14H8V12ZM4 4H6V6H4V4ZM4 8H6V10H4V8ZM4 12H6V14H4V12Z"
                fill={colour}
            />
        </Icon>
    );
}

export const ListAltLargeIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1} viewBox={'0 0 36 36'} boxSize={7}>
            <path
                d="M32 4V32H4V4H32ZM34.2 0H1.8C0.8 0 0 0.8 0 1.8V34.2C0 35 0.8 36 1.8 36H34.2C35 36 36 35 36 34.2V1.8C36 0.8 35 0 34.2 0V0ZM16 8H28V12H16V8ZM16 16H28V20H16V16ZM16 24H28V28H16V24ZM8 8H12V12H8V8ZM8 16H12V20H8V16ZM8 24H12V28H8V24Z"
                fill="black"
            />
        </Icon>
    );
};

export function HomeSmallIcon(colour: string) {
    return (
        <Icon marginRight={1} viewBox={'0 0 20 17'}>
            <path d="M8 17V11H12V17H17V9H20L10 0L0 9H3V17H8Z" fill={colour} />
        </Icon>
    );
}

export const HomeLargeIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1} viewBox={'0 0 40 34'} boxSize={7}>
            <path
                d="M16 34V22H24V34H34V18H40L20 0L0 18H6V34H16Z"
                fill="black"
            />
        </Icon>
    );
};

export function SettingsSmallIcon(colour: string) {
    return (
        <Icon marginRight={1} viewBox={'0 0 18 18'}>
            <path
                d="M14.355 9.705C14.385 9.48 14.4 9.2475 14.4 9C14.4 8.76 14.385 8.52 14.3475 8.295L15.87 7.11C16.005 7.005 16.0425 6.8025 15.96 6.6525L14.52 4.1625C14.43 3.9975 14.2425 3.945 14.0775 3.9975L12.285 4.7175C11.91 4.4325 11.5125 4.1925 11.07 4.0125L10.8 2.1075C10.77 1.9275 10.62 1.8 10.44 1.8H7.56002C7.38002 1.8 7.23752 1.9275 7.20752 2.1075L6.93752 4.0125C6.49502 4.1925 6.09002 4.44 5.72252 4.7175L3.93002 3.9975C3.76502 3.9375 3.57752 3.9975 3.48752 4.1625L2.05502 6.6525C1.96502 6.81 1.99502 7.005 2.14502 7.11L3.66752 8.295C3.63002 8.52 3.60002 8.7675 3.60002 9C3.60002 9.2325 3.61502 9.48 3.65252 9.705L2.13002 10.89C1.99502 10.995 1.95752 11.1975 2.04002 11.3475L3.48002 13.8375C3.57002 14.0025 3.75752 14.055 3.92252 14.0025L5.71502 13.2825C6.09002 13.5675 6.48752 13.8075 6.93002 13.9875L7.20002 15.8925C7.23752 16.0725 7.38002 16.2 7.56002 16.2H10.44C10.62 16.2 10.77 16.0725 10.7925 15.8925L11.0625 13.9875C11.505 13.8075 11.91 13.5675 12.2775 13.2825L14.07 14.0025C14.235 14.0625 14.4225 14.0025 14.5125 13.8375L15.9525 11.3475C16.0425 11.1825 16.005 10.995 15.8625 10.89L14.355 9.705ZM9.00002 11.7C7.51502 11.7 6.30002 10.485 6.30002 9C6.30002 7.515 7.51502 6.3 9.00002 6.3C10.485 6.3 11.7 7.515 11.7 9C11.7 10.485 10.485 11.7 9.00002 11.7Z"
                fill={colour}
            />
        </Icon>
    );
}

export const SettingsLargeIcon: React.FC<{}> = () => {
    return (
        <Icon marginRight={1} viewBox={'0 0 36 36'} boxSize={7}>
            <path
                d="M28.71 19.41C28.77 18.96 28.8 18.495 28.8 18C28.8 17.52 28.77 17.04 28.695 16.59L31.74 14.22C32.01 14.01 32.085 13.605 31.92 13.305L29.04 8.325C28.86 7.995 28.485 7.89 28.155 7.995L24.57 9.435C23.82 8.865 23.025 8.385 22.14 8.025L21.6 4.215C21.54 3.855 21.24 3.6 20.88 3.6H15.12C14.76 3.6 14.475 3.855 14.415 4.215L13.875 8.025C12.99 8.385 12.18 8.88 11.445 9.435L7.85998 7.995C7.52998 7.875 7.15498 7.995 6.97498 8.325L4.10998 13.305C3.92998 13.62 3.98998 14.01 4.28998 14.22L7.33498 16.59C7.25998 17.04 7.19998 17.535 7.19998 18C7.19998 18.465 7.22998 18.96 7.30498 19.41L4.25998 21.78C3.98998 21.99 3.91498 22.395 4.07998 22.695L6.95998 27.675C7.13998 28.005 7.51498 28.11 7.84498 28.005L11.43 26.565C12.18 27.135 12.975 27.615 13.86 27.975L14.4 31.785C14.475 32.145 14.76 32.4 15.12 32.4H20.88C21.24 32.4 21.54 32.145 21.585 31.785L22.125 27.975C23.01 27.615 23.82 27.135 24.555 26.565L28.14 28.005C28.47 28.125 28.845 28.005 29.025 27.675L31.905 22.695C32.085 22.365 32.01 21.99 31.725 21.78L28.71 19.41ZM18 23.4C15.03 23.4 12.6 20.97 12.6 18C12.6 15.03 15.03 12.6 18 12.6C20.97 12.6 23.4 15.03 23.4 18C23.4 20.97 20.97 23.4 18 23.4Z"
                fill="black"
            />
        </Icon>
    );
};
