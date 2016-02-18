module.controller("usersController", function(userFactory, $location){
	var _this = this;
	this.signup = function(){
		this.errors = "";
		userFactory.create(_this.user, function(err, user){
			if (err.error != undefined){
				// console.log(err)
				_this.errors = err.error;
				console.log(this.errors)
			}
			// if (data.message){
			// 	_this.message = data;
			// }
			// else {
			// 	_this.user = data.user;
				// userFactory.loggedin(_this.user, function(data){
				// 	console.log("loggedin")
				// })
			// console.log("data from server: ", data);
			
		})
	}
	this.login = function(){
		userFactory.login(_this.user, function(data){

		})
	}
})