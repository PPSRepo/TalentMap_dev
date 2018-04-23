(function() {
    "use strict";

    angular.module("app").config(function($routeProvider, $locationProvider) {

        $routeProvider.when('/', {
            controller: 'HomeController',
            templateUrl: 'app/modules/home/home.html'
        }).when('/admin/login', {
            controller: 'adminLoginController',
            templateUrl: 'app/modules/Admin/login/adminLogin.html'
        }).when('/talent/login', {
            controller: 'TalentLoginController',
            templateUrl: 'app/modules/Talent/Talent_Login/talentlogin.html'
        }).when('/admin/home', {
            controller: 'adminHomeController',
            templateUrl: 'app/modules/Admin/home/home.html'
        }).when('/admin/manageClient', {
            controller: 'manageClientController',
            templateUrl: 'app/modules/Admin/manageClient/manageClient.html'
        }).when('/admin/manageTalent', {
            controller: 'manageTalentController',
            templateUrl: 'app/modules/Admin/manageTalent/manageTalent.html'
        }).when('/admin/manageSponser', {
            controller: 'manageSponserController',
            templateUrl: 'app/modules/Admin/manageSponser/manageSponser.html'
        }).when('/client/login', {
            controller: 'ClientLoginCtrl',
            templateUrl: 'app/modules/client/login/login.html'
        }).when('/client/clienthome', {
            controller: 'ClientHomeController',
            templateUrl: 'app/modules/client/client_dashboard/clienthome.html'
        }).when('/client/clientProfile', {
            controller: 'ClientAddProfileController',
            templateUrl: 'app/modules/client/client_addprofile/clientaddprofile.html'
        }).when('/client/clientaddproject', {
            controller: 'ClientAddProjectController',
            templateUrl: 'app/modules/client/client_addproject/clientaddproject.html'
        }).when('/client/clientviewproject', {
            controller: 'ClientViewProjectController',
            templateUrl: 'app/modules/client/client_viewproject/clientviewproject.html'
        }).when('/client/logout', {
            redirectTo: '/'
        }).when('/talent/talentmanageprofile', {
            controller: 'TalentManageProfileController',
            templateUrl: 'app/modules/Talent/talent_manageprofile/talentmanageprofile.html'
        }).when('/talent/talentviewprojects', {
            controller: 'TalentViewProjectsController',
            templateUrl: 'app/modules/Talent/talent_viewprojects/talentviewprojects.html'
        }).when('/talent/talentmanagegroup', {
            controller: 'TalentManageGroupController',
            templateUrl: 'app/modules/Talent/talent_managegroup/talentmanagegroup.html'
        }).when('/talent/talenthome', {
            controller: 'TalentHomeController',
            templateUrl: 'app/modules/Talent/Talent_Dashboard/talenthome.html'
        }).when('/talent/logout', {
            redirectTo: '/'
        }).otherwise({
            redirectTo: '/'
        });

        //$locationProvider.html5Mode(true);
    });

})();