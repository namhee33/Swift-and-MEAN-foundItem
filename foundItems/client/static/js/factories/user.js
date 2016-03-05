module.factory("userFactory", function($http){
	var factory = {};
	var user = {};
	factory.create = function(userInfo, callback){
		$http.post("/signup", userInfo).success(function(output){
			user = output.user
			callback(output);
		})
	}
	factory.login = function(userInfo, callback){
		$http.post("/login", userInfo).success(function(output){
			user = output.user;
			callback(output);
		})
	}
	factory.findUser = function(id, callback){
		console.log("finding user")
		$http.get("/users/"+id).success(function(data){
			user = data[0];
			callback(data);
		})
	}

	factory.getUser = function(){
		return user;
	}

	
	return factory;
})