(function() {
    'use strict';

    angular.module('app.talent.talentManageProfile').controller('TalentManageProfileController', TalentManageProfileController);

    function TalentManageProfileController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $scope.selectTab = function(tab){
            $scope.selectedTab = tab;
        }
        $timeout(function(){
            $scope.selectTab(1);
            $timeout(function() {
                $scope.$apply(function() {
                    $scope.changeTab("talentManageProfile");
                });
    
            }, 500);
    
            
        });
        
    }
})();