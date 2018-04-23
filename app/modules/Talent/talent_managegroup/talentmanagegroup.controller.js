(function() {
    'use strict';

    angular.module('app.talent.talentManageGroup').controller('TalentManageGroupController', TalentManageGroupController);

    function TalentManageGroupController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {


        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(1);
        $timeout(function() {
            $scope.$apply(function() {
                $scope.changeTab("talentManageGroup");
            });

        }, 500);
    });
        
    }
})();