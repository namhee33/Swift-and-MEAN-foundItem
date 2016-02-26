module.controller("mapsController", function($scope){
	
     
	// current location
    $scope.loc = { lat: 40, lon: -73 };
    $scope.items = [{ "name": "Prada", "color": "Black", "lat": 45.586541, "lon": -122.2921422}];
   
    $scope.gotoLocation = function (lat, lon) {
        if ($scope.lat != lat || $scope.lon != lon) {
            $scope.loc = { lat: lat, lon: lon };
            if (!$scope.$$phase){
                console.log("change to my location!", $scope.loc.lat, $scope.loc.lon);            
                $scope.$apply("loc");
                
            }
            $scope.addMarkers();
        }
    };

    $scope.addMarkers = function(){

        $scope.items = [];
        //https://maps.google.com/mapfiles/ms/icons/green-dot.png'
        $scope.items.push({"name":"Current Location", "lat":$scope.loc.lat, "lon":$scope.loc.lon, "icon":'https://maps.google.com/mapfiles/ms/icons/green-dot.png'});
        $scope.items.push({ "name": "Prada2", "color": "Black", "lat": 45.486541, "lon": -122.2921422});
        console.log("Items: ", $scope.items);
        $scope.$apply("items");
    }

    $scope.gotoCurrentLocation = function () {
        if("geolocation" in navigator) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var c = position.coords;
                $scope.gotoLocation(c.latitude, c.longitude);
            });
            return true;
        }
        return false;
    };
 
    $scope.gotoCurrentLocation();

});



// // - Documentation: https://developers.google.com/maps/documentation/
// module.directive('myMap', function() {
//     // directive link function
//     var link = function(scope, element, attrs) {
//         var map, infoWindow;
//         var markers = [];
        
//         // map config
//         var mapOptions = {
//             center: new google.maps.LatLng(50, 2),
//             zoom: 4,
//             mapTypeId: google.maps.MapTypeId.ROADMAP,
//             scrollwheel: false
//         };
        
//         // init the map
//         function initMap() {
//             if (map === void 0) {
//                 map = new google.maps.Map(element[0], mapOptions);
//             }
//         }    
        
//         // place a marker
//         function setMarker(map, position, title, content) {
//             var marker;
//             var markerOptions = {
//                 position: position,
//                 map: map,
//                 title: title,
//                 icon: 'https://maps.google.com/mapfiles/ms/icons/green-dot.png'
//             };

//             marker = new google.maps.Marker(markerOptions);
//             markers.push(marker); // add marker to array
            
//             google.maps.event.addListener(marker, 'click', function () {
//                 // close window if not undefined
//                 if (infoWindow !== void 0) {
//                     infoWindow.close();
//                 }
//                 // create new window
//                 var infoWindowOptions = {
//                     content: content
//                 };
//                 infoWindow = new google.maps.InfoWindow(infoWindowOptions);
//                 infoWindow.open(map, marker);
//             });
//         }
        
//         // show the map and place some markers
//         initMap();
        
//         setMarker(map, new google.maps.LatLng(51.508515, -0.125487), 'London', 'Just some content');
//         setMarker(map, new google.maps.LatLng(52.370216, 4.895168), 'Amsterdam', 'More content');
//         setMarker(map, new google.maps.LatLng(48.856614, 2.352222), 'Paris', 'Text here');
//     };
    
//     return {
//         restrict: 'A',
//         template: '<div id="gmaps"></div>',
//         replace: true,
//         link: link
//     };
// });