param(
    [string]$scaleSetName,
    [string]$resourceGroupName,
    [string]$publicIPName = $($scaleSetName + '-dns'),
    [string]$loadBalancerName = $($scaleSetName + '-lb'),
    [string]$vNetName,
    [string]$subnetName,
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