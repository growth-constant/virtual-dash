window.addEventListener('turbolinks:load', function () {
  function initMap() {
    var data = document.getElementsByClassName('map-container');

    if (data && data.length) {
      for (let element of data) {
        var polyline = element.dataset.polyline;
        var lat = parseFloat(element.dataset.lat);
        var lng = parseFloat(element.dataset.lng);

        var map = new google.maps.Map( element, {
          center: {
            lat: lat, lng: lng,
          },
          zoom: 17,
          mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain', 'styled_map']
        });

        var encoded_data = polyline;

        var decode = google.maps.geometry.encoding.decodePath(encoded_data);

        var line = new google.maps.Polyline({
          path: decode,
          strokeColor: '#E23510',
          strokeOpacity: 1.0,
          strokeWeight: 4,
          zIndex: 3
        });

        line.setMap(map);
      }
    }
  }

  initMap();
})
