var mongoose = require("mongoose");
var User = require("../../app/models/user")


module.exports = (function(){
	return {
		index: function(req, res){
			User.find({_id: req.params.id}, function(err, results){
				if(err){
					console.log(err);
				}
				else{
					res.json(results);
				}
			})
		}
	}
})();