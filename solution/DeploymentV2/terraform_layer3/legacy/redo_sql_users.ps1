$state = terraform state list
foreach ($l in $state) { 
    if($l.StartsWith("null_resource."))
    {
        #$name =  $l.replace("""",'\"')
        $name = $l
        $cmd = "terraform state rm '$name'"
        Write-Host $cmd
        $cmd | bash
    }
}   