myFileUpload = ($parse) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "change", ->
      scope.$apply ->
        $parse(attrs.myFileUpload).assign scope, element[0].files[0]

myFileUpload.$inject = ["$parse"]
angular.module('app')
       .directive "myFileUpload", myFileUpload
