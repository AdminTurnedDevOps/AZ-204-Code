// Ensure you have the Azure storage blog SDK by running the following:
//   npm install @azure/storage-blob
var storage = require('@azure/storage-blob')

function showMetadata(connectionString, containerName) {
    var client = storage.BlobServiceClient.fromConnectionString(connectionString)
    var containerClient = client.getContainerClient(containerName)

    console.log(containerClient)    
}

showMetadata(connectionString = 'storage_account_connection_string', containerName = 'container_name')