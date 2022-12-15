import {Checkbox} from "@chakra-ui/react";
import {FieldInputProps} from "formik/dist/types";

interface FormikCheckboxProps extends FieldInputProps<boolean> {}

export const FormikCheckbox = ({children, value, ...props}:React.PropsWithChildren<FormikCheckboxProps>) => {
    return (
        <Checkbox
            isChecked={value}
            {...props}>
            {children}
        </Checkbox>
    )
}
