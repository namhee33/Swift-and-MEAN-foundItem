var module = angular.module("myApp", ["ngRoute", "ngMessages"]);

module.config(function($routeProvider){
	$routeProvider
	.when("/", {
		templateUrl: "static/partials/home.html"
	})
	.when("/login", {
		templateUrl: "static/partials/login.html",
		controller: "usersController as UC"
	})
	.when("/signup", {
		templateUrl: "static/partials/signup.html",
		controller: "usersController as UC"
	})
	.when("/dashboard", {
		templateUrl: "static/partials/dashboard.html",
		controller: "itemsController as IC"
	})
	.when("/show", {
		templateUrl: "static/partials/show.html",
		controller: "mapsController as MC"
	})
	.otherwise({
		redirectTo: "/"
	})
})

// module.directive('mapCanvas', function(){
// 	return{
// 		restrict: 'E',
// 		link: function(scope, element){
// 			var mapOptions = {
// 				zoom: 8,
// 				center: new google.maps.LatLng(-34.397, 150.644)

// 			};

// 			new google.maps.Map(element[0], mapOptions);

// 		}
// 	};
// });

// formats a number as a latitude (e.g. 40.46... => "40°27'44"N")
module.filter('lat', function () {
    return function (input, decimals) {
        if (!decimals) decimals = 0;
        input = input * 1;
        var ns = input > 0 ? "N" : "S";
        input = Math.abs(input);
        var deg = Math.floor(input);
        var min = Math.floor((input - deg) * 60);
        var sec = ((input - deg - min / 60) * 3600).toFixed(decimals);
        return deg + "°" + min + "'" + sec + '"' + ns;
    }
});

// formats a number as a longitude (e.g. -80.02... => "80°1'24"W")
module.filter('lon', function () {
    return function (input, decimals) {
        if (!decimals) decimals = 0;
        input = input * 1;
        var ew = input > 0 ? "E" : "W";
        input = Math.abs(input);
        var deg = Math.floor(input);
        var min = Math.floor((input - deg) * 60);
        var sec = ((input - deg - min / 60) * 3600).toFixed(decimals);
        return deg + "°" + min + "'" + sec + '"' + ew;
    }
});


// - Documentation: https://developers.google.com/maps/documentation/
module.directive("mapCanvas", function () {
    return {
        restrict: "E",
        replace: true,
        template: "<div></div>",
        scope: {
            center: "=",        // Center point on the map (e.g. <code>{ latitude: 10, longitude: 10 }</code>).
            markers: "=",       // Array of map markers (e.g. <code>[{ lat: 10, lon: 10, name: "hello" }]</code>).
            width: "@",         // Map width in pixels.
            height: "@",        // Map height in pixels.
            zoom: "@",          // Zoom level (one is totally zoomed out, 25 is very much zoomed in).
            mapTypeId: "@",     // Type of tile to show on the map (roadmap, satellite, hybrid, terrain).
            panControl: "@",    // Whether to show a pan control on the map.
            zoomControl: "@",   // Whether to show a zoom control on the map.
            scaleControl: "@"   // Whether to show scale control on the map.
        },
        link: function (scope, element, attrs) {
            var toResize, toCenter;
            var map;
            var currentMarkers;

            // listen to changes in scope variables and update the control
            var arr = ["width", "height", "markers", "mapTypeId", "panControl", "zoomControl", "scaleControl"];
            for (var i = 0, cnt = arr.length; i < arr.length; i++) {
                scope.$watch(arr[i], function () {
                    cnt--;
                    if (cnt <= 0) {
                        updateControl();
                    }
                });
            }

            // update zoom and center without re-creating the map
            scope.$watch("zoom", function () {
                if (map && scope.zoom)
                    map.setZoom(scope.zoom * 1);
            });
            scope.$watch("center", function () {
            	console.log("center updated####");
                if (map && scope.center)
                    map.setCenter(getLocation(scope.center));
            });
            scope.$watch("markers", function(){
            	console.log("Marker Updates@@@@@");
            	if(map && scope.markers)
            		updateMarkers();
            });

            // update the control
            function updateControl() {

                // update size
                if (scope.width) element.width(scope.width);
                if (scope.height) element.height(scope.height);

                // get map options
                var options =
                {
                    center: new google.maps.LatLng(40, -73),
                    zoom: 6,
                    mapTypeId: "roadmap"
                };
                if (scope.center) options.center = getLocation(scope.center);
                if (scope.zoom) options.zoom = scope.zoom * 1;
                if (scope.mapTypeId) options.mapTypeId = scope.mapTypeId;
                if (scope.panControl) options.panControl = scope.panControl;
                if (scope.zoomControl) options.zoomControl = scope.zoomControl;
                if (scope.scaleControl) options.scaleControl = scope.scaleControl;

                // create the map
                map = new google.maps.Map(element[0], options);

                // update markers
                updateMarkers();

                // listen to changes in the center property and update the scope
                google.maps.event.addListener(map, 'center_changed', function () {

                    // do not update while the user pans or zooms
                    if (toCenter) clearTimeout(toCenter);
                    toCenter = setTimeout(function () {
                        if (scope.center) {

                            // check if the center has really changed
                            if (map.center.lat() != scope.center.lat ||
                                map.center.lng() != scope.center.lon) {

                                // update the scope and apply the change
                                scope.center = { lat: map.center.lat(), lon: map.center.lng() };
                                if (!scope.$$phase) scope.$apply("center");
                            }
                        }
                    }, 500);
                });

                google.maps.event.addListener(map, 'markers_changed', function () {
                	console.log("Marker Event Listener$$$");
                })
            }



            // update map markers to match scope marker collection
            function updateMarkers() {
                if (map && scope.markers) {

                    // clear old markers
                    // if (currentMarkers != null) {
                    //     for (var i = 0; i < currentMarkers.length; i++) {
                    //         currentMarkers[i] = m.setMap(null);
                    //     }
                    // }

                    // create new markers
                    currentMarkers = [];
                    var markers = scope.markers;
                    if (angular.isString(markers)) markers = scope.$eval(scope.markers);
                    
                    for (var i = 0; i < markers.length; i++) {
                    	
                        var m = markers[i];
                        var loc = new google.maps.LatLng(m.lat, m.lon);
                        
                        var mm = new google.maps.Marker({ position: loc, map: map, title: m.name, icon: m.icon});
                        
                        currentMarkers.push(mm);
                    }
                }
            }

            // convert current location to Google maps location
            function getLocation(loc) {
                if (loc == null) return new google.maps.LatLng(40, -73);
                if (angular.isString(loc)) loc = scope.$eval(loc);
                return new google.maps.LatLng(loc.lat, loc.lon);
            }
        }
    };
 });