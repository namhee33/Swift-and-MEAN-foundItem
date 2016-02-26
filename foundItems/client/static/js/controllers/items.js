module.controller("itemsController", function(userFactory, itemFactory, $routeParams){
	var _this = this;
	this.index = function(){
		itemFactory.getItems()
		if($routeParams.id){
			console.log("got some id")
			userFactory.findUser($routeParams.id, function(){
				_this.user = userFactory.getUser();
			});
		}
		else {
			_this.user = userFactory.getUser();
		}
	}
	this.createItem = function(){
		console.log(_this.itemInfo, _this.user)
		//itemFactory.createItem(_this.itemInfo)
	}
	this.index();
})