# Create an Azure Container Registry (ACR)
az acr create -n cbttest

# Log into the ACR
az acr login --name cbttest

# Create a Docker image with the `az acr` command

param(
    [string]$registry = 'cbttest',
    [string]$image = 'nginx:latest',
    [string]$source = 'https://github.com/Azure-Samples/acr-build-helloworld-node.git'
)

az acr build --image $image --registry $registry $source