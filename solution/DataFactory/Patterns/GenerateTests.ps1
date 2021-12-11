$tests = (Get-ChildItem -Path "./RelationalSourceToFile" -Include "tests.json"  -Verbose -recurse) | Get-Content

$adsopts = (gci env:* | sort-object name | Where-Object {$_.Name -like "AdsOpts*"})

foreach ($opts in $adsopts)
{
    
    $tests = ($tests).Replace($opts.Name, $opts.Value)
}

$tests