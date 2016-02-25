module.controller("itemsController", function(userFactory, itemFactory, $routeParams){
	var _this = this;
	this.index = function(){
		console.log("user:"+_this.user)
		itemFactory.getItems()
	
		if(_this.user === undefined){
			console.log("here")
			console.log($routeParams.id)
			userFactory.findUser($routeParams.id)
			userFactory.getUser();

		}

	}
	this.createItem = function(){
		console.log(_this.itemInfo, _this.user)
		//itemFactory.createItem(_this.itemInfo)
	}
	this.index();
})