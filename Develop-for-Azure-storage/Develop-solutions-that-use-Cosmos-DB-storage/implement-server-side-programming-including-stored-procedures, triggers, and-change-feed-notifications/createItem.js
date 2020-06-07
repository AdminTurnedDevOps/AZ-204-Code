// Creates an item under a Cosmos DB acount --> Database --> Container
// Before using a stored procedure, a Cosmos DB account, database, and container must exist

// Init the constant with CosmosClient. CosmosClient in expected as it's hard-coded into the Database class.
async function createItem() {

    const CosmosClient = require("@azure/cosmos").CosmosClient;
    
    // The endpoint must be the AccountEndpoint. To find it, go to Cosmos --> Settings --> Keys and copy the Primary Connection String
    const clientConfig = new CosmosClient( endpoint = "")

    // For these vars, put in the name of the database and the name of the container inside of Cosmos
    var database = clientConfig.database('database_name')
    var container = database.container('container_name')

    var newItem = JSON.parse('{ "id": "clouddev", "name":"Mike", "age":27, "city":"New York"}')

    const item = await container.items.create(newItem)
    item;
}

createItem()