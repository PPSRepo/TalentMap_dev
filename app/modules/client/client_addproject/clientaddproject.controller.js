(function() {
    'use strict';

    angular.module('app.client.clientaddproject').controller('ClientAddProjectController', ClientAddProjectController);

    function ClientAddProjectController($scope, User, $timeout, $filter, $rootScope, InvokeAPICall, $location) {

        $scope.project = {};

        $scope.submitProjectIdea = function() {

            var param = {};
            //apiName should be same as webApi php file's switch case
            param.apiName = "addClientProject";
            param.data = {
		        "client_id":User.getUserId(),
                "project_sponsor_name": $scope.project.project_sponsor_name,
                "title": $scope.project.title,
                "email": $scope.project.email,
                "telephone_direct": $scope.project.telephone_direct,
                "available_few_hours": $scope.project.available_few_hours,
                "feedback_given": $scope.project.feedback_given,
                "project_title": $scope.project.project_title,
                "project_description": $scope.project.project_description,
                "attachments_provided": $scope.project.attachments_provided,
                "problems_opportunity": "",
                "research_required": "",
                "analysis_required": $scope.project.analysis_required,
                "estimated_effort_hours": $scope.project.estimated_effort_hours,
                "report_format": $scope.project.report_format,
                "other_deliverables": $scope.project.other_deliverables,
                "skill_needed_1": $scope.project.skill_needed_1,
                "skill_needed_2": $scope.project.skill_needed_2,
                "skill_needed_3": $scope.project.skill_needed_3,
                "required_training": $scope.project.required_training,
                "training_details": $scope.project.training_details,
                "international_component": $scope.project.international_component,
                "international_component_details": $scope.project.international_component_details,
                "coop_opportunity": $scope.project.coop_opportunity,
                "coop_opportunity_details": $scope.project.coop_opportunity_details,
                "year_submitted": $scope.project.year_submitted,
                "month": $scope.project.month,
                "day": $scope.project.day
            };

            var success = function(responseData) {
                //must check status code responded by api called
                if (responseData.status == config.statusCode.taskCompleted) {
                    console.log("everything worked fine");
                    var receivedData = responseData.data;
                    if (receivedData.insert_status == 1) {
                        alert("Project added successfully");
                    } else {
                        alert("Project NOT Added. Please try again");
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
        



        }



        $timeout(function() {
            $scope.$apply(function() {
                $scope.changeTab("clientAddProject");
            });

        }, 500);

    }
})();