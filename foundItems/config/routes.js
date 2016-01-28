var items = require('./../server/controllers/items.js');
var nodemailer = require('nodemailer');



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
    var transporter = nodemailer.createTransport({
        service: 'Gmail',
        auth: {
            user: 'namhee33@gmail.com', // Your email id
            pass: 'wschae!26' // Your password
        }
    });

    var bodyText = "hello from shopping"

    var mailOptions = {
      from: 'namhee33@gmail.com>', // sender address
      to: 'namhee33@gmail.com', // list of receivers
      subject: 'Email Test', // Subject line
      text: bodyText //, // plaintext body
      // html: '<b>Hello world ✔</b>' // You can choose to send an HTML body instead
    };

    transporter.sendMail(mailOptions, function(error, info){
      if(error){
          console.log(error);
          res.json({yo: 'error'});
      }else{
          console.log('Message sent: ' + info.response);
          res.json({yo: info.response});
      };
    });


  })
}