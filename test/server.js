var express = require('express'),
    bodyParser = require('body-parser'),
    methodOverride = require('method-override'),
    morgan = require('morgan'),
    restful = require('node-restful'),
    mongoose = restful.mongoose;
var app = express();

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({'extended':'true'}));
app.use(bodyParser.json());
app.use(bodyParser.json({type:'application/vnd.api+json'}));
app.use(methodOverride());

// Server static description file
app.use('/static', express.static(__dirname + '/data'));
// Add CORS headers
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
  res.header("Access-Control-Allow-Methods", "PUT, DELETE, GET, POST, PATCH");
  next();
});

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
mongoose.connect("mongodb://localhost/lssporeunittest");

var Products = app.products = restful.model('products', mongoose.Schema({
    name: String,
    sku: String,
    price: Number
  }))
  .methods(['get', 'put', 'post', 'delete', 'patch']);

Products.remove({}, function(err,removed) {
    console.log("Database cleaned")
});

Products.register(app,'/api/products');


// Launch server
app.listen(3000);
console.log('Server is running at port 3000')
