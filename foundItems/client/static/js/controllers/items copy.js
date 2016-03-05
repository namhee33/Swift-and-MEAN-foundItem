module.controller("itemsController", function($scope, userFactory, itemFactory, $routeParams){
	
	var imageData;

	$scope.setFile = function(element){
		$scope.currentFile = element.files[0];
		var reader = new FileReader();

		reader.onload = function(event){
			$scope.image_source = event.target.result;
			$scope.$apply();
			getBase64Image(function(data){
				
				// console.log("encodedImage: ", encodedImg);
				imageData =  JSON.stringify(data);
				// console.log("Json image: ", imageData);
			});
		}
		reader.readAsDataURL(element.files[0]);
	}

	$scope.index = function(){
		console.log("user:"+ $scope.user)
		itemFactory.getItems()
	
		if($scope.user === undefined){
			console.log("here")
			console.log($routeParams.id)
			userFactory.findUser($routeParams.id)
			userFactory.getUser();

		}

	}

	$scope.createItem = function(){
		// console.log("Create Item", $scope.itemInfo, $scope.user);
		// var allInfo = {item: $scope.itemInfo, img: compressed_image, user: $scope.user};
		var userInfo = {name: "test", email: "test@gmail.com"};
		var allInfo = {item: $scope.itemInfo, img: imageData, user: userInfo};
		itemFactory.createItem(allInfo, function(data){

		});
	}
	$scope.index();

	function getBase64Image(callback) {
// imgElem must be on the same server otherwise a cross-origin error will be thrown "SECURITY_ERR: DOM Exception 18"
		var mime_type = "image/png";
		var quality = 50;

		var img = document.getElementById("itemImage")
		var cvs = document.getElementById("myCanvas");
		
		var ctx = cvs.getContext("2d");
		ctx.drawImage(img, 0,0);
		var newImageData = cvs.toDataURL(mime_type, quality/100);
	    var compressed_image = new Image();
	    compressed_image.src = newImageData;
	    var encoding =  compressed_image.src.replace(/^data:image\/(png|jpg);base64,/, "");
	    callback(encoding);
     }
})

// function getBase64Image(callback) {
// imgElem must be on the same server otherwise a cross-origin error will be thrown "SECURITY_ERR: DOM Exception 18"
	// var mime_type = "image/png";
	// var quality = 50;

	// var img = document.getElementById("itemImage")
	// var cvs = document.getElementById("myCanvas");
	
	// var ctx = cvs.getContext("2d");
	// ctx.drawImage(img, 0,0);
	// var newImageData = cvs.toDataURL(mime_type, quality/100);
 //     compressed_image = new Image();
 //     compressed_image.src = newImageData;
 //     var encoding =  compressed_image.src.replace(/^data:image\/(png|jpg);base64,/, "");
 //      callback(encoding);
     // console.log("compressedImage ", compressed_image.height);
     // encodedImg = btoa(compressed_image.src);
     // console.log("Base 64: ", base64);

	// cvs.height = $scope.image_source.height;
	// console.log("width, height on canvas ", cvs.width, cvs.height);
    // var canvas = document.createElement("canvas");
    // canvas.width = imgElem.clientWidth;
    // canvas.height = imgElem.clientHeight;
    // var ctx = canvas.getContext("2d");
    // ctx.drawImage(imgElem, 0, 0);
    // var dataURL = canvas.toDataURL("image/png");
    // var encoding = dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
   
// }