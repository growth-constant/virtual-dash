window.addEventListener('turbolinks:load', function () {
  function initMap() {
    var data = document.getElementsByClassName('map-container');

    console.log(data)

    if (data && data.length) {
      data.forEach( element => {
        var polyline = data.dataset.polyline;
        var lat = parseFloat(data.dataset.lat);
        var lng = parseFloat(data.dataset.lng);

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
      });
    }
  }

  initMap();
})
