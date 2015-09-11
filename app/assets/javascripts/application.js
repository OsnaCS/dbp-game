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
  getJsonData();
 	setInterval(getJsonData, 5000);
});

/**
 * @brief Starts a timer for a countdown
 */
function start_timer() {
  timer();
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

function timer(){
	$('.running').each(function (time) {
		var timeElement = $(this);
		var secs = parseInt(timeElement.data("time"),10);
		if(secs>0){
			secs--;
			timeElement.data('time', secs);
			timeElement.html(formatTime(secs));
		}
		else{
    		window.location.reload(); //did some magic
    		window.location.reload();
		}
	});

	window.setTimeout(timer,1000);
}

function getJsonData() {
  $.getJSON('/home/get_json_data').done(function(data) {

    if(parseInt(data.msg) != 0) {
      $("#notification-text").html(data.msg);
      $('#notification-text').css({visibility: 'visible'});
    }
    else {
      $('#notification-text').css({visibility: 'hidden'});
    }

    $("#val-metal").html(data.metal);
    $("#val-crystal").html(data.crystal);
    $("#val-fuel").html(data.fuel);
  });
}