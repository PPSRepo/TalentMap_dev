(function() {
    'use strict';

    angular.module('app.talent.talentlogin').controller('TalentLoginController', TalentLoginController);

    function TalentLoginController($scope, User, $timeout, $filter, InvokeAPICall, $rootScope, $location) {
        $scope.login = {};
        $scope.registration = {};
        $scope.logintalent = function() {

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
                "user_type": 2
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.loginStatus == 200) {
                        User.loginUser(receivedData);
                        $scope.goToPage("/talent/talenthome");
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


        $scope.registerUser = function() {
            $scope.registrationErrorMessage = "";
            $scope.registrationSuccessMessage = "";

            var emailId = $scope.registration.emailId;
            var password = $scope.registration.password;
            var confirmpassword = $scope.registration.confirmpassword;
            var firstName = $scope.registration.firstName;
            var lastName = $scope.registration.lastName;

            if (firstName.isEmpty() || lastName.isEmpty()) {
                $scope.registrationErrorMessage = "First and last name is required <br>";
            }

            if (emailId.isEmpty() || !window.config.emailRegEx.test(emailId)) {
                $scope.registrationErrorMessage += "Enter valid email ID.<br> ";
            }

            if (password.isEmpty() || confirmpassword.isEmpty() || password !== confirmpassword) {
                $scope.registrationErrorMessage += "Password and confirm password should match.";
            }
            if ($scope.registrationErrorMessage != "") {
                return
            }

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "registerUser";
            param.data = {
                "email": emailId,
                "password": password,
                "firstname": firstName,
                "lastname": lastName,
                "userType": 2
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

        $timeout(function() {
            $scope.login.username = "parth_shah9478@yahoo.com";
            $scope.login.password = "abc1234";
        })

        //  }
    }
})();