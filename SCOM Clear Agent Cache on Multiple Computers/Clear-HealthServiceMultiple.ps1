# --------------------------------
# | Author: Leon Laude           |
# | Email:  leon.laude@gmail.com |
# --------------------------------
#
# This is a simple script for clearing the SCOM agent cache on multiple agent-managed computers that are listed in a text file.
#
Write-Host "Enter the full path of your text file containing the server list." -ForegroundColor Cyan
$FilePath = Read-Host "Path"

Write-Host "1. Getting the list of computers from the text file:"$FilePath`n -ForegroundColor Cyan

$Servers = Get-Content $FilePath

Write-Host "2. Stopping the Monitoring Agent service on the computers...`n" -ForegroundColor Cyan

ForEach ($Server in $Servers) 
{  

Get-Service -ComputerName $Server -Name HealthService | Stop-Service

}

Start-Sleep -s 3

Write-Host "3. Renaming the existing 'Health Service State' folder to 'Health Service State Old' `n" -ForegroundColor Cyan

ForEach ($Server in $Servers) 
{  

Rename-Item -Path "\\$Server\C$\Program Files\Microsoft Monitoring Agent\Agent\Health Service State" -NewName "Health Service State Old"

}

Start-Sleep -s 3

Write-Host "4. Starting the Monitoring Agent service...`n" -ForegroundColor Cyan

ForEach ($Server in $Servers) 
{  

Get-Service -ComputerName $Server -Name HealthService | Start-Service

}

Start-Sleep -s 3

Write-Host "5. Removing the 'Health Service State Old' folder." -ForegroundColor Cyan

ForEach ($Server in $Servers) 
{  

Remove-Item -Path "\\$Server\C$\Program Files\Microsoft Monitoring Agent\Agent\Health Service State Old" -Recurse

}

Write-Host "`n6. Done!" -ForegroundColor Cyan
