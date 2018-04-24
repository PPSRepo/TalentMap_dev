(function() {
    'use strict';

    angular.module('app.client.clientviewproject').controller('ClientViewProjectController', ClientViewProjectController);

    function ClientViewProjectController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {



        $scope.viewProjectDetails = function(project) {

            $scope.project = {};

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getClientProjectList";
            param.data = {
                 "user_id": 16,
               // "project_id": 1

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    $scope.projects = responseData.data.records;

                   
                }
            }
            var failure = function(responseData) {
                if (responseData.status == config.statusCode.taskIncompleted) {
                    //called api unable to complete asked task
                    console.log("Api didn't completed task");
                } else if (responseData.status == config.statusCode.invalidApiName) {
                    //apiName mentioned donot exists.
                    console.log("Invalid apiname");
                }
            }
            InvokeAPICall.makeCall(param, success, failure);
        };
        
        $timeout(function() {
            $scope.viewProjectDetails();
        $timeout(function() {
            $scope.$apply(function() {
                $scope.changeTab("clientViewProject");
            });

        }, 500);
    })
    $scope.tableShow = true;
    $scope.showDetails = function(project){
        $scope.displayProject = project;
        $scope.tableShow = !$scope.tableShow;
    }


    }
})();