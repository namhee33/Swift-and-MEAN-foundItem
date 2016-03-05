var items = require('./../server/controllers/items.js');
var users = require('./../server/controllers/users.js');
var multer = require('multer');
var upload = multer({dest: 'fileUpload/'});
var type = upload.single('file');

module.exports = function(app, passport) {
  app.get('/items', function(req, res) {
    items.index(req, res);
  });

  app.get("/users/:id", function(req, res){
    users.index(req, res);
  })

  // addItems from iOS

  app.post('/items', function(req, res) {
    items.addItem(req, res);
  });

  // addItems from Web
  app.post('/addItems', type, function(req, res, next){
    items.addItemW(req,res);
  });

  app.post('/addFound', function(req, res){
  	console.log("addFound requested from client!!!");
  	items.addFound(req, res);
  });

  app.get('/localProfile', function(req, res){
    res.json({user: req.user});
  });

  app.get('/profile', function(req, res){
    res.redirect("/#/dashboard/"+req.user.id);
  
  });

  app.get('/signupError', function(req, res){
    console.log("signup error: ");
    res.json({error: "The email is already taken"});
  });

  app.get("/loginError", function(req, res){
    res.json({error: "Invalid login or password"});
  })


  app.post('/signup', passport.authenticate('local-signup', {
    successRedirect : '/localProfile',
    failureRedirect : '/signupError'
  }));

  app.post("/login", passport.authenticate("local-login", {
    successRedirect : "/localProfile",
    failureRedirect: "/loginError"
  }))

  app.get('/auth/twitter', passport.authenticate('twitter'));


  app.get('/auth/twitter/callback', passport.authenticate('twitter', {
    successRedirect : '/profile',
    failureRedirect : '/'
  }));


  app.get('/auth/google', passport.authenticate('google', { scope : ['profile', 'email'] }));

  app.get('/auth/google/callback', passport.authenticate('google', {
    successRedirect : '/profile',
    failureRedirect : '/'
  }));

   
  app.get('/logout', function(req, res) {
      req.logout();
      res.redirect('/');
  });


  app.get('/auth/facebook', passport.authenticate('facebook', { scope : ['email'] }));

  app.get('/auth/facebook/callback', passport.authenticate('facebook', {
    successRedirect : '/profile',
    failureRedirect : '/'
  }));

}