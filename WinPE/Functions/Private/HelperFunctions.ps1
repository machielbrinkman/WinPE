<# 
 .SYNOPSIS
    Find-ADKInstallation...

 .DESCRIPTION
    ...

 .EXAMPLE
    ...

#>

function Find-ADKInstallation
{

    $ADKInstallationPath = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots' -Name KitsRoot10
    return $ADKInstallationPath

}