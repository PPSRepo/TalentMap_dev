(function() {
    'use strict';

    angular.module('app.client.clientaddproject').controller('ClientAddProjectController', ClientAddProjectController);

    function ClientAddProjectController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $scope.project = {};



        $timeout(function() {
            $scope.$apply(function() {
                $scope.changeTab("clientAddProject");
            });

        }, 500);

    }
})();