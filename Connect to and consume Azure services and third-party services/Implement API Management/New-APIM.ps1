function New-APIM {
    [cmdletbinding(DefaultParameterSetName = 'apim')]
    param(
        [parameter(Mandatory,
            ValueFromPipeline,
            HelpMessage = 'Enter the name of the APIM instance')]
        [Alias('name', 'api')]
        [string]$apimName,

        [parameter(Mandatory,
            HelpMessage = 'Enter the name of the resource group for APIM to reside in')]
        [Alias('rgName', 'RG')]
        [string]$resourceGroupName,

        [parameter(Mandatory,
            HelpMessage = 'Enter the region for APIM to reside in')]
        [Alias('location')]
        [string]$region,

        [parameter(Mandatory,
            HelpMessage = 'Enter the email that you use to sign into Azure')]
        [Alias('email')]
        [string]$azureEmail,

        [parameter(Mandatory,
            HelpMessage = 'Enter org name. If no org, enter a random name')]
        [Alias('org')]
        [string]$orgName
    )

    begin {
        $mod = Get-InstalledModule -Name Az
        if (-not ($mod)) {
            Write-Warning 'The Az module is not installed...'
            $install = Read-Host 'Would you like to install it? 1 for yes 2 for no'

            switch ($install) {
                1 { Install-Module Az -Force }
                2 { Write-Output 'Exiting...'; Pause; Exit }
            }
        }
    }

    process {
        $params = @{
            'ResourceGroupName' = $resourceGroupName
            'Name'              = $apimName
            'Location'          = $region
            'AdminEmail'        = $email
            'Organization'      = $orgName
        }

        New-AzApiManagement @params
    }

    end {

    }
}