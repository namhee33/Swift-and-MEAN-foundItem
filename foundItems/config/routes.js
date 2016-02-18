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
    console.log("signup error: ");
    res.json({error: "The email is already taken"});
  });

  app.get("/loginError", function(req, res){
    console.log("login error");
    res.json({error: "Invalid login or password"});
  })

  app.post('/signup', passport.authenticate('local-signup', {
        successRedirect : '/profile', // redirect to the secure profile section
        failureRedirect : '/signupError', // redirect back to the signup page if there is an error
        failureFlash : true // allow flash messages
  }));

  app.post("/login", passport.authenticate("local-login", {
    successRedirect : "/profile",
    failureRedirect: "/loginError",
    failureFlash: true
  }))

  app.get('/auth/twitter', passport.authenticate('twitter'));


  app.get('/auth/twitter/callback',
        passport.authenticate('twitter', {
            successRedirect : '/profile',
            failureRedirect : '/'
        }));


  app.get('/auth/google', passport.authenticate('google', { scope : ['profile', 'email'] }));

    // the callback after google has authenticated the user
  app.get('/auth/google/callback',
    passport.authenticate('google', {
            successRedirect : '/profile',
            failureRedirect : '/'
  }));

   
  app.get('/logout', function(req, res) {
      req.logout();
      res.redirect('/');
  });


  app.get('/auth/facebook', passport.authenticate('facebook', { scope : ['email'] }));

    // handle the callback after facebook has authenticated the user
  app.get('/auth/facebook/callback',
    passport.authenticate('facebook', {
        successRedirect : '/profile',
        failureRedirect : '/'
    })
  );

}