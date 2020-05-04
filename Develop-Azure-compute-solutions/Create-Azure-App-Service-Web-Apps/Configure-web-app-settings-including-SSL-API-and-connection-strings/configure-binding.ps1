function configure-binding {

    param(
        [cmdletbinding()]

        [parameter(Mandatory)]
        [string]$webAppName,

        [parameter(Mandatory)]
        [string]$resourceGroupName,

        [parameter(Mandatory,
            HelpMessage = 'Options are: ApiHub, Custom, DocDb, EventHub, MySql, NotificationHub, PostgreSQL, RedisCache, SQLAzure, SQLServer, ServiceBus')]
        [string]$connectionStringType,

        [parameter(Mandatory, 
            HelpMessage = 'Type in the settings as a key/value pair, for example: server=myServer;Database=myDB;Uid=myUser;Pwd=myPwd;')]
        [string]$connectionSettings,

        [parameter(Mandatory,
            HelpMessage = 'The key name in the key/value pair of the connection string')]
        [string]$keyName
    )

    az webapp config connection-string set -g $resourceGroupName `
        -n $webAppName `
        -t $connectionStringType `
        --settings $keyName=$connectionSettings

}