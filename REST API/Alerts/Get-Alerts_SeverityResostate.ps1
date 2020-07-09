# Set the Header and the Body
$SCOMHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$SCOMHeaders.Add('Content-Type','application/json; charset=utf-8')
$BodyRaw = “Windows”
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($BodyRaw)
$EncodedText =[Convert]::ToBase64String($Bytes)
$JSONBody = $EncodedText | ConvertTo-Json

# The SCOM REST API authentication URL
$URIBase = 'http://<Your SCOM MS>/OperationsManager/authenticate'

# Authentication
$Authentication = Invoke-RestMethod -Method POST -Uri $uriBase -Headers $SCOMHeaders -body $JSONBody -UseDefaultCredentials -SessionVariable WebSession

# The query which contains the criteria for our alerts
$Query = @(@{ "classId"= ""

# Get all alerts with severity '2' (critical) and resolutionstate '0' (new)
"criteria" = "((Severity = '2') AND (ResolutionState = '0'))"
"displayColumns" ="severity","monitoringobjectdisplayname","name","age","repeatcount"
})

# Convert our query to JSON format
$JSONQuery = $Query | ConvertTo-Json

$Response = Invoke-RestMethod -Uri "http://<Your SCOM MS>/OperationsManager/data/alert" -Method Post -Body $JSONQuery -WebSession $WebSession

# Print out the group results
$Alerts = $Response.Rows
$Alerts