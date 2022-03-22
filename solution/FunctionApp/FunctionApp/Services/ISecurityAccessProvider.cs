/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace FunctionApp.Services
{    
    public interface ISecurityAccessProvider
    {
        public bool IsAuthorised(HttpRequest req, ILogger log);
    }
  
}
