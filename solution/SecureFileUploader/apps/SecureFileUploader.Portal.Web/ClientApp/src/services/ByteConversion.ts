export function convertByteIntoUnit(bytes: number, unit: string) {
    switch (unit) {
        case "KB":
            return (bytes / 1024).toFixed(2);
        case "MB":
            return (bytes / (1024 * 1024)).toFixed(2);
        case "GB":
            return (bytes / (1024 * 1024 * 1024)).toFixed(2);
        default:
            return bytes;
    }
}
