// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/**
 * @brief Starts a timer for a countdown
 */
function start_timer() {
  var time = document.getElementById("running").innerHTML;
  timer(time);
}

/**
 * @brief Formats the timer format
 *
 * The new format is: <dd:hh:mm:ss>
 *
 * @param secs Time in seconds
 * @return Time in: <dd:hh:mm:ss>
 */
function formatTime(secs) {
  day = Math.floor(secs / (60 * 60* 24));
  hour = Math.floor(secs / (60 * 60) % 24);
  min = Math.floor((secs / 60) % 60);
  sec = Math.floor(secs % 60);

  day = ((day < 10 ? "0" : "") + day);
  hour = ((hour < 10 ? "0" : "") + hour);
  min = ((min < 10 ? "0" : "") + min);
  sec = ((sec < 10 ? "0" : "") + sec);

  return day + ":" + hour + ":" + min + ":" + sec;
}

/**
 * @brief Recursive timer countdown call
 *
 * Sets running element to time
 *
 * @param time The remaining time
 */
function timer(time) {  
  if(time > 0) {
    document.getElementById("running").innerHTML = formatTime(time);
    window.setTimeout('timer('+ (--time) +')',1000);
  } else {
    window.location.reload();
    window.location.reload();
  }
}

var counter = 1;

$(document).ready(function () {
  getTimer();
});

function getTimer() {
	setInterval(
		function()
		{
			document.getElementById("notification-text").innerHTML = "" + counter;
			counter++;
		},
		1000
	);
}

















var width = 1000;
var heigth = 1000;
var node_width = 100;
var node_heigth = 100;
var node_border_size = 10;
var canvasElement;
var graphics;
var fontSize = 25;

function draw() {
  canvasElement = document.getElementById("canvas");
  graphics = canvasElement.getContext("2d");

  drawElementNode(108, 108);
}

function drawElementNode(x, y, text) {
  if(graphics == null) {
    return;
  } else {
    graphics.fillStyle = "darkblue";
    graphics.fillRect(x, y, node_width, node_heigth);

    graphics.fillStyle = "blue";
    graphics.fillRect(
      x + node_border_size, y + node_border_size, 
      node_width - node_border_size * 2, node_heigth - node_border_size * 2);

    graphics.fillStyle = "white";
    graphics.font = "bold " + fontSize + "px Arial";
    graphics.fillText("Hallo", x + node_border_size, y + (node_heigth / 2));
  }
}