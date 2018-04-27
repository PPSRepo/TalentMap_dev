lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.login').controller('adminLoginController', adminLoginController);

    function adminLoginController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $scope.login = {
            username: "admin",
            password: 'admin123'
        }
        $scope.getAdminHome = function() {
            var param = {};
            $scope.goToPage("/admin/home");
        };
    }
})();