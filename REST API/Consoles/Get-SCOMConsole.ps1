# Set the Header and the Body
$SCOMHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$SCOMHeaders.Add('Content-Type’,’application/json; charset=utf-8')
$BodyRaw = "Windows"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($bodyraw)
$EncodedText =[Convert]::ToBase64String($Bytes)
$JSONBody = $EncodedText | ConvertTo-Json

# The SCOM REST API authentication URL
$UriBase = 'http://<Your SCOM MS>/OperationsManager/authenticate'

# Authentication
$Auth = Invoke-RestMethod -Method Post -Uri $UriBase -Headers $SCOMHeaders -Body $JSONBody -UseDefaultCredentials -SessionVariable WebSession

# Criteria: Enter the displayname of the SCOM object
$Criteria = "DisplayName LIKE '%System Center Operations Manager Console%'"

# Convert our criteria to JSON format
$JSONBody = $Criteria | ConvertTo-Json

$Response = Invoke-WebRequest -Uri 'http://<Your SCOM MS>/OperationsManager/data/scomObjects' -Method Post -Body $JSONBody -WebSession $WebSession

# Convert our response from JSON format to a custom object or hash table
$Object = ConvertFrom-Json -InputObject $Response.Content

# Print out the group results
$Object.scopeDatas
