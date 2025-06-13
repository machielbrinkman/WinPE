<# 
 .SYNOPSIS
    Dismount-WinPEBootImage...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

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

        # Creates the working directory at the specified location.
        [Parameter(Mandatory = $true, ParameterSetName = 'Save', Position = 1)]
        [Parameter(Mandatory = $true, ParameterSetName = 'Discard', Position = 1)]
        [string]$Path,

        [Parameter(Mandatory = $true, ParameterSetName = 'Save', Position = 2)]
        [switch]$Save,

        [Parameter(Mandatory = $true, ParameterSetName = 'Discard', Position = 2)]
        [switch]$Discard
    )
    $DismountParms = @{Path = "$Path\$WinPEArch\mount"}

    Write-Host $PSCmdlet.ParameterSetName
    if ($Save) {Write-Host $Save
    $DismountParms.Add('Save', $Save)}
    elseif ($Discard) {
        Write-Host $Discard
        $DismountParms.Add('Discard', $Discard)
    }

    $DismountParms

    # Dismount the WinPE Boot Image
    Write-Host "Dismount-WindowsImage -Path "$Path\$WinPEArch\mount" -Save"
    Dismount-WindowsImage @DismountParms

}