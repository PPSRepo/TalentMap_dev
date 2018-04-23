lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.home').controller('adminHomeController', adminHomeController);

    function adminHomeController($scope, User, $timeout, $filter, $rootScope, $location) {
        
        
        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(1);
            $scope.$apply(function(){
                $scope.changeTab("adminHome");
            });
            
        },500);

    }
})();