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
    'ngRoute'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
      .otherwise
        redirectTo: '/'

