<# 
 .SYNOPSIS
    Find-WinPEInstallation...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

#>

function Find-WinPEInstallation
{
   # Find if the 'Kits Configuration Installer' is installed, then the Windows ADK WinPE Add-ons might be installed
   $KitsConfigurationInstaller = Get-CimInstance -ClassName Win32_Product | Where-Object {$_.Name -eq 'Kits Configuration Installer'}
   if ($KitsConfigurationInstaller)
   {
      $WinPE.Version = $KitsConfigurationInstaller.Version
      $WinPE.InstallPath = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots' -Name KitsRoot10
      Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots\$version\Installed Options" -Name OptionId.WindowsPreinstallationEnvironment
   }
}