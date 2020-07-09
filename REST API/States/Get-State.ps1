
# Set the Header and the Body
$SCOMHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$SCOMHeaders.Add('Content-Type', 'application/json; charset=utf-8')
$BodyRaw = "Windows"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($BodyRaw)
$EncodedText = [Convert]::ToBase64String($Bytes)
$JSONBody = $EncodedText | ConvertTo-Json

# The SCOM REST API authentication URL
$URIBase = 'http://<Your SCOM MS>/OperationsManager/authenticate'

# Authentication
$Authentication = Invoke-RestMethod -Method Post -Uri $URIBase -Headers $SCOMHeaders -body $JSONBody -UseDefaultCredentials -SessionVariable WebSession

# The query which contains the criteria for our alerts
$Query = @(@{ "classId" = ""

    # Criteria: Enter the name of the monitored computer (do not use the FQDN)
    "criteria" = "DisplayName = '<ComputerName>'"
    "displayColumns"    = "displayname", "healthstate", "name", "path"
  })

# Convert our query to JSON format
$JSONQuery = $Query | ConvertTo-Json

$Response = Invoke-RestMethod -Uri 'http://<Your SCOM MS>/OperationsManager/data/state' -Method Post -Body $JSONQuery -ContentType "application/json" -WebSession $WebSession

# Print out the state results
$State = $Response.rows
$State

