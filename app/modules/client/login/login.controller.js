lsScope = "";
(function() {
    'use strict';

    angular.module('app.client.login').controller('ClientLoginCtrl', ClientLoginController);

    function ClientLoginController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $scope.login = {};
        $scope.registration = {};

        $scope.registerClient = function() {
            $scope.registrationErrorMessage = "";
            $scope.registrationSuccessMessage = "";

            var emailId = $scope.registration.emailId;
            if (emailId.isEmpty() || !window.config.emailRegEx.test(emailId)) {
                $scope.registrationErrorMessage = "Enter valid email ID";
                return;
            }

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "registerUserWithEmail";
            param.data = {
                "email": emailId,
                "userType": 3
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.resgistrationStatus == 1) {
                        $scope.registrationSuccessMessage = "Registration successful, You will shortly receive confirmation email";
                    } else {
                        $scope.registrationErrorMessage = receivedData.message;
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


        $scope.loginClient = function() {
            $scope.loginerror = "";
            var emailId = $scope.login.username;
            var password = $scope.login.password;
            if (emailId.isEmpty() || !window.config.emailRegEx.test(emailId) || password.isEmpty()) {
                $scope.loginerror = "Enter valid email ID and password";
                return;
            }
            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "loginUser";
            param.data = {
                "email": emailId,
                "password": password,
                "user_type": 3
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.loginStatus == 200) {
                        User.loginUser(receivedData);
                        $scope.goToPage("/client/clienthome");
                    } else {
                        $scope.loginerror = receivedData.loginMessage;
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
            $scope.username = "parth_shah9478@yahoo.com";
            $scope.password = "abc1234";
        })
    }
})();