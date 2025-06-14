<# 
 .SYNOPSIS
    Remove-WinPELanguages.ps1...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

#>

function Remove-WinPELanguages
{
    [CmdletBinding()]
    Param
    (
        # Specifies the Windows PE Architecture to use.
        # Valid values are: amd64, x86, arm or arm64.
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet('amd64', 'x86', 'arm', 'arm64')]
        [string]$WinPEArch,

        # Creates the working directory at the specified location.
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Destination
    )

    # Set $Destination including architecture
    #Review - werkt nog niet helemaal zoals gewenst...
    $Destination = "$Destination\$WinPEArch"

    # Remove unnescesary Languages files and folders
    Remove-Item -Path $Destination -Include ??-??, ??-????-?? -Exclude en-us -Recurse
}