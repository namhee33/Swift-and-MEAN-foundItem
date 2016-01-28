var express = require('express');

var path = require('path');
var app = express();

var bodyParser = require('body-parser');

var nodemailer = require('nodemailer');

// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded());

app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}))

app.use(express.static(path.join(__dirname, './client')));

// app.use(express.static(path.join(__dirname, './server/images')));

require('./config/mongoose.js');
require('./config/routes.js')(app);
app.listen(7000, function() {
  console.log('cool stuff on: 7000');
});