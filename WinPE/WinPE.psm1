
# Requires -RunAsAdministrator

# Import Functions
. $PSScriptRoot\Functions\Private\HelperFunctions.ps1
. $PSScriptRoot\Functions\Public\Copy-WinPE.ps1
. $PSScriptRoot\Functions\Public\Mount-WinPEBootImage.ps1
. $PSScriptRoot\Functions\Public\Dismount-WinPEBootImage.ps1
. $PSScriptRoot\Functions\Public\Add-WinPEOptionalComponent.ps1
#. $PSScriptRoot\Functions\Public\Update-WinPE.ps1
#. $PSScriptRoot\Functions\Public\New-WinPEMedia.ps1

#HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Kits\Installed Roots
# Requires .\adksetup.exe /ceip off /features OptionId.WindowsPreinstallationEnvironment /quiet
#. $PSScriptRoot\Functions\Install-WindowsADK.ps1

New-Alias -Name copype -Value Copy-WinPE -Description "Creates working directories for WinPE image customization and media creation."
#New-Alias -Name MakeWinPEMedia -Value New-WinPEMEdia -Description "Creates bootable WinPE USB flash drive or ISO file."

Export-ModuleMember -Function * -Alias *

# Module Variables
$WinPE =
@{
    Version = $null
    Installed = $false
    InstallPath = $null
    KitsRoot = $null
    ADKRoot = $null
}
New-Variable -Name WinPE -Value $WinPE -Scope Script -Force

Find-WinPEInstallation