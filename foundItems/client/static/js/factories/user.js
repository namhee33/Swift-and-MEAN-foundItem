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
		console.log("factory login")
		$http.post("/login", userInfo).success(function(output){
			console.log(output);
			user = output.user;
			console.log("login");
			console.log(user);
			callback(output);
		})
	}
	factory.getUser = function(){
		console.log(user);
		return user;
	}

	factory.findUser = function(id, callback){
		console.log("finding user")
		$http.get("/users/"+id).success(function(data){
			console.log(data);
			user = data;
		})
	}
	return factory;
})