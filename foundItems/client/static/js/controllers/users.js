module.controller("usersController", function(userFactory, $location){
	var _this = this;
	this.signup = function(){
		this.errors = "";
		userFactory.create(_this.userInfo, function(data){
			if (data.error != undefined){
				_this.errors = data.error;
			}
			else {
				_this.user = data.user;
				$location.path("/dashboard");
			}
		})
	}
	this.login = function(){
		this.errors = "";
		userFactory.login(_this.userInfo, function(data){
			if (data.error != undefined){
				_this.errors = data.error;
			}
			else {
				user = userFactory.getUser()
				console.log(user);
				// console.log(user.local.name)
				$location.path("/dashboard");
			}
		})
	}
	this.index = function(){
		_this.user = userFactory.getUser()

	}
	this.index()
})