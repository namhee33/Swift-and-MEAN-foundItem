module.controller("itemsController", function(userFactory, itemFactory){
	var _this = this;
	this.index = function(){
		_this.user = userFactory.getUser()
		itemFactory.getItems()
	}
	this.index();
})