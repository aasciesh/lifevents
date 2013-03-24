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

$(function() {

  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe( channel , function (data) {
  	var jsonObj = JSON.parse(data);
  	var eventsNo = $('.eventfeed').length + 1;
  
    var jHtml = feedTemplate(jsonObj, eventsNo);
    


$('#feedContainer').prepend(jHtml);
  });
});

function feedTemplate(jsonObj, eventsNo)
{
	var dataHtml = "<div class='eventfeed' data-eventid='"+jsonObj.event_id+"' data-no ='"+eventsNo+"' data-lat='"+jsonObj.latitude+"' data-lon='"+ jsonObj.longitude+
    				"'><div class='feedhead'><span class='badge badge-info'>"+ eventsNo +"</span> "+jsonObj.eventTitle +
    				"</div><div class='feedbody'><div class='feedbodyleft'><img alt='Userpic' border='0' class='' src='"+jsonObj.avatar_url+
    				"'></div><div class='feedbodyright'><div class='fbrtop'><span class='username'>"+ jsonObj.username+
    				" </span><span class='timestamp'> transmitted "+ jsonObj.postTime +" ago </span></div><div class='fbrcontent'>"+ jsonObj.details +
    				"</div></div></div><div class='feedbottom'>"+ jsonObj.comments_count +" Comments & "+ jsonObj.joiners_count +
    				" Joiners | More</div></div>";
    return dataHtml;
}

// When document is ready following methods wrapped between are performed if called.
$(document).ready( function(){

	//Search Box background text script
	
	$("#event_from_time, #event_to_time").datetimepicker();
	$( "#event_address" ).addresspicker();

	$('#q').focus(function() {
		if ($("#q").val() == "Search events, people.." ){

			$("#q").val("");
		}

	});
	$('#q').blur(function() {
		if ($("#q").val() == "" || !$.trim($("#q").val()).length ){

			$("#q").val("Search events, people..");
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

	$('form.new_event').bind('ajax:success', function(xhr, data, status) {
		
		if (data.message == "saved")
		{
			var jsonData = JSON.parse(data.event_data)
			var eventsNo = $('.eventfeed').length + 1;
			var feedHtml= feedTemplate(jsonData, eventsNo);
			$('#feedContainer > .eventfeed').each(function () {
				if($(this).data('eventid')== jsonData.event_id)
				{
					$(this).remove();
				}
			});
			$('#feedContainer').prepend(feedHtml);
			place_icons(eventsNo, 1, jsonData.latitude, jsonData.longitude)
			pan_map(jsonData.latitude, jsonData.longitude);
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			
			return false;
		}
	});
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
var blueMarkerCss= {
      'background-image' : 'url(/assets/marker.png)',
      'width': '29px',
      'height': '39px',
      'color' : 'rgb(0,40,244)',
      'background-position': '-3px -3px',
      'font-size': '14px',
	  'font-weight': 'bold',
	  'line-height': '14px',
	  'color': '#ffffff',
	  'vertical-align': 'baseline',
	  'white-space': 'nowrap',
	  'text-shadow': '0 -1px 0 rgba(0, 0, 0, 0.25)',
	  'text-align': 'center',
	  'padding': '10px 5px 0px 0px'

    };
 var yellowMarkerCss = {
 	  'background-image' : 'url(/assets/marker.png)',
      'width': '29px',
      'height': '39px',
      'color' : 'rgb(0,40,244)',
      'background-position': '-3px -3px',
      'font-size': '14px',
	  'font-weight': 'bold',
	  'line-height': '14px',
	  'color': '#ffffff',
	  'vertical-align': 'baseline',
	  'white-space': 'nowrap',
	  'text-shadow': '0 -1px 0 rgba(0, 0, 0, 0.25)',
	  'text-align': 'center',
	  'padding': '10px 5px 0px 0px'

 }
function place_icons(numberx, numbery, lat, lon)
{
	var iconclassname= "icon" + numberx + numbery ;

	var mapIcon = L.divIcon({className: iconclassname,
							iconSize: [29, 39],
							riseOnHover: true,
							});

	L.marker([lat, lon], {icon: mapIcon}).addTo(map).bindPopup("<p>Hey this is pop up.</p>");
	if(numbery==1){$('.'+iconclassname).css(blueMarkerCss);}
	else if(numbery==3){$('.'+iconclassname).css(blueMarkerCss);}
	else{$('.'+iconclassname).css(blueMarkerCss);}
	$('.'+iconclassname).append("<span class'markerid'>"+numberx+"</span>");
}

function pan_map(lat, lon)
{
	map.panTo([lat, lon]).setZoom(13);
}

function joinEvent(eventid)
{
	if( $('#joinEventLink-'+eventid).text() == 'Join')
	{
	$.ajax({
            url: "/eventjoins" ,
            type: 'post',
            data: { 'event_id': eventid
            },
            dataType: 'json',
            cache: false,
            success: function (response) {
            	if (response.message == "success")
            	{
            		$('#joinEventLink-'+eventid).removeClass('label-info').addClass('label-success').text("Joined");
            	}
            	else
            	{
            		alert("COuldn't promote");
            	}                
            }
        });
	}
	else
	{
		$.ajax({
            url: "/eventjoins/"+eventid,
            type: 'DELETE',
            data: { '_method': 'DELETE'},
            dataType: 'json',
            cache: false,
            success: function (response) {
            	if (response.mesage="success")
            	{
            		
            		$('#joinEventLink-'+eventid).removeClass('label-success').addClass('label-info').text('Join');
            	}
            	else
            	{
            		alert("COuldn't promote");
            	}                
            }
        });
	}
}
