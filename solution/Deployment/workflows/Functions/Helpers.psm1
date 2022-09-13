Function ConvertFrom-AzureCli {
    [CmdletBinding()]
    param (
      [Parameter(ValueFromPipeline)] [string] $line
    )
    begin {
      # Collect all lines in the input
      $lines = @()
    }
  
    process {
      # 'process' is run once for each line in the input pipeline.
      $lines += $line
    }
  
    end {
      # Azure Cli errors and warnings change output colors permanently.
      # Reset the shell colors after each operation to keep consistent.
      [Console]::ResetColor()
  
      # If the 'az' process exited with a non-zero exit code we have an error.
      # The 'az' error message is already printed to console, and is not a part of the input.
      if ($LASTEXITCODE) {
          Write-Error "az exited with exit code $LASTEXITCODE" -ErrorAction 'Stop'
      }
  
      $inputJson = $([string]::Join("`n", $lines));
      # We expect a Json result from az cli if we have no error. The json result CAN be $null.
      $result = ConvertFrom-Json $inputJson
      return $result
    }
  }