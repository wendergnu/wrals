var app = angular.module("app", []);

app.controller("LedController", function($scope) {
    var ng = $scope;

    conn = function(){
        ng.ws = new WebSocket("ws://localhost:8000/");        
    };

    ng.on = function() {
        ng.ws.send(1);
        ng.lamp.status = true;
    };

    ng.off = function() {
        ng.ws.send(0);
        ng.lamp.status = false;
    };

    ng.init = function() {
        ng.lamp = {};
        ng.lamp.status = false;
        ng.ws = {};
        conn();
    };
});