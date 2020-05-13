param(
    [string]$database = 'clouddevdata',
    [string]$collection = 'clouddev',
    [string]$apiCall = 'GET'
)

$key = Read-Host "Enter CosmosDB Key"

$dateTime = [DateTime]::UtcNow.ToString("r")
$privateKey = [System.Convert]::FromBase64String($key)
$KeyType="master"
$TokenVersion=1
$ResourceLink = "dbs/$database/colls/$collection"
$ResourceType="udfs"

$Verb = "$apiCall"

S$StringToSign=$Verb.ToLowerInvariant()+"`n" +$ResourceType.ToLowerInvariant()+"`n" +$ResourceLink + "`n" +$dateTime.ToLowerInvariant() + "`n" + "" + "`n";
#$StringToSign = "$($Verb.ToLowerInvariant())`n$($resourceType.ToLowerInvariant())`n$resourceLink`n$($dateTime.ToLowerInvariant())`n`n"
$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Convert]::FromBase64String($Key)
$signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($StringToSign))
$signature = [Convert]::ToBase64String($signature)

$authorization = [System.Web.HttpUtility]::UrlEncode("type=$KeyType&ver=$TokenVersion&sig=$signature")

$header = @{Authorization=$authorization;"x-ms-version"="2017-02-22";"x-ms-date"=$dateTime;}

Invoke-RestMethod -Headers $header -Uri "https://mjldevschema.documents.azure.com/dbs/$database/colls/$collection"