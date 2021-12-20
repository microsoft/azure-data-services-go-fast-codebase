$patterns = ((Get-Content "Patterns.json") | ConvertFrom-Json).Folder | Get-Unique

foreach ($pattern in $patterns) {    
    Write-Host "_____________________________"
    Write-Host  $pattern
    Write-Host "_____________________________"
    $folder = "./pipeline/" + $pattern

    $tests = (Get-Content ($folder+"/tests.json")) | ConvertFrom-Json

    $adsopts = (gci env:* | sort-object name | Where-Object { $_.Name -like "AdsOpts*" })

    $i = 0
    foreach ($test in $tests) {
        Write-Host "Test: $i"
        $testasjson = ($test | ConvertTo-Json -Depth 100)
        foreach ($opts in $adsopts) {
        
            $testasjson = $testasjson.Replace($opts.Name, $opts.Value).Replace("{TestNumber}", $i).Replace("{Pattern}", $pattern)    
        }
        $targetfile = $folder + "/tests/$i.json"    
        $testasjson | set-content ($targetfile)
        $i = $i + 1
    }

}