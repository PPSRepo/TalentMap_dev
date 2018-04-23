lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.manageSponser').controller('manageSponserController', manageSponserController);

    function manageSponserController($scope, User, $timeout, $filter, $rootScope, $location) {
        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(1);
        });
    }
})();