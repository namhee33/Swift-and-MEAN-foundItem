module.factory("itemFactory", function($http){
	var factory = {};

	factory.getItems = function(){
		$http.get("/items").success(function(data){
			console.log(data);
		})
	}

	return factory;
})