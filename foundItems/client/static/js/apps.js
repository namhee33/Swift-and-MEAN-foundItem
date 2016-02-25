var module = angular.module("myApp", ["ngRoute", "ngMessages"]);

module.config(function($routeProvider){
	$routeProvider
	.when("/", {
		templateUrl: "static/partials/home.html",
		controller: "usersController as UC"
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
	.when("/dashboard/:id", {
		templateUrl: "static/partials/dashboard.html",
		controller: "itemsController as IC"
	})
	.when("/newItem", {
		templateUrl: "static/partials/new.html",
		controller: "itemsController as IC"
	})
	.otherwise({
		redirectTo: "/"
	})
})