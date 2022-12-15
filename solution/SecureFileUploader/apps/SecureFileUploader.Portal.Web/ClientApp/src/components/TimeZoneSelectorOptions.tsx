function Timezones(){
    // TODO: Try map only Australia Cities with moment

    // List of Australian Cities and their timezones
    const timezones = [
        {name: 'UTC', timezone: 'UTC'},
        {name: 'Adelaide', timezone: 'Australia/Adelaide'},
        {name: 'Brisbane', timezone: 'Australia/Brisbane'},
        {name: 'Darwin', timezone: 'Australia/Darwin'},
        {name: 'Hobart', timezone: 'Australia/Hobart'},
        {name: 'Melbourne', timezone: 'Australia/Melbourne'},
        {name: 'Perth', timezone: 'Australia/Perth'},
        {name: 'Sydney', timezone: 'Australia/Sydney'},
        {name: 'Canberra', timezone: 'Australia/Canberra'},
    ];
    // Return a list in alphabetical order
    return timezones.sort((a, b) => a.name.localeCompare(b.name));
}

export function TimezoneOptions() {
    return Timezones().map((timezone) => {
        return (
            <option key={timezone.name} value={timezone.timezone}>
                {timezone.name}
            </option>
        )
    })
}


