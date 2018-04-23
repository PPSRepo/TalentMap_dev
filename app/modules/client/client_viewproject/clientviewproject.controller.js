(function() {
    'use strict';

    angular.module('app.client.clientviewproject').controller('ClientViewProjectController', ClientViewProjectController);

    function ClientViewProjectController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $timeout(function() {
            $scope.$apply(function() {
                $scope.changeTab("clientViewProject");
            });

        }, 500);

    }
})();