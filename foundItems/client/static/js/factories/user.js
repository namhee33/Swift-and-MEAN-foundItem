module.factory("userFactory", function($http){
	var factory = {};
	var user = {};
	factory.create = function(user, callback){
		$http.post("/signup", user).success(function(output){
			callback(output);
		})
	}
	return factory;
})