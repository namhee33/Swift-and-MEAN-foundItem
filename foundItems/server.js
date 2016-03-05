var express = require('express');
var app = express();
var port = process.env.PORT || 8080;
var mongoose = require('mongoose');
var passport = require('passport');
var cookieParser = require('cookie-parser');
var path = require('path');
var Mailgun = require('mailgun-js');
var bodyParser = require('body-parser');
// image file upload
var multer = require('multer');
var multer_settings = multer({ dest: './uploads/'})

var configDB = require("./config/database.js");

mongoose.connect(configDB.url);
require("./config/passport")(passport);

/*take out from original Passport to remove flash message
var flash    = require('connect-flash');
var morgan       = require('morgan'); */
var session      = require('express-session');

// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded());
// app.use(morgan('dev'));
// app.use(cookieParser());
app.use(bodyParser());
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}))


app.use(passport.initialize());


app.use(express.static(path.join(__dirname, './client')));
app.use(express.static(__dirname + '/js'));

//require('./config/passport')(passport);

app.use(session({ secret: 'secretsessionpassword' })); // session secret
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
// app.use(flash()); // use connect-flash for flash messages stored in session


// app.use(express.static(path.join(__dirname, './server/images')));
// app.set('view engine', 'jade')
//require('./config/mongoose.js');
require('./config/routes.js')(app, passport);
app.listen(port, function() {
  console.log(port);
});