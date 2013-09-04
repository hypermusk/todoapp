todoapi.baseurl="http://localhost:9000/api";
var appservice = new todoapi.AppService();
var userservice = appservice.GetUserService("admin@example.com", "nimda");

var todoApp = angular.module('todoApp', []);


todoApp.directive('ngEnter', function () {
	return function (scope, element, attrs) {
		element.bind("keydown keypress", function (event) {
			if(event.which === 13) {
				scope.$apply(function (){
					scope.$eval(attrs.ngEnter);
				});

				event.preventDefault();
			}
		});
	};
});

function TodoListCtrl($scope) {
	userservice.GetTodoLists(function(list, err){
		$scope.$apply(function(){
			$scope.todo_lists = list;
			if(list.length > 0) {
				$scope.selectedListId = list[0].Id;
				$scope.refreshTodoItems($scope.selectedListId);
			}
		});

	});

	$scope.refreshTodoItems = function(listId) {
		userservice.GetTodoItems(listId, function(items, err){
			$scope.$apply(function(){
				$scope.current_items = items;
			});
		})
	};

	$scope.chooseList = function(selectedScope) {
		$scope.selectedListId = selectedScope.l.Id;
		$scope.refreshTodoItems($scope.selectedListId);
	};

	$scope.addItem = function(evt) {
		userservice.CreateTodo($scope.selectedListId, $scope.newTodoItemContent, function(err){
			$scope.refreshTodoItems($scope.selectedListId);
			$scope.newTodoItemContent = "";
		})
	};
}
