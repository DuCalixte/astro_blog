'use strict';

app.factory('astroService', ['$http', function($http){
	return {
		data: function(url){
			return{}
			// 	$http.get(url)
			// 	.success(function(response){return response.data;})
			// 	.error(function(response){
			// 		alert(response.data.message);
			// 		return $q.reject(response.data.message);
			// 	});
			// }
		}
	}
}]);