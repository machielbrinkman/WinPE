<# 
 .SYNOPSIS
   Search for the WinPE Installation and collect some properties of it.

 .DESCRIPTION
   Search if the 'Kits Configuration Installer' is installed, which is the installer for the Windows ADK and the Windows PE Add-on.
   Next look if the Windows ADK WinPE Add-on is installed and collect the necessary properties.
 #>
function Find-WinPEInstallation
{
   # Search if the 'Kits Configuration Installer' is installed, next if the Windows ADK WinPE Add-on is installed
   $KitsConfigurationInstaller = Get-CimInstance -ClassName Win32_Product | Where-Object {$_.Name -eq 'Kits Configuration Installer'}
   if ($KitsConfigurationInstaller)
   {
      $WinPE.Version = $KitsConfigurationInstaller.Version
      $WinPE.KitsRoot = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots' -Name KitsRoot10

      # The Kits Configuration version somehow uses always 10.0.xxxx.0
      $KitsConfigurationVersion = $WinPE.Version -replace "^10\.1", "10.0" -replace "\.[^.]+$", ".0"
      
      # Determine if the Windows PE Add-on is installed
      $WinPEOptionInstalled = Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots\$KitsConfigurationVersion\Installed Options" -Name OptionId.WindowsPreinstallationEnvironment -ErrorAction SilentlyContinue
      if ($WinPEOptionInstalled)
      {
         $WinPE.Installed = $true
         $WinPE.ADKRoot = $WinPE.KitsRoot +  'Assessment and Deployment Kit\'
         $WinPE.InstallPath = $WinPE.ADKRoot + 'Windows Preinstallation Environment\'
      }
   }
}