window.addEventListener('turbolinks:load', function () {
  function initMap() {
    // Get all the maps displayed on the page
    var data = document.getElementsByClassName('map-container');

    // Check for nulls
    if (data && data.length) {
      for (let element of data) {
        var bounds = new google.maps.LatLngBounds(); // Object that will always center/zoom out the map
        var polyline = google.maps.geometry.encoding.decodePath(element.dataset.polyline); // Decoded polyline
        // Create unpainted map
        var map = new google.maps.Map( element, {
          mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain', 'styled_map']
        });
        var line = new google.maps.Polyline({
          path: polyline,
          strokeColor: '#E23510',
          strokeOpacity: 1.0,
          strokeWeight: 4,
          zIndex: 3
        });

        // Make the bounds object expand its limits to all of the polyline
        for (let latlng of polyline) {
          bounds.extend(latlng);
        }

        map.fitBounds(bounds, 0); // Make the map fit the polyline
        line.setMap(map); // Paint the line over the map
      }
    }
  }

  initMap();
})
