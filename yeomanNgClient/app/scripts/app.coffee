'use strict'

###*
 # @ngdoc overview
 # @name yeomanNgClientApp
 # @description
 # # yeomanNgClientApp
 #
 # Main module of the application.
###
angular
  .module 'yeomanNgClientApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ui.router'
  ]
  .config ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise "/"
    
    $stateProvider
      .state 'root',
        url: "/"
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .state 'about',
        url: "/about"
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
