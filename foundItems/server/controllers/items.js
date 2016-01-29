var mongoose = require('mongoose');
var Item = mongoose.model('Item');
var base64 = require('node-base64-image');
var Mailgun = require('mailgun-js');
//Your api key, from Mailgun’s Control Panel
var api_key = 'key-c7e0289dd74b8c0ea69ea14af0305105';

//Your domain, from the Mailgun Control Panel
var domain = 'sandbox2e255836ea0f4c41bf7520e4c3e4db1e.mailgun.org';

//Your sending email address
var from_who = 'shopping@foundItems.com';

module.exports = (function(){
	return {
		index: function(req, res){
			Item.find({}, function(err, results){
				if(err){
					console.log(err);
				}else{
					res.json(results);
				}
			})
		},

		addItem: function(req, res){
			
		  	var date_fName = new Date();
		  	var fName = "./client/requestImages/"+date_fName.toString();
		  	var cName = "requestImages/" + date_fName.toString() + ".jpg";

		  	var options = {filename: fName};
		  	var imageData = new Buffer(req.body.image.file_data, 'base64');
		  	base64.base64decoder(imageData, options, function(err, saved){
		  		if(err) {console.log(err);}
		  		console.log("Saved????", saved);
		  		var data = {userName: req.body.userName, location: req.body.location, itemName: req.body.itemName, detail: req.body.detail, locationY: req.body.locationY, locationX: req.body.locationX, imageUrl: cName, createdAt: new Date()};
		  		console.log("data for DB: ", data);
		  		var item = new Item(data);
				item.save(function(err){
					if(err){
						console.log(err);
					}else{
						
						res.json("done");
					}
				})
			 });
		},

		addFound: function(req, res){
			//save image on the server
			//then update the Item with iid
			var date_fName = new Date();
			console.log("addFound Data: ", req.body.iid);
		  	var fName = "./client/foundImages/"+date_fName.toString();
		  	var cName = "foundImages/" + date_fName.toString() + ".jpg";

		  	var options = {filename: fName};
		  	var imageData = new Buffer(req.body.image.file_data, 'base64');
		  	base64.base64decoder(imageData, options, function(err, saved){
		  		if(err) {console.log(err);}
		  		console.log("Saved????", saved);

				var foundData = {imageUrl: cName, storeName: req.body.storeName, price: req.body.price, detail: req.body.detail, foundDate: new Date(), locationX: req.body.locationX, locationY: req.body.locationY}
				//@@@@@ have to get from req.body.iid
				var iid = req.body.iid

				Item.findOneAndUpdate({_id: iid}, {$push: {founds: {$each: [foundData]}}}, function(err, result){
					if(err){
						console.log(err);
						res.json(err);
					}else{
						if(result.userName != "test"){  //user signed in
							console.log("email request accepted!");
	      					//We pass the api_key and domain to the wrapper, or it won't be able to identify + send emails
	    					var mailgun = new Mailgun({apiKey: api_key, domain: domain});

						    var data = {
						    //Specify email data
						      from: from_who,
						    //The email to contact
						      to: result.userName,
						    //Subject and text data  
						      subject: 'We found your item today!',
						      html: 'Congraturation! We found your wish item, ' + result.itemName
						    }

						     mailgun.messages().send(data, function (err, body) {
						        //If there is an error, render the error page
						        if (err) {
						            res.render('email error');
						            console.log("got an error: ", err);
						        }
						        //Else we can greet    and leave
						        else {
						            //Here "submitted.jade" is the view file for this landing page 
						            //We pass the variable "email" from the url parameter in an object rendered by Jade
						            res.render('submitted');
						            console.log(body);
						        }
						 	})
						 }  // end of email
						console.log('successfully add FoundItem', result);
						res.json(result);
					} // end of not error
				});
			});
		} //end of addFound
	} //end of return	
})();