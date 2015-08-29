'use strict';

app.directive('astro', function(){
	return{
		restrict: 'AE',
		transclude: true,
		scope:{
			list: '@',
			slides: '@',
			// interval: '@',
			// noWrap: '@',
			// option: '=',
			selected:'=selected'
		},
		controller: 'AstroController',
		templateUrl: '/templates/directives/templates/astro_carousel.html.haml',
		link: function(scope, instanceElement, instanceAttributes, controller, transcludeFunction){
			// scope.$watch('slides', function(newValue, oldValue) {
   //              if (newValue){
   //              	var active = true;
   //              	angular.forEach(newValue, function(index){
   //              		alert(index.title);
   //              		index['active'] = active;
   //              		active = false;
   //              		alert(index.active);
   //              	})
   //              }
   //          });
		}
	}
})