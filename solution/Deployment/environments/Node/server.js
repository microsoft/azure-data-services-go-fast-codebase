var static = require('node-static');
var http = require('http');
// Import the path module
const path = require('path');
var fs = require('fs');

var directory = path.resolve(__dirname + "/../");
var file = new(static.Server)(directory, { cache: 1 });

http.createServer(function (req, res) {  
  
  if (req.method === "GET")
  {
    file.serve(req, res);
  }
  else
  {    
    var body = '';
    filePath = directory + '/development.json';
    req.on('data', function(data) {
        body += data;
        body = decodeURI(body);
        body = JSON.parse(body);
        body = JSON.stringify(body, null, 2);
        //body = body.replace("\n", "\r\n");
    });

    req.on('end', function (){
        fs.writeFile(filePath, body, function() {
            res.end();
        });
    });
  }
}).listen(8080);



