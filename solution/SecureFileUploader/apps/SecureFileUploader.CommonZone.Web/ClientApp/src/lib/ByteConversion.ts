export function convertUnitToBytes(bytes: number, unit: string): number {
    switch (unit) {
        case 'KB':
            return bytes / 1024;
        case 'MB':
            return bytes / 1024 / 1024;
        case 'GB':
            return bytes / 1024 / 1024 / 1024;
        default:
            return bytes;
    }
}
