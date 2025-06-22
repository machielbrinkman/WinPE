<# 
 .SYNOPSIS
    Dismount the Windows PE Boot Image, from the specified working directory.

 .DESCRIPTION
    Dismount the Windows PE Boot Image, from the specified working directory.

 .EXAMPLE
    Dismount-WinPEBootImage -WinPEArch amd64 -Path D:\WinPE -Save
    Dismounts the Windows PE Boot Image, from the specified working directory and saves the changes.

 .EXAMPLE
    Dismount-WinPEBootImage -WinPEArch amd64 -Path D:\WinPE -Discard
    Dismounts the Windows PE Boot Image, from the specified working directory and discards the changes.
#>

function Dismount-WinPEBootImage
{
    [CmdletBinding(DefaultParameterSetName = 'Save')]
    Param
    (
        # Specifies the Windows PE Architecture to use.
        # Valid values are: amd64, x86, arm or arm64.
        [Parameter(Mandatory = $true, ParameterSetName = 'Save', Position = 0)]
        [Parameter(Mandatory = $true, ParameterSetName = 'Discard', Position = 0)]
        [ValidateSet('amd64', 'x86', 'arm', 'arm64')]
        [string]$WinPEArch,

        # The Windows PE working directory.
        [Parameter(Mandatory = $true, ParameterSetName = 'Save', Position = 1)]
        [Parameter(Mandatory = $true, ParameterSetName = 'Discard', Position = 1)]
        [string]$Path,

        [Parameter(Mandatory = $true, ParameterSetName = 'Save', Position = 2)]
        [switch]$Save,

        [Parameter(Mandatory = $true, ParameterSetName = 'Discard', Position = 2)]
        [switch]$Discard
    )

    $DismountParms = @{Path = "$Path\$WinPEArch\mount"}

    if ($Save)
    {
        $DismountParms.Add('Save', $Save)
    }
    elseif ($Discard)
    {
        $DismountParms.Add('Discard', $Discard)
    }

    # Dismount the WinPE Boot Image
    Dismount-WindowsImage @DismountParms
}