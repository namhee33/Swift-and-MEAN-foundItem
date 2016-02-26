module.controller("usersController", function(userFactory, $location, $routeParams){
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
				$location.path("/dashboard");
			}
		})
	}

	this.index = function(){
		itemFactory.getItems()
		if($routeParams.id){
			userFactory.findUser($routeParams.id, function(){
				_this.user = userFactory.getUser();
			});
		}
		else {
			_this.user = userFactory.getUser();
		}
	}

	this.index()
})