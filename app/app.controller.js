/* Application Modules
 * 
 * @Contributors
 * Parth Shah
 *
 * @Version
 * 1.0
 *
 */
//var appScope = "";
var usr = "";
(function() {
    'use strict';
    String.prototype.isEmpty = function() {
        return this.trim() === "";
    };

    // User factory
    angular.module('app').factory('User', function() {
        var user = {
            userProfile: {
                profilePic: {}
            },
            isLoggedIn: false,
        };

        var userFactory = {};

        userFactory.loginUser = function(data) {
            user.isLoggedIn = true;
            user.userId = data.user_id;
            user.token = data.token;
        };
        userFactory.logoutUser = function() {
            user = {
                userProfile: {
                    profilePic: {}
                },
                isLoggedIn: false,
            };
        };
        userFactory.getUserId = function() {
            return user.userId;
        }
        userFactory.getUserToken = function() {
            return user.token;
        }
        userFactory.isLoggedIn = function() {
            return user.isLoggedIn;
        };
        userFactory.setUserRoleId = function(userRoleId) {
            user.roleId = userRoleId;
        };
        userFactory.getUserRoleId = function() {
            return user.roleId;
        };

        return userFactory;
    });



    /************** InvokeAPICall FACTORY START *****************/

    angular.module('app').factory('InvokeAPICall', ['$q', '$http', 'User', function($q, $http, User) {

        var InvokeAPICall = {};
        //should be sent in any InvokeAPICall function
        var params = config.defaultParam;
        var APICallUrl = config.domain + config.apiUrl;

        //mostly we will use this post only - renaming it to makeCall
        InvokeAPICall.makeCall = function(param, successCallBack, failureCallBack) {

            if (param.data != undefined) {
                params.data = param.data;
            }
            if (param.apiName != undefined) {
                params.apiName = param.apiName;
            }
            if (User.isLoggedIn()) {
                params.data.token = User.getUserToken();
                params.data.user_id = User.getUserId();
            }

            var httpConfig = { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } };
            $http.post(
                APICallUrl,
                params, httpConfig
            ).then(function success(response) {
                    console.log("Http post resquest success");
                    console.log(response);
                    //if webApi worked fine
                    if (response.data.status == config.statusCode.validApiName) {
                        //if api responded back properly and completes asked task.
                        var responseData = response.data.responseData;
                        if (responseData.status == config.statusCode.taskCompleted) {
                            //sending back data received from api to webCalling function. 
                            successCallBack(responseData);
                        } else {
                            failureCallBack(responseData);
                        }

                    } else if (response.data.status == config.statusCode.invalidApiName) {
                        console.log("Passed api name is incorrect");
                        failureCallBack(response.data);
                    }


                },
                function failure(response) {
                    console.log("Http post resquest fail");
                    console.log(response);

                });

        };

        //not used for timebeing
        InvokeAPICall.get = function(param, successCallBack, failureCallBack) {
            if (param.params == undefined) {
                param.params = defaultParam.params;
            }

            var httpConfig = {};
            httpConfig.params = param.params;
            httpConfig.headers = { 'Accept': 'application/json' };

            $http.get(
                APICallUrl,
                httpConfig
            ).then(function success(response) {
                    console.log("Http get resquest success");
                    successCallBack(response.data);
                },
                function failure(response) {
                    console.log("Http get resquest fail");
                    console.log(response);
                    failureCallBack(response);
                });

        };
        return InvokeAPICall;
    }]);
    /************** InvokeAPICall FACTORY END *****************/

    /********** Required Field Start   ***********/
    //using "mandatory" directive instead of required because required + valid is used for input label transition.
    angular.module('app').directive("mandatory", function() {
        return {
            restrict: 'A', //only want it triggered for attributes
            compile: function(element) {
                //could add a check to make sure it's an input element if need be
                element.find("~ label").append("<span class='required'>*</span>");
            }
        }
    });
    /********** Required Field End   ***********/

    angular.module('app').filter('phnNoFormat', ['$filter', function($filter) {
        return function(input, countryCode) {
            console.log(input);

            if (!angular.isString(input)) {
                input = new String(input);
            }

            if (input.length < 10) {
                input = input.fill(0, 9 - input.length);
            }

            return "+" + countryCode + " " + input.substr(0, 3) + "-" + input.substr(3, 3) + "-" + input.substr(6, 4);
        };
    }]);


    /*   CLIENT MENU DIRECTIVE  */ ////
    angular.module('app').directive("clientMenu", function() {
        return {
            templateUrl: "app/modules/client/clientSideMenu.html",
            bindToController: true,
            restrict: "E",
            transclude: true,
            controller: function($scope, User) {
                $scope.changeTab = function(tabName) {
                    $scope.clientTab = tabName;
                    if (tabName == "clientHome") {
                        $scope.goToPage("/client/clienthome");
                    } else if (tabName == "clientProfile") {
                        $scope.goToPage("/client/clientProfile");
                    } else if (tabName == "clientAddProject") {
                        $scope.goToPage("/client/clientaddproject");
                    } else if (tabName == "clientViewProject") {
                        $scope.goToPage("/client/clientviewproject");
                    } else if (tabName == "clientLogout") {
                        $scope.goToPage("/");
                        User.logoutUser();
                    }
                }
            }
        };
    });


    /*   Talent MENU DIRECTIVE  */ ////
    angular.module('app').directive("talentMenu", function() {
        return {
            templateUrl: "app/modules/talent/talentSideMenu.html",
            bindToController: true,
            restrict: "E",
            transclude: true,
            controller: function($scope, User) {
                $scope.changeTab = function(tabName) {
                    $scope.clientTab = tabName;
                    if (tabName == "talentHome") {
                        $scope.goToPage("/talent/talenthome");
                    } else if (tabName == "talentManageProfile") {
                        $scope.goToPage("/talent/talentmanageprofile");
                    } else if (tabName == "talentViewProjects") {
                        $scope.goToPage("/talent/talentviewprojects");
                    } else if (tabName == "talentManageGroup") {
                        $scope.goToPage("/talent/talentmanagegroup");
                    } else if (tabName == "talentLogout") {
                        $scope.goToPage("/");
                        User.logoutUser();
                    }
                }
            }
        };
    });

    /*   Talent MENU DIRECTIVE  */ ////
    angular.module('app').directive("adminMenu", function() {
        return {
            templateUrl: "app/modules/admin/adminSideMenu.html",
            bindToController: true,
            restrict: "E",
            controller: function($scope, User) {
                $scope.changeTab = function(tabName) {
                    $scope.clientTab = tabName;
                    if (tabName == "adminHome") {
                        $scope.goToPage("admin/home");
                    } else if (tabName == "manageClient") {
                        $scope.goToPage("admin/manageClient");
                    } else if (tabName == "manageTalent") {
                        $scope.goToPage("admin/manageTalent");
                    } else if (tabName == "manageSponser") {
                        $scope.goToPage("admin/manageSponser");
                    } else if (tabName == "adminLogout") {
                        $scope.goToPage("/");
                        User.logoutUser();
                    }
                }
            }
        };
    });



    /*****************APPLICATION VIDE CONTROLLER START ***********************/


    angular.module('app').controller('appCtrl', ['$scope', '$rootScope', 'User', '$timeout', '$filter', '$http', '$q', '$window', '$location', function($scope, $rootScope, User, $timeout, $filter, $http, $q, $window, $location) {
        //appScope = $scope;
        usr = User;
        $scope.config = config;
        $scope.pageParams = {};
        $scope.pageTitle = "Home";



        $scope.setCurrentPageTitle = function(title) {
            $scope.pageTitle = title;
        }

        /********************* start   Manage Application vide Menu and display screen  *************************/
        $scope.appDisplay = {
            "showSideMenu": false,
            "showSideMenuItem": ""
        };
        $scope.sideMenuItem = {
            "client": "client",
            "talent": "talent",
            "sponsor": "sponsor",
            "admin": "admin",
            "none": ""
        };

        $scope.enableSideMenuDisplay = function(val, showMenuItem) {
            $scope.appDisplay.showSideMenu = val;
            $scope.appDisplay.showMenuItem = showMenuItem;
        }

        /**************** END Manage Application vide Menu and display screen  ************************/


        /**************************** User Authentication Handler  ***************************************/
        $scope.$watch(User.isLoggedIn, function(value, oldValue) {
            if (!value) {
                console.log("User Is Not Logged In, Redirecting to Login Page");
                if ($location.path() !== "/" || $location.path() !== "") {
                    alert("You are not logged in - Redirecting to HOME PAGE");
                    $scope.goToPage("/");
                }
            }
            if (value) {
                console.log("User Is Logged In");
            }
        }, true);

        /*************************************** Authenticate User ********************************************/

        /********************** Page navigation handler *****************/
        $scope.pageParams = {};
        $scope.goToPage = function(page, params) {
            if (params) {
                $scope.pageParams = params;
            }
            $location.path(page);
        };



        /******************************** Talent Map Application Code End ****************************************/

    }]);

})();