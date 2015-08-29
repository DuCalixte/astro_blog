'use strict';

app.controller('AstroController',['$scope', '$http', '$q', function($scope, $http, $q){
	$scope.url = 'http://localhost:4000/v1/astro_serves';
	$scope.noWrap = false;
	$scope.interval = 0;
	// $scope.slides = astroService.data($scope.url);
	$http.get("http://localhost:4000/v1/astro_serves.json")
    .success(function(response) {
    	$scope.slides = response.astro_serves;})
    .error(function(response) {
    	alert(response);
    	$scope.slides = $q.reject(response);});
	$scope.list = {}
}])
