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

  app.get('/profile', function(req, res){
    console.log("profile requested", req.user);
    
    res.json({user: req.user});
  });

  app.get('/signupError', function(req, res){
    console.log("singup error: ");
    res.json({error: "The email is already taken"});
  });

  app.post('/signup', passport.authenticate('local-signup', {
        successRedirect : '/profile', // redirect to the secure profile section
        failureRedirect : '/signupError', // redirect back to the signup page if there is an error
        failureFlash : true // allow flash messages
    }));
}