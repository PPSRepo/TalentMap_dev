(function() {
    'use strict';

    angular.module('app.talent.talentHome').controller('TalentHomeController', TalentHomeController);

    function TalentHomeController($scope, User, $timeout, $filter, InvokeAPICall, $rootScope, $location) {
        //TODO
    
        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }

        $timeout(function(){
            $scope.selectTab(1);
            $timeout(function() {
                $scope.$apply(function() {
                $scope.changeTab("talentHome");
                });

        }, 500);
    });



    }
})();