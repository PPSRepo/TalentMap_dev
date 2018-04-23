lsScope = "";
(function() {
    'use strict';

    angular.module('app.home').controller('HomeController', HomeController);

    function HomeController($scope, User, $timeout, $filter, InvokeAPICall, $rootScope, $location) {

        $scope.gotoClientLogin = function() {
            $scope.goToPage("/client/login");
        };

        $scope.gotoAdminLogin = function() {
            $scope.goToPage("/admin/login");
        };

        $scope.gotoTalentLogin = function() {
            $scope.goToPage("/talent/login");
        };


        console.log(lsScope);
        $timeout(function() {
            $scope.setCurrentPageTitle("Talent Map - Home Page");
        });

    }
})();