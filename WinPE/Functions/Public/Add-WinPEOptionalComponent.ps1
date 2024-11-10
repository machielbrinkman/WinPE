<# 
 .SYNOPSIS
    Add-WinPEOptionalComponent...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

#>


# Mount the image
#Mount-WindowsImage -ImagePath D:\WinPE\media\sources\boot.wim -Index 1 -Path $Destination


function Add-WinPEOptionalComponent
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


    # Set $Destination including architecture
    $Destination = $Destination + $WinPEArch + '\mount'
    
    #Find Windows ADK install dir
    $ADKRoot = Find-ADKInstallation

    $WinADKRoot = $ADKRoot + 'Assessment and Deployment Kit\'
    $WinPERoot = $WinADKRoot + 'Windows Preinstallation Environment\' + $WinPEArch

# Add Packages to the image
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-WMI.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-NetFx.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-Scripting.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-PowerShell.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-DismCmdlets.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-EnhancedStorage.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-EnhancedStorage_en-us.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\WinPE-StorageWMI.cab"
Add-WindowsPackage -Path $Destination -PackagePath "$WinPERoot\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"



}




# Make PowerShell the default shell
#Copy-Item -Path 'D:\Lab Environment\Scripts\WinPE\*' -Destination $Destinationwindows\system32\ -Exclude 'Build WinPE with Powershell.txt'

# Dismount the image and saving the changes
#Dismount-WindowsImage -Path $Destination -Save

# Switch to the "Deployment and Imaging Tools Environment"!
# Build the USB Drive
#makewinpemedia /ufd /f D:\WinPE\ E: