todoapi.baseurl="http://localhost:9000/api";
var appservice = new todoapi.AppService();
var userservice = appservice.GetUserService("admin@example.com", "nimda");

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
}
