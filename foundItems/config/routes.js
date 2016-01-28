var items = require('./../server/controllers/items.js');



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
    res.json("no email");
  });
}