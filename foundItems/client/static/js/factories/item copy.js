module.factory("itemFactory", function($http, fileUploadService){
	var factory = {};

	factory.getItems = function(){
		$http.get("/items").success(function(data){
			console.log(data);
		})
	}

	factory.createItem = function(allInfo, callback){
		// console.log("Factory new Item Info: ", allInfo);
		var uploadUrl = '/addItems';
		$http.post("/addItems", allInfo, {headers: {'Content-Type': 'application/json' }}).success(function(data){
			console.log("successfully upload");
		})
    	// fileUploadService.uploadFileToUrl(allInfo, uploadUrl, {}).then(function(resp) {
     //    	// handle response
    	// })
		// $http.post("/addItems", allInfo, { headers: {'Content-Type': 'multipart/form-data' }}).success(function(data){
		// 	console.log("successfully upload");
		// })
		// $http.post("/addItems", allInfo,  { headers: {'Content-Type': 'multipart/form-data' }}, {transformRequest: function (data, headersGetter) {
  //               var formData = new FormData();
  //               angular.forEach(data, function (value, key) {
  //                   formData.append(key, value);
  //               });

  //               var headers = headersGetter();
  //               delete headers['Content-Type'];

  //               return formData;
  //           }}).success(function(data){
		// 	console.log(data);
		// })
		
	}
	return factory;
});

module.service('fileUploadService', ['$http', function ($http) {
  this.uploadFileToUrl = function(file, uploadUrl, params){
    var fd = new FormData();
    fd.append('file', file);
    promise = $http.post(uploadUrl, fd, {
      transformRequest: angular.identity,
      headers: {'Content-Type': 'application/json'},
      params: params
    });
    return promise;
  }
}]);