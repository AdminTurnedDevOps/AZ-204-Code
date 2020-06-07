function Push-DockerImage {
    [cmdletbinding(ConfirmImpact = 'low', SupportsShouldProcess, DefaultParameterSetName = 'dockerpush')]
    param(
        [parameter(Mandatory,
            ParameterSetName = 'dockerpush',
            HelpMessage = 'Please type in the name of the ACR to create or that already exists')]
        [Alias('acr')]
        [string]$acrName,

        [parameter(Mandatory,
            ParameterSetName = 'dockerpush',
            HelpMessage = 'Please type in the resource group name that ACR will reside in')]
        [Alias('RG')]
        [string]$resourceGroupName,

        [parameter(Mandatory,
            ParameterSetName = 'dockerpush',
            HelpMessage = 'Please type in the name of the Docker image you would like to tag')]
        [Alias('image')]
        [string]$dockerImage,

        [parameter(Mandatory,
            ParameterSetName = 'dockerpush',
            HelpMessage = 'Please type in the name app name (nginx, redis, IIS, etc)')]
        [Alias('app')]
        [string]$appName
    )

    begin {
        $account = az account show
        if (-not($account)) {
            Write-Warning 'No AZ account is logged into'
            $logIn = Read-Host 'Would you like to log into an AZ account? 1 for yes or 2 for no'
            switch ($logIn) {
                1 {
                    az login
                }

                2 {
                    Pause
                    exit
                }
            }
        }
    }

    process {
        try {
            $checkACR = az acr show --name $acrName
            Write-Output 'Checking to see if ACR exists...'

            if (-not($checkACR)) {
                az acr create --name $acrName --resource-group $resourceGroupName --sku Standard
            }

            Write-Output "Logging into: $acrName"
            az acr login --name $acrName


            Write-Output "Tagging Docker image: $dockerImage"
            $tag = $acrName + '.azurecr.io/' + $appName
            docker tag $dockerImage $tag

            Write-Output "Pushing Docker image $dockerImage to $acrName"
            $tag = $acrName + '.azurecr.io/' + $appName
            docker push $tag
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
    }
}

end { }
}