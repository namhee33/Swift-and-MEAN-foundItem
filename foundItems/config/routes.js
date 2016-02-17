var items = require('./../server/controllers/items.js');

module.exports = function(app, passport) {
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

  app.post("/signup", passport.authenticate("local-signup"), function(req, res){
      console.log("RES", res);
      // res.json({user: req.user});
    }
  )
}