<# 
 .SYNOPSIS
    Mount-WinPEBootImage...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

#>

function Mount-WinPEBootImage
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
        [string]$Path

    )

    # Mount the WinPE Boot Image
    Mount-WindowsImage -ImagePath "$Path\$WinPEArch\media\sources\boot.wim" -Index 1 -Path "$Path\$WinPEArch\mount"

}