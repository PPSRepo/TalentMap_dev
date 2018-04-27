lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.home').controller('adminHomeController', adminHomeController);

    function adminHomeController($scope, User, $timeout, $filter, InvokeAPICall, $rootScope, $location) {

        $scope.getInitData = function() {

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getAdminDashboardCounterData";
            param.data = {

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    config.project_status = receivedData.project_status;
                    config.sponsor_list = receivedData.sponsor;
                    $scope.proposedProjectCount = receivedData.counter[0].proposed_project_count;
                    $scope.clientRegistrationRequestCount = receivedData.counter[0].client_registration_count;
                    $scope.totalNotification = $scope.proposedProjectCount + $scope.clientRegistrationRequestCount;
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





        $scope.selectTab = function(tab) {
            $scope.selectedTab = tab;
        }
        $timeout(function() {
            $scope.selectTab(1);
            $scope.getInitData();
            $scope.$apply(function() {
                $scope.changeTab("adminHome");
            });

        }, 500);

    }
})();