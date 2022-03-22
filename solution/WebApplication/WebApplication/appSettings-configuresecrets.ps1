#todo: this script may need to reach into both functions app and webapp in future
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param (
)

$errorActionPreference = "Stop";
if (-not $PSBoundParameters.ContainsKey('Confirm')) {
    $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
}

$keys = @("AZURE_CLIENT_SECRET")

pushd $PSScriptRoot
try {
	dotnet user-secrets init

	foreach ($k in $keys) {
		if($psCmdLet.ShouldProcess("$k",  "Update secret"))                                                              
        {
            Write-host "Provide new value:" 
            #note - we dont' read as a masked value as dotnet-secret will spit out the plaintext anyway
            $secret = read-host
            # dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "C:\apps\WebApp1\src\WebApp1"
            dotnet user-secrets set $k $secret
        }   
	}
}
finally {
	popd
}