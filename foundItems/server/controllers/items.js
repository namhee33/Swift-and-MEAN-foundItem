var mongoose = require('mongoose');
var Item = mongoose.model('Item');
var base64 = require('node-base64-image');

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
						Item.find({}, function(err, results){
							if(err){
								console.log(err);
							}
						})
					}
				})
			 });
		},

		addFound: function(req, res){
			//save image on the server
			//then update the Item with iid
			var date_fName = new Date();
		  	var fName = "./client/foundImages/"+date_fName.toString();


		  	var options = {filename: fName};
		  	var imageData = new Buffer(req.body.image.file_data, 'base64');
		  	base64.base64decoder(imageData, options, function(err, saved){
		  		if(err) {console.log(err);}
		  		console.log("Saved????", saved);

				var foundData = {storeName: req.body.storeName, price: req.body.price, size: req.body.size, detail: req.body.detail, foundDate: new Date(), locationX: req.body.locationX, locationY: req.body.locationY}
				//@@@@@ have to get from req.body.iid
				var iid = "56a824fda8584898576552a4"

				Item.findOneAndUpdate({_id: iid}, {$push: {founds: {$each: [foundData]}}}, function(err, result){
					if(err){
						console.log(err);
						res.json(err);
					}else{
						console.log('successfully add FoundItem', result);
						res.json(result);
					}
				});
			});
		} //end of addFound
	} //end of return	
})();