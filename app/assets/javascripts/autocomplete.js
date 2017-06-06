function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    if (element) {
        var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
        google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    }
}

function onPlaceChanged() {
    var place = this.getPlace();
}

google.maps.event.addDomListener(window, 'load', function(event) {
    initializeAutocomplete('trip_destination')
});

var element = document.getElementById('trip_destination')
google.maps.event.addDomListener(element, 'keydown', function(event) {
    if (event.keyCode === 13) {
        event.preventDefault();
    }
});
