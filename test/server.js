// Requirement
var express = require('express'),
    restful = require('node-restful'),
    mongoose = restful.mongoose;
    bodyParser  = require('body-parser');

// Start app 
var app = express();
// Server static description file
app.use('/static', express.static(__dirname + '/data'));
// Add CORS headers
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
  res.header("Access-Control-Allow-Methods", "PUT, DELETE, GET, POST, PATCH");
  next();
});
// JSON parsing
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
// Simple static token authentication
app.use(function(req, res, next) {
  if (!req.headers.authorization) {
    res.json({ error: 'No credentials sent!' });
  } else {
    if (req.headers.authorization=="Token S3CR3T") {
        next();
    }
    else {
        res.json({ error: 'Wrong token' });
    }
  }
});
// Clean and connect to Database 
mongoose.connect("mongodb://localhost/sporelscunittest");
var db = mongoose.connection
var ProductSchema = mongoose.Schema({
    name: String,
    sku: String,
    price: Number
});
var Products = restful.model('products', ProductSchema);
Products.remove({}, function(err,removed) {
    console.log("Database cleaned")
});

Products.methods(['get', 'put', 'post', 'delete', 'patch']);
Products.register(app,'/api/products');

// Launch server
app.listen(3000);
console.log('Server is running at port 3000')