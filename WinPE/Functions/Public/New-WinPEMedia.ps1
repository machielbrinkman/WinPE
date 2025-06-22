<# 
 .SYNOPSIS
    Creates a bootable WinPE USB flash drive or ISO file.

 .DESCRIPTION
    Creates a bootable WinPE USB flash drive or ISO file.

 .EXAMPLE
#>

function New-WinPEMedia
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
        [string]$Destination,

        # Overwrites the <Destination> directory without asking.
        [Parameter(Mandatory = $false)]
        [switch]$Force
    )

    if (-not $WinPE.Installed)
    {
        Write-Error 'The Windows PE Add-on is not installed!'
        return
    }

    # Set $Destination including architecture
    $Destination = "$Destination\$WinPEArch"
    
    $WinPERoot = $WinPE.InstallPath + $WinPEArch
    
    #Not now!!! Part of the ADK, not the Win PE Addon...
    #$FWFilesRoot = $WinADKRoot + 'Deployment Tools\' + $WinPEArch + '\Oscdimg\'

    # Question ...
    $Title = 'Delete directory!'
    $Message = 'Do you want to delete the directory?'

    $Yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', `
    'Deletes the directory.'

    $No = New-Object System.Management.Automation.Host.ChoiceDescription '&No', `
    'Retains the directory.'

    $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No)

    # Remove $Destination if it already exists
    if (Test-Path -Path $Destination)
    {
        Write-Warning "$Destination already exists!"
        if ($Force) { Remove-item -Path $Destination -Recurse -Force }
        else
        {
            $Result = $host.ui.PromptForChoice($title, $message, $options, 0)
            switch ($Result)
            {
                0 { Remove-Item -Path $Destination -Recurse -Force } # Yes
                1 { Write-Warning 'User aborted!'; return } # No
            }
        }
    }

    # Copy WinPE files
    Write-Host "Copying Windows PE files to $Destination."
    Copy-Item -Path "$WinPERoot\Media\" -Destination "$Destination\media" -Recurse -Verbose:$PSBoundParameters.verbose

    # Copy winpe.wim
    New-Item -ItemType Directory -Path "$Destination\media\sources" -Force -Verbose:$PSBoundParameters.verbose | Out-Null
    Copy-Item -Path "$WinPERoot\en-us\winpe.wim" -Destination "$Destination\media\sources\boot.wim" -Verbose:$PSBoundParameters.verbose

    # Create mount directory
    New-Item -ItemType Directory -Path "$Destination\mount" -Force -Verbose:$PSBoundParameters.verbose | Out-Null
    
    # Copy ISO boot files
    #New-Item -ItemType Directory -Path "$Destination\fwfiles" -Force -Verbose:$PSBoundParameters.verbose | Out-Null
    #Copy-Item -Path "$FWFilesRoot\*" -Destination "$Destination\fwfiles" -Include 'efisys.bin','etfsboot.com' -Verbose:$PSBoundParameters.verbose
}