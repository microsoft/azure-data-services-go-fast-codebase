import moment from "moment-timezone";

/**
 * Converts a date time string to UTC date time string
 * @param date The date time string to convert
 * @param timeZone The offset to convert the date to UTC
 */
export function convertSpecificTimeZoneDateTimeToUtcDateTime(date: string, timeZone: string) {
    return moment.tz(date, timeZone).utc().format();
}

/**
 * Converts a UTC date time string to date time string
 * @param date The UTC date time string to convert
 * @param timeZone The offset to convert to the date time string specified by the timeZone
 */
export function convertUtcDateTimeToSpecificTimeZoneDateTime(date: string, timeZone: string) {
    return moment.tz(date, 'UTC').tz(timeZone).format('YYYY-MM-DDTHH:mm');
}
