param(
    [string]$name = '',
    [string]$resourceGroupName = '',
    [string]$sku = 'F1'
)

$plan = az appservice plan create --name $($name + '-plan') `
                                  -g $resourceGroupName `
                                  --sku $sku --output json | 
                                  ConvertFrom-Json
$plan

if ($plan.name -like $null) {
    Write-Warning "App service plan does not exist: $name"
    Write-Output 'Please try again'
    Pause
    Exit
}

else {
    az webapp create -g $resourceGroupName -n $name -p $plan.name
}