# --------------------------------
# | Author: Leon Laude           |
# | Email:  leon.laude@gmail.com |
# --------------------------------
#
# This is a script to create a Report Operator with PowerShell
# 
#

# Check the installed SCOM version
$GetSCOMVersion = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup" -Name "UIVersion"

# Check the SCOM installation path
$GetSCOMInstallDir = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup" -Name "InstallDirectory"
$SCOMInstallDir = $GetSCOMInstallDir.InstallDirectory

# This is a SCOM 1801 environment
If ($GetSCOMVersion.UIVersion -eq "7.3.13142.0") {
    $SCOMVersion = "SCOM1801"

    Write-Host `n"System Center Operations Manager 1801 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Please enter a name for the Report Operator" -ForegroundColor Cyan
    $Name = Read-Host "Name"
    Write-Host `n"Please enter a description for the Report Operator" -ForegroundColor Cyan
    $Description = Read-Host "Description"
    Add-Type -Path $SCOMInstallDir"SDK Binaries\Microsoft.EnterpriseManagement.Core.dll"
    $NS = "Microsoft.EnterpriseManagement";
    $MgType = "$NS.EnterpriseManagementGroup";
    $Mg = New-Object $MgType localhost;
    $ReportOperator = $Mg.Security.GetProfiles() | Where { $_.Name -Eq "ReportOperator" }
    $Obj = New-Object Microsoft.EnterpriseManagement.Security.UserRole
    $Obj.Name = $Name
    $Obj.DisplayName = $Name
    $Obj.Description = $Description
    $Obj.Profile = $ReportOperator
    $Mg.Security.InsertUserRole($Obj)
    Write-Host `n"The Report Operator '$Name' has been successfully created!" -ForegroundColor Green
}

# This is a SCOM 1807 environment
ElseIf ($GetSCOMVersion.UIVersion -eq "7.3.13261.0") {
    $SCOMVersion = "SCOM1807"

    Write-Host `n"System Center Operations Manage 1807 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Please enter a name for the Report Operator" -ForegroundColor Cyan
    $Name = Read-Host "Name"
    Write-Host `n"Please enter a description for the Report Operator" -ForegroundColor Cyan
    $Description = Read-Host "Description"
    Add-Type -Path $SCOMInstallDir"SDK Binaries\Microsoft.EnterpriseManagement.Core.dll"
    $NS = "Microsoft.EnterpriseManagement";
    $MgType = "$NS.EnterpriseManagementGroup";
    $Mg = New-Object $MgType localhost;
    $ReportOperator = $Mg.Security.GetProfiles() | Where { $_.Name -Eq "ReportOperator" }
    $Obj = New-Object Microsoft.EnterpriseManagement.Security.UserRole
    $Obj.Name = $Name
    $Obj.DisplayName = $Name
    $Obj.Description = $Description
    $Obj.Profile = $ReportOperator
    $Mg.Security.InsertUserRole($Obj)
    Write-Host `n"The Report Operator '$Name' has been successfully created!" -ForegroundColor Green
}

# This is a SCOM 2016 with or without Update Rollup environment
ElseIf ($GetSCOMVersion.UIVersion -gt "7.2") {
    $SCOMVersion = "SCOM2016"

    Write-Host `n"System Center Operations Manage 2016 has been detected." -ForegroundColor Magenta

    Start-Sleep -s 1

    Write-Host `n"Please enter a name for the Report Operator" -ForegroundColor Cyan
    $Name = Read-Host "Name"
    Write-Host `n"Please enter a description for the Report Operator" -ForegroundColor Cyan
    $Description = Read-Host "Description"
    Add-Type -Path $SCOMInstallDir"SDK Binaries\Microsoft.EnterpriseManagement.Core.dll"
    $NS = "Microsoft.EnterpriseManagement";
    $MgType = "$NS.EnterpriseManagementGroup";
    $Mg = New-Object $MgType localhost;
    $ReportOperator = $Mg.Security.GetProfiles() | Where { $_.Name -Eq "ReportOperator" }
    $Obj = New-Object Microsoft.EnterpriseManagement.Security.UserRole
    $Obj.Name = $Name
    $Obj.DisplayName = $Name
    $Obj.Description = $Description
    $Obj.Profile = $ReportOperator
    $Mg.Security.InsertUserRole($Obj)
    Write-Host `n"The Report Operator '$Name' has been successfully created!" -ForegroundColor Green
}

# This is a SCOM 2019 environment
ElseIf ($GetSCOMVersion.UIVersion -gt "10.19") {
    $SCOMVersion = "SCOM2019"

    Write-Host `n"System Center Operations Manage 2019 has been detected." -ForegroundColor Magenta

    Write-Host `n"Please enter a name for the Report Operator" -ForegroundColor Cyan
    $Name = Read-Host "Name"
    Write-Host `n"Please enter a description for the Report Operator" -ForegroundColor Cyan
    $Description = Read-Host "Description"
    Add-Type -Path $SCOMInstallDir"SDK Binaries\Microsoft.EnterpriseManagement.Core.dll"
    $NS = "Microsoft.EnterpriseManagement";
    $MgType = "$NS.EnterpriseManagementGroup";
    $Mg = New-Object $MgType localhost;
    $ReportOperator = $Mg.Security.GetProfiles() | Where { $_.Name -Eq "ReportOperator" }
    $Obj = New-Object Microsoft.EnterpriseManagement.Security.UserRole
    $Obj.Name = $Name
    $Obj.DisplayName = $Name
    $Obj.Description = $Description
    $Obj.Profile = $ReportOperator
    $Mg.Security.InsertUserRole($Obj)
    Write-Host `n"The Report Operator '$Name' has been successfully created!" -ForegroundColor Green

}