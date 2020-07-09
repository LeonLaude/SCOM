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
$Authentication = Invoke-RestMethod -Method Post -Uri $uriBase -Headers $SCOMHeaders -body $JSONBody -UseDefaultCredentials -SessionVariable WebSession

# Initiate the Cross-Site Request Forgery (CSRF) token, this is to prevent CSRF attacks
$CSRFtoken = $WebSession.Cookies.GetCookies($UriBase) | ? { $_.Name -eq 'SCOM-CSRF-TOKEN' }
$SCOMHeaders.Add('SCOM-CSRF-TOKEN', [System.Web.HttpUtility]::UrlDecode($CSRFtoken.Value))

# The query which contains the criteria for our alerts
$Query = @(@{ "classId" = ""

# Get all new alerts (resolution state '0')
"criteria" = "ResolutionState = '0'"
"displayColumns" = "severity", "monitoringobjectdisplayname", "name", "age", "repeatcount"
})

# Convert our query to JSON format
$JSONQuery = $Query | ConvertTo-Json

$Response = Invoke-RestMethod -Uri 'http://<Your SCOM MS>/OperationsManager/data/alert' -Method Post -Body $JSONQuery -WebSession $WebSession

# Print out the alert results
$Alerts = $Response.Rows
$Alerts
