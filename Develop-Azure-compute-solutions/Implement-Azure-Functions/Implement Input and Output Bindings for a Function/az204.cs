using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace az204
{
    public static class az204
    {
        [FunctionName("az204Trigger")]
        public static void Run([QueueTrigger("PayPalPay", Connection = "PayPal")]string myQueueItem, ILogger log)
        {
            log.LogInformation($"C# Queue trigger function processed: {myQueueItem}");
        }
    }
}
