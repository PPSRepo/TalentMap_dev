lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.manageClient').controller('manageClientController', manageClientController);

    function manageClientController($scope, User, $timeout, $filter, $rootScope, $location) {
        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(1);
            
        });
    }
})();