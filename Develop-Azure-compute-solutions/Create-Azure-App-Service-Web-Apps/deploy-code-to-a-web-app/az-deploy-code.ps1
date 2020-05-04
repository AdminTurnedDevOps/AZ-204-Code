function az-deploy-code {

    param(
        [string]$webApp,
        [string]$region
    )

    Write-Warning 'To use the webapp up command, ensure you are in the same directory as the code that you are deploying'
    Pause

    Write-Output 'Testing code deployment...'
    az webapp up -n $webApp -l $region --dryrun --html

    Write-Output "Deploying code to: $webapp"
    az webapp up -n $webApp -l $region --html
}