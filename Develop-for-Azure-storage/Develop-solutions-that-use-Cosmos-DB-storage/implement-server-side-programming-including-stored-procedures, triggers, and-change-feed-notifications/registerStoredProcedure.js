async function registerStoredProcedure() {

    const CosmosClient = require("@azure/cosmos").CosmosClient;
    
    // The endpoint must be the AccountEndpoint. To find it, go to Cosmos --> Settings --> Keys and copy the Primary Connection String
    const clientConfig = new CosmosClient( endpoint = "")

    // For the container var, put in the database name and container name in the cosmos account.
    var container = clientConfig.database("database_name").container("container_name")

    // For the stored var, ensure to put in an ID that you want the stored procedure to have.
    var stored = "storedid"

    container.scripts.storedProcedures.create({
        id: stored,
        body: { "category": "work", "name":"Write JavaScript", "description":"New JS Code!"}
    })
    
}

registerStoredProcedure()