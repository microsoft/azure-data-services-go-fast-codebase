import { extendTheme } from "@chakra-ui/react";
import { ButtonStyles } from "./styles/button-styles";
import { CheckboxStyles } from "./styles/checkbox-styles";
import { InputStyles } from "./styles/input-styles";
import { LinkStyles } from "./styles/link-styles";
import { ModalStyles } from "./styles/modal-styles";
import { TableStyles } from "./styles/table-styles";

export const theme = extendTheme({
  colors: {
    brand: {
      100: "#f7fafc",
      // ...
      900: "#1a202c",
    },
  },
  fonts: {},
  // Component prop names must match the component
  components: {
    Button: ButtonStyles,
    Checkbox: CheckboxStyles,
    Input: InputStyles,
    Link: LinkStyles,
    Modal: ModalStyles,
    Table: TableStyles,
  },
  shadows: {},
});
