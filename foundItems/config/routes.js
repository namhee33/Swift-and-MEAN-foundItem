var items = require('./../server/controllers/items.js');
var Mailgun = require('mailgun-js');
//Your api key, from Mailgun’s Control Panel
var api_key = 'key-c7e0289dd74b8c0ea69ea14af0305105';

//Your domain, from the Mailgun Control Panel
var domain = 'sandbox2e255836ea0f4c41bf7520e4c3e4db1e.mailgun.org';

//Your sending email address
var from_who = 'shopping@foundItems.com';

module.exports = function(app) {
	
  app.get('/items', function(req, res) {
  	console.log("index request from client!");
    items.index(req, res);
  });

  app.post('/items', function(req, res) {
    items.addItem(req, res);
  });

  app.post('/addFound', function(req, res){
  	console.log("addFound requested from client!!!");
  	items.addFound(req, res);
  });

  app.post('/emailMe', function(req, res){
    console.log("email request accepted!");
      //We pass the api_key and domain to the wrapper, or it won't be able to identify + send emails
    var mailgun = new Mailgun({apiKey: api_key, domain: domain});

    var data = {
    //Specify email data
      from: from_who,
    //The email to contact
      to: "namhee33@gmail.com",
    //Subject and text data  
      subject: 'Hello from Mailgun',
      html: 'Hello, This is not a plain-text email, I wanted to test some spicy Mailgun sauce in NodeJS! <a href="http://0.0.0.0:3030/validate?' + " " + '">Click here to add your email address to a mailing list</a>'
    }

     mailgun.messages().send(data, function (err, body) {
        //If there is an error, render the error page
        if (err) {
            res.render('error', { error : err});
            console.log("got an error: ", err);
        }
        //Else we can greet    and leave
        else {
            //Here "submitted.jade" is the view file for this landing page 
            //We pass the variable "email" from the url parameter in an object rendered by Jade
            res.render('submitted');
            console.log(body);
        }
    });
  });
}