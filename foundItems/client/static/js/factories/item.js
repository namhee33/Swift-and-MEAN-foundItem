module.factory("itemFactory", function($http, uploadsService){
	var factory = {};

	factory.getItems = function(){
		$http.get("/items").success(function(data){
			console.log(data);
		})
	}

	factory.createItem = function(allInfo, callback){
		 uploadsService.uploadFile(allInfo).then(function(promise){
                $scope.code = promise.code();
                $scope.fileName = promise.fileName();
         });
	}
	return factory;
});

module.service('uploadsService', function($http) {   

    var code = '';
    var fileName = '';


    this.uploadFile = function(allInfo) {


        var fd = new FormData();

        //Take the first selected file
        console.log("Factory: ", allInfo.item, allInfo.user);
        fd.append("file", allInfo.img);
        fd.append("itemName",allInfo.item.itemName);
        fd.append("location", allInfo.item.location);
        fd.append("detail", allInfo.item.detail);
        fd.append("email", allInfo.user.email);
       

        var promise =  $http.post('/addItems', fd, {
                withCredentials: true,
                headers: {'Content-Type': undefined },
                transformRequest: angular.identity
            }).then(function(response) {

            code = response.data.code;
            fileName = response.data.fileName;

            return{
                code: function() {
                    return code;
                },
                fileName: function() {
                    return fileName;
                }
            }; 
        });
        return promise;
    };

  });


// module.service('fileUploadService', ['$http', function ($http) {
//   this.uploadFileToUrl = function(file, uploadUrl, params){
//     var fd = new FormData();
//     fd.append('file', file);
//     promise = $http.post(uploadUrl, fd, {
//       transformRequest: angular.identity,
//       headers: {'Content-Type': undefined},
//       params: params
//     });
//     return promise;
//   }
// }]);