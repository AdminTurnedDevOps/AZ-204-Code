function Show-AutoScaling {
    [cmdletbinding(ConfirmImpact = 'Low')]
    param(
        [string]$resourceGroupName,
        [strong]$VMScaleSet
    )
}

begin {
    $azAccount = Get-AzSubscription

    if (-not($azAccount)) {
        Write-Warning 'No Azure account is signed into with PowerShell...'
        Pause
        Write-Output 'Please log int an AZ Account'
        Login-AzAccount
    }
}

process {

    $vmssParams = @{
        'ResourceGroupName' = $resourceGroupName
        'VMScaleSetName'    = $VMScaleSet
    }
    try {
        Get-AzVmss @vmssParams
    }

    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
    
}

end {

}