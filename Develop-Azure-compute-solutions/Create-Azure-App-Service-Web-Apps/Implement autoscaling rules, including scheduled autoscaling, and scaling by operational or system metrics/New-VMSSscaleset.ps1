param(
    [string]$scaleSetName = 'az204sub',
    [string]$resourceGroupName = 'az-204',
    [string]$publicIPName = $($scaleSetName + '-dns'),
    [string]$loadBalancerName = $($scaleSetName + '-lb'),
    [string]$vNetName = 'az204',
    [string]$subnetName = 'az204sub',
    [string]$image = 'UbuntuLTS'
)

az vmss create -n $scaleSetName `
               -g $resourceGroupName `
               --public-ip-address-dns-name $publicIPName `
               --load-balancer $loadBalancerName `
               --vnet-name $vNetName `
               --subnet $subnetName `
               --image $image `
               --generate-ssh-keys