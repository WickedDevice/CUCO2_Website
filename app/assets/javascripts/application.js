// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
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
//= require dygraph-combined
//= require bootstrap
//= require_tree .

var ready = function() {
	$('[data-toggle="tooltip"]').tooltip();
	autocollapse();
}

$(document).ready(ready);
$(document).on('page:load', ready);

//Determine if we should collapse the navbar
function autocollapse() {
    var navbar = $('#navbar');

    console.log(navbar.innerHeight());

    navbar.removeClass('collapsed'); // set standard view
    if(navbar.innerHeight() > 60) // check if we've got 2 lines
        navbar.addClass('collapsed'); // force collapse mode

    if(navbar.hasClass("collapsed") || $(window).width() <= 767) {
    	$('#title-small').css("display", "inline-block");
    	$('#title-large').css("display", "none");
    } else {
    	$('#title-small').css("display", "none");
    	$('#title-large').css("display", "inline-block");
    }
   
    
}

$(window).on('resize', autocollapse);
