function New-ACI {
    [cmdletbinding(ConfirmImpact = 'Medium', DefaultParameterSetName = 'acicreation')]

    param(
        [parameter(Mandatory,
            ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the name of the container instance to create')]
        [string]$name,

        [parameter(Mandatory,
            ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the resource group name that the container will reside in')]
        [string]$resourceGroupName,

        [parameter(Mandatory,
            ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the Docker image name that the container will use')]
        [string]$dockerImage,

        [parameter(ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the OS Type. Choices are Linux and Windows. Default is Linux')]
        [string]$osType = 'Linux',

        [parameter(Mandatory,
            ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the port number that the docker container should use')]
        [int]$port,

        [parameter(ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the public IP address type. Default is public')]
        [string]$ipAddressType = 'Public',

        [parameter(Mandatory,
            ParameterSetName = 'acicreation',
            HelpMessage = 'Enter the DNS label name')]
        [string]$dnsNameLabel,

        [parameter(ParameterSetName = 'acicreation',
            HelpMessage = 'Etner a command for the container to start')]
        [string]$command
    )

    begin {
        Write-Output 'Checking Azure account login...'
        $login = az account show
        $azureLogin = Get-AzSubscription

        if (-not($login) -or -not($azureLogin)) {
            Write-Warning 'Azure account is not logged in with Azure PowerShell or AZ CLI... please log in with Azure PowerShell or AZ CLI and try again'
            Pause
            exit
        }
    }

    process {
        $containerParams = @{
            'Name'              = $name
            'ResourceGroupName' = $resourceGroupName
            'Image'             = $dockerImage
            'OsType'            = $osType
            'port'              = $port
            'IpAddressType'     = $ipAddressType
            'DnsNameLabel'      = $dnsNameLabel
            'Command'           = $command
        }
        try {
            New-AzContainerGroup @containerParams
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {
        Write-Output "Finishing: $($MyInvocation.Mycommand)"
    }
}