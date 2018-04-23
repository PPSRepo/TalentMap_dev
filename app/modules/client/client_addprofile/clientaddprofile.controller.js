(function() {
    'use strict';

    angular.module('app.client.clientaddprofile').controller('ClientAddProfileController', ClientAddProfileController);

    function ClientAddProfileController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {
        $scope.profile = {};

        $scope.getClientProfileDetails = function() {


            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getClientProfileDetails";
            param.data = {

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var profile = responseData.data.records[0];
                    $scope.profile.companyName = profile.first_name;
                    $scope.profile.address = profile.address;
                    $scope.profile.city = profile.city;
                    $scope.profile.phoneNumber = profile.phone_number;
                    $scope.profile.email = profile.email;
                    $scope.profile.postcode = profile.postal;
                    $scope.profile.state = profile.state;
                    $scope.profile.numberofEmployee = 0; //profile.first_name;
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
        $scope.updateProfile = function() {
            $scope.loginerror = "";

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "updateClientProfileDetails";
            param.data = {
                "first_name": $scope.profile.companyName,
                "last_name": "(Company)",
                "phone_number": $scope.profile.phoneNumber,
                "address": $scope.profile.address,
                "city": $scope.profile.city,
                "state": $scope.profile.state,
                "postal": $scope.profile.postcode,
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.updateStatus == 200) {
                        alert("Details Updated successfully");
                    } else {
                        alert("Details NOT Updated. Please try again");
                    }
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
            $scope.getClientProfileDetails();
            $timeout(function() {
                $scope.$apply(function() {
                    $scope.changeTab("clientProfile");
                });

            }, 500);
        });
    }
})();