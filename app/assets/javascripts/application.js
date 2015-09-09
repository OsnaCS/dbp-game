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

var counter = 1;

$(document).ready(function () {
 	getTimer();
});

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

function getTimer() {
	setInterval(
		function(){
			document.getElementById("notification-text").innerHTML = "" + counter;
			counter++;
		},
		1000
	);
}