import {object, string, date, ref} from 'yup';
import moment from "moment";

export const programScheme = object().shape({
    name: string().required("Name is a required field"),
    timeZone: string().required("Timezone is a required field"),
    opens: date().required("Opens Date is a required field")
        .test(
            'opensGreaterThanNow',
            'Opens Date must be in the future',
            function(date, context){
                if(!!date && !!context.parent.timeZone){
                    let dateAsString = moment(date).format('YYYY-MM-DDTHH:mm');

                    // convert dateAsString to utc
                    let utcDate = moment.tz(dateAsString, context.parent.timeZone).utc().format();

                    // Get current date in utc
                    let now = moment().utc().format();

                    if (!moment(utcDate).isAfter(now)) {
                        return false;
                    }
                }
                return true;
            }
        ),
    closes: date().required("Closes Date is a required field").typeError("Closes Date is a required field")
        .min(ref('opens'), "Closes Date must be after Opens Date"),
});
