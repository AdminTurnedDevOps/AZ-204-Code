function New-LogicApp {
    [cmdletbinding(ConfirmImpact = 'Low', DefaultParameterSetName = 'logicApp')]
    param(
        [parameter(Mandatory,
            HelpMessage = 'Please enter the application name to create')]
        [Alias('app', 'name')]
        [string]$appName,

        [parameter(HelpMessage = 'Please enter the state that the logic app should be in: Enabled or Disabled')]
        [string]$state = 'Enabled',

        [parameter(Mandatory,
            HelpMessage = 'Please enter the resource group name for the logic app to exist in')]
        [Alias('RG')]
        [string]$resourceGroupName,

        [parameter(Mandatory,
            HelpMessage = 'Please enter the region for the logic app to exist in')]
        [Alias('location')]
        [string]$region
    )
    begin {
        $mod = Get-InstalledModule Az
        $az = az account show
        if(-not ($mod) -and ($az)) {
            Write-Warning 'The AZ module is not installed'
            $install = Read-Host 'Would you like to install the AZ Module? 1 for yes 2 for no'

            switch ($install) {
                1 {Install-Module -Name Az -Force}
                2 {Write-Output 'Exiting...'; Pause; exit}
            }
        }
    }

    process {

        $logicAppParams = @{
            'Name'              = $appName
            'ResourceGroupName' = $resourceGroupName
            'Location'          = $region
            'State'             = $state
            'AppServicePlan'    = $plan
        }
        
        try {
            Write-Output 'Creating an app service plan for the logic app...'
            $plan = az appservice plan create -g $resourceGroupName `
                                              -n $($appName + 'plan')

            New-AzLogicApp @logicAppParams
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {
        Write-Output "Command Finished: $($MyInvovation.Mycommand)"
    }
}