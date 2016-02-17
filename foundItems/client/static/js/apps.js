var module = angular.module("myApp", ["ngRoute", "ngMessages"]);

module.config(function($routeProvider){
	$routeProvider
	.when("/", {
		templateUrl: "static/partials/home.html"
	})
	.when("/login", {
		templateUrl: "static/partials/login.html"
	})
	.when("/signup", {
		templateUrl: "static/partials/signup.html",
		controller: "usersController as UC"
	})
	.otherwise({
		redirectTo: "/"
	})
})