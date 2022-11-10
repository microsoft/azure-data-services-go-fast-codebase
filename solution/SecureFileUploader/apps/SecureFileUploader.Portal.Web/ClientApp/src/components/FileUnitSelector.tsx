function fileSizeUnits(){
    const units = [
        { name: 'Select an option', unit: 'Select an option' },
        {name: 'KB', unit: 'KB'},
        {name: 'MB', unit: 'MB'},
        {name: 'GB', unit: 'GB'},
    ];

    return units;
}

export function FileSizeUnitsOptions() {
    return fileSizeUnits().map((unit) => {
        return (
            <option key={unit.name} value={unit.unit}>
                {unit.name}
            </option>
        )
    })
}
