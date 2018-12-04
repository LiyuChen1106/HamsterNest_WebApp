// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery-ui
//= require popper
//= require bootstrap-sprockets
//= require_tree .
//= require underscore
//= require gmaps/google

$(function(){
   var flashDurationInSeconds = 3;
   var flashContainerId = 'flash-messages';

   function removeFlashMessages() {
     $('#' + flashContainerId + ".alert-success").remove();
     $('#' + flashContainerId + ".alert-info").remove();
   }

   setTimeout(removeFlashMessages, flashDurationInSeconds * 1000);
})

// Code goes here

$(document).ready(function() {
  var map = null;
  var myMarker;
  var myLatlng;

  function initializeGMap(lat, lng) {
    handler = Gmaps.build('Google');  
    handler.buildMap({ provider: {}, internal: {id: 'map_canvas'}}, function(){  
      markers = handler.addMarkers(items);
//      markers = handler.addMarkers([    // put home marker
//        {
//          "lat": 	43.6687178,    
//          "lng": 	43.6687178,
//          "picture": {    // setup marker icon
//            "url": 'http://bounceworld.co.za/bounceworld/wp-content/uploads/2015/10/map_marker.png',
//            "width":  32,
//            "height": 32
//          },
//          "infowindow": "<b> My Location </b> "
//        }
//      ]);
      handler.bounds.extendWith(markers); 
      handler.fitMapToBounds();
//      handler.map.centerOn(latlon);
      handler.getMap().setZoom(13);
    });  

    
    
    map = handler.getMap()
  }

  // Re-init map before show modal
  $('#myModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    initializeGMap(button.data('lat'), button.data('lng'));
    $("#location-map").css("width", "100%");
    $("#map_canvas").css("width", "100%");
  });

  // Trigger map resize event after modal shown
  $('#myModal').on('shown.bs.modal', function() {
    google.maps.event.trigger(map, "resize");
//    map.setCenter([45, 45]);
  });
});

$(function(){
  $('.card-head > span').click(function(){
      $(this).parent().parent().toggleClass('collapsed');
      $(this).parent().parent().find('.card-body').slideToggle();
  });
});