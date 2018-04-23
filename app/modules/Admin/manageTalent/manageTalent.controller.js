lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.manageTalent').controller('manageTalentController', manageTalentController);

    function manageTalentController($scope, User, $timeout, $filter, $rootScope, $location) {
        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(2);
        });
    }
})();