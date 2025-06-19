<# 
 .SYNOPSIS
    Removes the extra language directories except the en-us.

 .DESCRIPTION
    Removes the extra language directories except the en-us directories.

 .EXAMPLE
    Remove-WinPELanguages -WinPEArch amd64 -Path E:\WinPE

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

        # The Windows PE working directory.
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Path
    )

    # Set $Path including architecture
    $Path = "$Path\$WinPEArch"

    # Remove unnescesary Languages files and folders
    Remove-Item -Path $Path -Include ??-??, ??-????-?? -Exclude en-us -Recurse
}