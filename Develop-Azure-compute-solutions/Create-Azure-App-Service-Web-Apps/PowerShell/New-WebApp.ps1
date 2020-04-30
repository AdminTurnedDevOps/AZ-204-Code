function New-WebApp {
    [cmdletbinding()]
    
    param(
        [string]$name,
        [string]$resourceGroupName
    )

    begin {
        $sub = Get-AzSubscription
        if (-not($sub)) {
            Write-Warning 'No subscription was found'
            $connectSub = Read-Host 'Would you like to sign into Azure with PowerShell? 1 for yes and 2 for no'

            switch ($connectSub) {
                1 { Connect-AzAccount }
                2 { exit }
            }
        }
    }

    process {
        $webappParams = @{
            'Name'              = $name
            'ResourceGroupName' = $resourceGroupName
        }
        try {
            New-AzWebApp @webappParams
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {
        Write-Output "Finished: $($MyInvocation.MyCommand)"
    }
}