(Get-ChildItem -Filter *.libsonnet) | ForEach-Object {
    $_.Name
    Rename-Item -Path $_ -NewName ($_.Name.Replace("_{IR}.json",".libsonnet"))
    $contents = (Get-Content $_ -raw)
    #if ($contents.StartsWith("{"))
    #{
        #$contents = 'function(GFPIR="IRA") ' + $contents
        $contents = $contents.Replace('@GF{IR}"','" + GFIR')
        $contents| set-content ($_)
    #}
}




