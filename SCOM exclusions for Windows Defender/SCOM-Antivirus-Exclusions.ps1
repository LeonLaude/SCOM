# -------------------------------- 
# | Author: Leon Laude           | 
# | Email:  leon.laude@gmail.com | 
# -------------------------------- 
# 
# This script will create the required antivirus exclusions for the Windows Defender running on the SCOM Management Servers
#
#

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`

        [Security.Principal.WindowsBuiltInRole] “Administrator”)) {

    Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
    Break

}

Clear-Host
Start-Sleep -s 1
Write-Host `n"PowerShell Unrestricted Execution Policy access is required to run this script." -ForegroundColor Yellow
Start-Sleep -s 1
Write-Host `n"If applicable, please run the "Set-ExecutionPolicy Unrestricted" command to allow the script to run." -ForegroundColor Yellow
Start-Sleep -s 1

# Check the installed SCOM version
$GetSCOMVersion = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup" -Name "UIVersion"

# This is a SCOM 1801 environment
If ($GetSCOMVersion.UIVersion -eq "7.3.13142.0") {
    $SCOMVersion = "SCOM1801"

    Write-Host `n"System Center Operations Manager 1801 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions..." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the SCOM 1801 management server installation directory
    Add-MpPreference -ExclusionExtension "C:\Program Files\Microsoft System Center\Operations Manager\Server\Health Service State"

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions for the ".edb" ".chk" ".log" file extensions." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the .edb, .chk and .log files on the SCOM management server
    Add-MpPreference -ExclusionExtension ".edb", ".chk", ".log"

    Start-Sleep -s 1

    Write-Host `n"Successfully added the Windows Defender exclusions!" -ForegroundColor Green
}

# This is a SCOM 1807 environment
ElseIf ($GetSCOMVersion.UIVersion -eq "7.3.13261.0") {
    $SCOMVersion = "SCOM1807"

    Write-Host `n"System Center Operations Manage 1807 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions..." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the SCOM 1807 management server installation directory
    Add-MpPreference -ExclusionExtension "C:\Program Files\Microsoft System Center\Operations Manager\Server\Health Service State"

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions for the ".edb" ".chk" ".log" file extensions." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the .edb, .chk and .log files on the SCOM management server
    Add-MpPreference -ExclusionExtension ".edb", ".chk", ".log"

    Start-Sleep -s 1

    Write-Host `n"Successfully added the Windows Defender exclusions!" -ForegroundColor Green
}

# This is a SCOM 2016 with or without Update Rollup environment
ElseIf ($GetSCOMVersion.UIVersion -gt "7.2") {
    $SCOMVersion = "SCOM2016"

    Write-Host `n"System Center Operations Manage 2016 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Adding a Windows Defender exlusion for the 'Health Service State' folder." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the SCOM2016 management server installation directory
    Add-MpPreference -ExclusionExtension "C:\Program Files\Microsoft System Center 2016\Operations Manager\Server\Health Service State"

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions for the ".edb" ".chk" ".log" file extensions." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the .edb, .chk and .log files on the SCOM management server
    Add-MpPreference -ExclusionExtension ".edb", ".chk", ".log"

    Start-Sleep -s 1

    Write-Host `n"Successfully added the Windows Defender exclusions!" -ForegroundColor Green
}

# This is a SCOM 2019 environment
ElseIf ($GetSCOMVersion.UIVersion -gt "10.19") {
    $SCOMVersion = "SCOM2019"

    Write-Host `n"System Center Operations Manage 2019 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Adding a Windows Defender exlusion for the 'Health Service State' folder." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the SCOM2019 management server installation directory
    Add-MpPreference -ExclusionExtension "C:\Program Files\Microsoft System Center\Operations Manager\Server\Health Service State"

    Start-Sleep -s 1

    Write-Host `n"Adding Windows Defender exlusions for the ".edb" ".chk" ".log" file extensions." -ForegroundColor Cyan

    # Adds Windows Defender exclusions for the .edb, .chk and .log files on the SCOM management server
    Add-MpPreference -ExclusionExtension ".edb", ".chk", ".log"

    Start-Sleep -s 1

    Write-Host `n"Successfully added the Windows Defender exclusions!" -ForegroundColor Green
}