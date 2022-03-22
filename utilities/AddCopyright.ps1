<#-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------#>

$crsql = @"
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

"@


$crcs = @"
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

"@


$crtf = @"
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

"@

$crpwsh = @"
<#-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------#>

"@

$crmd = @"
<!--
---------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

----------------------------------------------------------------------
-->

"@



 








function Write-Header ($file)
{
    $content = Get-Content $file

    $filename = Split-Path -Leaf $file

    $fileheader = $header -f $filename,$companyname,$date

    Set-Content $file $fileheader

    Add-Content $file $content
}

$files = Get-ChildItem -Path $PWD/../ -Recurse 
$files | foreach {
    if ($_.Extension -eq ".cs")
    {
        $contents = Get-Content $_ -raw
        if($contents.StartsWith($crcs))
        {}
        else 
        {
            if($_.name -eq "ADFActivityErrorsController.cs")
            {
                $newcontent = ($crcs + $contents)               
                $newcontent | Set-Content  $_
            }            
        }
    }
}
