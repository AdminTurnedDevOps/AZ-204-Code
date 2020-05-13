param(
    [string]$database = 'clouddevdata',
    [string]$collection = 'clouddev',
    [string]$apiCall = 'GET',
    [string]$resourceType="colls",
    [string]$cosmosAccountName = "mjldevschema"
)

$key = Read-Host "Enter CosmosDB Key"

$dateTime = [DateTime]::UtcNow.ToString("r")
$privateKey = [System.Convert]::FromBase64String($key)
$keyType="master"
$tokenVersion="1.0"
$resourceLink = "dbs/$database/colls/$collection"

$Verb = "$apiCall"

$StringToSign=$Verb.ToLowerInvariant()+"`n" +$resourceType.ToLowerInvariant()+"`n" +$resourceLink + "`n" +$dateTime.ToLowerInvariant() + "`n" + "" + "`n";
$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Convert]::FromBase64String($Key)
$signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($StringToSign))
$signature = [Convert]::ToBase64String($signature)

$authorization = [System.Web.HttpUtility]::UrlEncode("type=$keyType&ver=$tokenVersion&sig=$signature")

$header = @{Authorization=$authorization;"x-ms-version"="2017-02-22";"x-ms-date"=$dateTime}

Invoke-RestMethod -Headers $header -Uri "https://$cosmosAccountName.documents.azure.com:443/dbs/$database/colls/$collection"