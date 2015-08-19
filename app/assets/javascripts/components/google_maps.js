var markers = [];
var map, locations, latlngbounds, lastMarker;
var infoWindows = [];
var apiKey = 'AIzaSyAWv8W8Kfb3Mfd0ovNfi1yXLzt_a1z_zf4';

function initialize() {
  if (document.getElementById("map-canvas")) {
    var mapOptions = {
        center: new google.maps.LatLng(
                          $('#map-canvas').data('latitude'),
                          $('#map-canvas').data('longitude')
                    ),
        zoom: 14,
        scrollwheel: false
    };

    map = new google.maps.Map(
                    document.getElementById("map-canvas"),
                    mapOptions
                  );

    var myLatLng = new google.maps.LatLng(
                              $('#map-canvas').data('latitude'),
                              $('#map-canvas').data('longitude')
                            );

    var infowindow = new google.maps.InfoWindow({
      content: $('#map-info-window').html()
    });

    var image = '/pin.png';

    var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      icon: image,
      title: $('#map-canvas').data('title'),
      zIndex: 0
    });

    google.maps.event.addListener(marker, 'click', function() {
      map.panTo(marker.getPosition());

      window.setTimeout(function() {
        map.setZoom(15);
        infowindow.open(map, marker);
        map.setOptions({ scrollwheel:true });
      }, 250);
    });

    google.maps.event.addListener(map, 'click', function(event){
      map.setOptions({ scrollwheel:true });
    });

    google.maps.event.addListener(infowindow, 'closeclick', function() {
      infowindow.close();
    });
  }
}

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?key=' + apiKey + '&sensor=false&callback=initialize';
  document.body.appendChild(script);
}


window.onload = loadScript;
