lsScope = "";
(function() {
    'use strict';

    angular.module('app.admin.manageClient').controller('manageClientController', manageClientController);

    function manageClientController($scope, User, $timeout, $filter, InvokeAPICall, $rootScope, $location) {


        //getting client registration request
        $scope.getRegistrationRequest = function() {

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getRegistrationRequestList";
            param.data = {

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    $scope.registrationRequest = receivedData.records;
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

        // setting Requester password
        $scope.sendRequesterPassword = function(request) {


            if (request.password.isEmpty()) {
                alert("Enter password for Email ID : " + request.email);
                return;
            }

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "setRequesterPassword";
            param.data = {
                raw_password: request.password,
                "user_id": request.user_id,
                "request_id": request.request_id
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.passwordSetStatus == 1) {
                        if (receivedData.mail.status == 200) {
                            alert("Password has been set for Email ID : " + request.email + " and Mail sent to user.");
                            request.request_fulfilled = 1;
                        } else {
                            var res = confirm("Password has been set for Email ID : " + request.email + " and Mail NOT sent to user. \n Do you Want to retry?");
                            if (!res)
                                request.request_fulfilled = 1;
                        }
                    } else {
                        alert("Opps, something went wrong. Please try again.");
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

        //getting client details
        $scope.getProposedProject = function() {


            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getClientProjectListForAdmin";
            param.data = {

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    $scope.projects = receivedData.records;

                    $scope.showProjectList = true;
                    $scope.$apply();
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
        $scope.project = {};
        $scope.getProjectDetails = function(project) {
            $scope.projectStatusList = config.project_status;
            $scope.sponsor_list = config.sponsor_list;
            $scope.project = project;
            $scope.showProjectList = false;
        }
        $scope.backToList = function() {
            $scope.showProjectList = !$scope.showProjectList;

        }

        //update project details
        $scope.submitProjectIdea = function() {


            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "updateClientProjectDetailsByAdmin";
            param.data = angular.copy($scope.project);
            param.data.project_status = $scope.project.project_status_id;

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.update_status == 1) {
                        alert("Details Updated successfully");
                        $scope.getProjectDetails();
                        $scope.backToList();
                    } else {
                        alert("Details not Updated successfully");
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

        //getting client details
        $scope.getClientList = function() {

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "getClientListForAdmin";
            param.data = {

            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    $scope.clientList = receivedData.records;
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
            if (tab == 1) {
                $scope.getRegistrationRequest();
            } else if (tab == 2) {
                $scope.getProposedProject();
            } else if (tab == 3) {
                $scope.getClientList();
            }
        }
        $timeout(function() {
            $scope.$apply(function() {
                $scope.selectTab(1);

            });



        });
    }
})();