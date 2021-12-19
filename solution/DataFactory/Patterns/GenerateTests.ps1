$pattern = "SQL-Database-to-Azure-Storage"
$folder = "./pipeline/$pattern"
$tests = (Get-ChildItem -Path $folder -Include "tests.json"  -Verbose -recurse) | Get-Content | ConvertFrom-Json

$adsopts = (gci env:* | sort-object name | Where-Object {$_.Name -like "AdsOpts*"})

$i = 0
foreach ($test in $tests)
{
    $testasjson = ($test | ConvertTo-Json -Depth 100)
    foreach ($opts in $adsopts)
    {
        
        $testasjson = $testasjson.Replace($opts.Name, $opts.Value).Replace("{TestNumber}",$i).Replace("{Pattern}",$pattern)    
    }
    $targetfile = $folder + "/tests/$i.json"    
    $testasjson | set-content ($targetfile)
    $i=$i+1
}

