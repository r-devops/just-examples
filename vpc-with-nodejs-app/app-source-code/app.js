const http = require('http');
const os = require('os');

console.log("bogo server starting and listening on 8080...");

var handler = function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress);
  response.writeHead(200);
  response.end("Hello World, my host ip is: " + os.hostname() + "\n");
};

var www = http.createServer(handler);
www.listen(8080);
