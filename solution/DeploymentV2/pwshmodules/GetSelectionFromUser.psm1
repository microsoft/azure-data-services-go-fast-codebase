function Get-SelectionFromUser {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Options,
        [Parameter(Mandatory=$true)]
        [string]$Prompt        
    )
    
    [int]$Response = 0;
    [bool]$ValidResponse = $false    

    while (!($ValidResponse)) {            
        [int]$OptionNo = 0

        Write-Host $Prompt -ForegroundColor DarkYellow
        Write-Host "[0]: Quit"

        foreach ($Option in $Options) {
            $OptionNo += 1
            Write-Host ("[$OptionNo]: {0}" -f $Option)
        }

        if ([Int]::TryParse((Read-Host), [ref]$Response)) {
            if ($Response -eq 0) {
                return ''
            }
            elseif($Response -le $OptionNo) {
                $ValidResponse = $true
            }
        }
    }

    return $Options.Get($Response - 1)
} 