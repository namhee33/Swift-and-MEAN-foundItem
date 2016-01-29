var express = require('express');

var path = require('path');
var app = express();
var Mailgun = require('mailgun-js');
var bodyParser = require('body-parser');



// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded());

app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}))

app.use(express.static(path.join(__dirname, './client')));
app.use(express.static(__dirname + '/js'));

// app.use(express.static(path.join(__dirname, './server/images')));
app.set('view engine', 'jade')
require('./config/mongoose.js');
require('./config/routes.js')(app);
app.listen(7000, function() {
  console.log('cool stuff on: 7000');
});