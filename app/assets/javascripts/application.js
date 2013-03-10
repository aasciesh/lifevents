// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .





// When document is ready following methods wrapped between are performed if called.
$(document).ready( function(){
	//Search Box background text script
	

	$('#q').focus(function() {
		if ($("#q").val() == "Search things happening around.." ){

			$("#q").val("");
		}

	});
	$('#q').blur(function() {
		if ($("#q").val() == "" || !$.trim($("#q").val()).length ){

			$("#q").val("Search things happening around..");
		}

	});

	$.ajaxSettings.dataType = "json";
	// callbacks trigger scripts for homepage ajax new-event form

	$('form.new_event').on('ajax:beforeSend', function(xhr, settings) {
		$(".ajax-loader").attr('class', 'ajax-loader-loading');
	} );
	$('form.new_event').on('ajax:complete', function(xhr, status) {
		$(".ajax-loader-loading").attr('class', 'ajax-loader');
	} );

	// Callbacks trigger scripts for homepage ajax sign_in form
	
	$('form.signin_form').bind('ajax:beforeSend', function(xhr, settings) {
		$(".ajax-loader").attr('class', 'ajax-loader-loading');
		console.log('beforeSend');
	} );
	
	$('form.signin_form').bind('ajax:complete', function(xhr, status) {
		$(".ajax-loader-loading").attr('class', 'ajax-loader');
		console.log('complete');
	} );

	$('form.signin_form').bind('ajax:success', function(xhr, data, status) {
		console.log('success');
		if (data.message == "successful")
		{
			location.reload();
			console.log('successfull_json_read');
		}
	});
	
	//Toggling new-event form in and out of view.

	$('.homeright').mouseover(function() {
		$('#eventForm').css('left', '0px');
	});
	$('#eFpush').click(function() {
		$('#eventForm').css('left', '500px');
	});
	$('.signin_link').mouseover(function() {
		$('#eventForm').css('left', '0px');
	});
});
