# Set the Header and the Body
$SCOMHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$SCOMHeaders.Add('Content-Type','application/json; charset=utf-8')
$BodyRaw = "Windows"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($bodyraw)
$EncodedText =[Convert]::ToBase64String($Bytes)
$JSONBody = $EncodedText | ConvertTo-Json

# The SCOM REST API authentication URL
$UriBase = 'http://<Your SCOM MS>/OperationsManager/authenticate'

# Initiate the Cross-Site Request Forgery (CSRF) token, this is to prevent CSRF attacks
$CSRFtoken = $WebSession.Cookies.GetCookies($UriBase) | ? { $_.Name -eq 'SCOM-CSRF-TOKEN' }
$SCOMHeaders.Add('SCOM-CSRF-TOKEN', [System.Web.HttpUtility]::UrlDecode($CSRFtoken.Value))

# Authentication
$Authentication = Invoke-RestMethod -Method Post -Uri $UriBase -Headers $SCOMHeaders -Body $JSONBody -UseDefaultCredentials -SessionVariable WebSession

# Criteria: Enter part of the displayname of the SCOM group within the wildcards
$Criteria = "DisplayName LIKE '%Contoso%'"

# Convert our criteria to JSON format
$JSONBody = $Criteria | ConvertTo-Json

$Response = Invoke-WebRequest -Uri 'http://<Your SCOM MS>/OperationsManager/data/scomGroups' -Method Post -Body $JSONBody -WebSession $WebSession

# Convert our response from JSON format to a custom object or hash table
$Groups = ConvertFrom-Json -InputObject $Response.Content

# Print out the group results
$Groups.scopeDatas
