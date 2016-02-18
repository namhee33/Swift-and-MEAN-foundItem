module.controller("usersController", function(userFactory, $location){
	var _this = this;
	this.signup = function(){
		userFactory.create(_this.user, function(data){
			// if (data.message){
			// 	_this.message = data;
			// }
			// else {
			// 	_this.user = data.user;
				// userFactory.loggedin(_this.user, function(data){
				// 	console.log("loggedin")
				// })
			console.log("data from server: ", data);
			
		})
	}
})