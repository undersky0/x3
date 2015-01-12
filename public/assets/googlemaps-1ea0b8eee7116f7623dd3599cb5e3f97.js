var directionsDisplay;
var directionsService;
var marker;
var geocoder;
var map;
var defaultCenter;
var infowindow;
var center;
var prefix;
var textfield;
var timer;
var currentDirections = null;
var initialLocation;
var helsinki;
var browserSupportFlag =  new Boolean();
var transaction_type;
var listing_category = ["all"];
var listing_tags = [];
var listing_search;
var listingCustomDropdownFieldOptions;
var locale;
var flagMarker;
var markers = [];
var markerContents = [];
var markersArr = [];   // Array for keeping track of markers on map
var showingMarker = "";
var markerCluster = null;

function address_validator(value, element, param) {
    var check = null;

    // Added to allow empty locations
    if (value == "") {
      return true;
    }

    var pref = element.id.split("_");
    var elem_prefix ="";
    if (pref[0].match("person"))
      elem_prefix = "person";
    else if (pref[0].match("community"))
      elem_prefix = "community";
    else
      elem_prefix = pref[0] + "_" + pref[1];

    var emptyfield = $('input[id$="latitude"][id^='+elem_prefix+']').attr("value") || "";

    if(emptyfield != "")
      check = true;
    else
      check = false;

    return check;
  }

function timed_input(param) {
  clearTimeout(timer);
  //invalid_locations();
  timer=setTimeout(
    function() {
      update_map(param);
    },
    1500
  );
}

function timed_input_on_route(){
  clearTimeout(timer);
  invalid_locations("listing_origin_loc_attributes");
  invalid_locations("listing_destination_loc_attributes");
  timer=setTimeout(
    function() {
      startRoute();
    }, 1500
  );
}

function googlemapMarkerInit(canvas,n_prefix,n_textfield,draggable,community_location_lat,community_location_lon,address) {

  prefix = n_prefix;
  textfield = n_textfield;
  if (draggable == undefined)
    draggable = false;

  var latitude = document.getElementById(prefix+ "_latitude");
  var longitude = document.getElementById(prefix+ "_latitude");
  var visible = true;

  var myOptions = {
    'zoom': 14,
    'streetViewControl': false,
    'mapTypeControl': false,
    'mapTypeId': google.maps.MapTypeId.ROADMAP
  };
  
  map = new google.maps.Map(document.getElementById(canvas), myOptions);
  
  var defaultmarker = new google.maps.LatLng(51.4805472, -3.1792456, true);
  geocoder = new google.maps.Geocoder();

  if (latitude.value != ""){
  	    markerPosition = new google.maps.LatLng(latitude.value,longitude.value);
  	    map.setCenter(new google.maps.LatLng(latitude.value, longitude.value));
  	    visible = true;
  } else {
    markerPosition = defaultmarker;
    map.setCenter(defaultmarker);
    visible = true;
  }
  marker = new google.maps.Marker({
    'map': map,
    'draggable': draggable,
    'animation': google.maps.Animation.DROP,
    'position': markerPosition
  });
  google.maps.event.trigger(canvas, 'resize');
  
  infowindow = new google.maps.InfoWindow();
  if (address != undefined) {
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.close();
      infowindow.setContent(address);
      infowindow.open(map,marker);
    });
    
  }
  
  function toggleBounce() {

    marker.setAnimation(google.maps.Animation.BOUNCE);
}
  
  if (draggable){
  	console.log("dragged");
    google.maps.event.addListener(map, "click",
      function(event) {
        marker.setPosition(event.latLng);
        marker.setVisible(true);
        geocoder.geocode({"latLng":event.latLng},update_source);
      }
    );

    google.maps.event.addListener(marker, "dragend",
      function() {
        geocoder.geocode({"latLng":marker.getPosition()},update_source);
      }
    );
  }

  if(!visible)
    marker.setVisible(true);
}

function update_map(field) {
  if (geocoder) {
    geocoder.geocode({'address':field.value},
      function(response,info) {
        if (info == google.maps.GeocoderStatus.OK){
          marker.setVisible(true);
          map.setCenter(response[0].geometry.location);
          marker.setPosition(response[0].geometry.location);
          update_model_location(response);
        } else {
          marker.setVisible(false);
          nil_locations();
        }
      }
    );
  } else {
    return false;
  }

}

function update_source(response,status){
  if (status == google.maps.GeocoderStatus.OK){
    update_model_location(response);
    source = document.getElementById(textfield);
    source.value = response[0].formatted_address;
  } else {
    marker.setPosition(new google.maps.LatLng(60.1894, 24.8358));
    marker.setVisible(false);
    nil_locations();
  }
}

function manually_validate(formhint) {
	
  var rray = formhint;
  var form_id = "#";
  var _element = "#";
  if (rray = "location") {
    form_id += "new_location";
    _element += "location_street_address";
  } else if (rray[0].match("community")) {
    form_id += "new_tribe_form";
    _element += "community_address";
  } else if (rray[0].match("listing")) {
    form_id += "new_listing_form";
    if (rray[1].match("origin")) {
      _element += "listing_origin";
    } else if(rray[1].match("destination")) {
      _element += "listing_destination";
    }
  }
  // $("#edit_user_6").validate().element("#user_street_address");
}

function nil_locations(_prefix) {
  if (!_prefix)
    _prefix = prefix;
  var address = document.getElementById(_prefix+ "_address");
  var latitude = document.getElementById(_prefix+ "_latitude");
  var longitude = document.getElementById(_prefix+ "_longitude");
  var google_address = document.getElementById(_prefix+ "_google_address");
  address.value = null;
  latitude.value = null;
  longitude.value = null;
  google_address.value = null;
  manually_validate(_prefix);
  
}

// Make validation fail before it has been checked that the
// address is found
function invalid_locations(_prefix) {
  if (!_prefix)
    _prefix = prefix;
  var latitude = document.getElementById(_prefix+ "_latitude");
  latitude.value = null;
}

function update_model_location(place,_prefix){
	
  if (!_prefix)
    _prefix = prefix;
    console.log(place + _prefix);
  var address = document.getElementById(_prefix+"_address");
  var latitude = document.getElementById(_prefix+ "_latitude");
  var longitude = document.getElementById(_prefix+ "_longitude");
  var google_address = document.getElementById(_prefix+ "_google_address");
  var city = document.getElementById(_prefix+ "_city");
  var postcode = document.getElementById(_prefix+ "_postcode");
  var level_1 = document.getElementById(_prefix+ "political");
  
  address.value = place[0].formatted_address;
  latitude.value = place[0].geometry.location.lat();
  longitude.value = place[0].geometry.location.lng();
  // google_address.value = place[0].address_components.length;
   console.log("0 " + place[0].address_components[0].types);
   console.log("0 " + place[0].address_components[4].long_name);
   console.log("1 " + place[0].address_components[1].types);
   console.log("2 " + place[0].address_components[2].types);
   console.log("3 " + place[0].address_components[3].types);
   // create fields for all required address components
   // add validation for each field
   google_address.value = extractFromAdress(place[0].address_components, "street_number");
   city.value = extractFromAdress(place[0].address_components, "locality");
   postcode.value = extractFromAdress(place[0].address_components, "postal_code");
   
  manually_validate(_prefix);
}
function extractFromAdress(components, type){
    for (var i=0; i<components.length; i++)
        for (var j=0; j<components[i].types.length; j++)
            if (components[i].types[j]==type) return components[i].long_name;
    return "";
}

// Rideshare
function googlemapRouteInit(canvas) {

  geocoder = new google.maps.Geocoder();
  directionsService = new google.maps.DirectionsService();
  defaultCenter = new google.maps.LatLng(60.17, 24.94);

  var myOptions = {
    'mapTypeId': google.maps.MapTypeId.ROADMAP,
    'disableDefaultUI': false,
    'streetViewControl': false,
    'mapTypeControl': false
  };

  map = new google.maps.Map(document.getElementById(canvas), myOptions);

  var markerOptions = {
    'animation': google.maps.Animation.DROP
  };

  directionsDisplay = new google.maps.DirectionsRenderer({
    'map': map,
    'hideRouteList': true,
    'preserveViewport': false,
    'draggable': false,
    'markerOptions': markerOptions
  });

  google.maps.event.addListener(directionsDisplay, 'directions_changed',
    function() {
      if (currentDirections) {
        //updateTextBoxes();
      } else {
        currentDirections = directionsDisplay.getDirections();
      }
    }
  );
}

// Use this one for "new" and "edit"
function startRoute(latitude, longitude) {
  var foo = document.getElementById("listing_origin").value;
  var bar = document.getElementById("listing_destination").value;
  directionsDisplay.setMap(map);
  document.getElementById("listing_origin_loc_attributes_address").value = foo;
  document.getElementById("listing_destination_loc_attributes_address").value = bar;

  if(foo != '' && bar != '') {
    calcRoute(foo, bar);
  } else {
    removeRoute();
    if (foo == '' && bar == '') {
      setMapCenter(latitude, longitude, true);
      map.setZoom(12);
    }
  }
}

function wrongLocationRoute(field){
  document.getElementById(field).value = "Address not found";
  document.getElementById(field+"_address").value = null;
  document.getElementById(field+"_google_address").value = null;
  document.getElementById(field+"_latitude").value = null;
  document.getElementById(field+"_longitude").value = null;
}

function wipeFieldsRoute(field) {
  document.getElementById(field+"_address").value = null;
  document.getElementById(field+"_google_address").value = null;
  document.getElementById(field+"_latitude").value = null;
  document.getElementById(field+"_longitude").value = null;
}

function removeRoute() {
  directionsDisplay.setMap(null);
}

// Use this one for "show"
function showRoute(orig, dest) {
  var start = orig;
  var end = dest;

  var request = {
    origin:start,
    destination:end,
    travelMode: google.maps.DirectionsTravelMode.DRIVING,
    unitSystem: google.maps.DirectionsUnitSystem.METRIC
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

function route_not_found(orig, dest) {
  if (orig) {
    geocoder.geocode( { 'address': orig}, function(response, status){
       if (!(status == google.maps.GeocoderStatus.OK)) {
        nil_locations("listing_origin_loc_attributes");
         removeRoute();
       } else {
        update_model_location(response, "listing_origin_loc_attributes");
      }
    });
  } else {
    nil_locations("listing_origin_loc_attributes");
  }
  if (dest) {
    geocoder.geocode( { 'address': dest}, function(responce,status){
       if (!(status == google.maps.GeocoderStatus.OK)) {
        nil_locations("listing_destination_loc_attributes");
         removeRoute();
       } else {
        update_model_location(responce, "listing_destination_loc_attributes");
        calcRoute(foo, bar);
      }
    });
  } else {
    nil_locations("listing_destination_loc_attributes");
  }
}

// Route request to the Google API
function calcRoute(orig, dest) {
  var start = orig;
  var end = dest;

  if(!orig.match(dest)){

    var request = {
      origin:start,
      destination:end,
      travelMode: google.maps.DirectionsTravelMode.DRIVING,
      unitSystem: google.maps.DirectionsUnitSystem.METRIC
    };

    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
         directionsDisplay.setDirections(response);
        updateEditTextBoxes();
      } else {
        removeRoute();
        route_not_found(orig,dest);
      }
    });
  } else {
    removeRoute();
  }
}

function updateEditTextBoxes() {
  var foo = directionsDisplay.getDirections().routes[0].legs[0].start_address;
  var bar = directionsDisplay.getDirections().routes[0].legs[0].end_address;
  document.getElementById("listing_origin_loc_attributes_google_address").value = foo;
  document.getElementById("listing_destination_loc_attributes_google_address").value = bar;
  document.getElementById("listing_origin_loc_attributes_latitude").value = directionsDisplay.getDirections().routes[0].legs[0].start_location.lat();
  document.getElementById("listing_origin_loc_attributes_longitude").value = directionsDisplay.getDirections().routes[0].legs[0].start_location.lng();
  document.getElementById("listing_destination_loc_attributes_latitude").value = directionsDisplay.getDirections().routes[0].legs[0].end_location.lat();
  document.getElementById("listing_destination_loc_attributes_longitude").value = directionsDisplay.getDirections().routes[0].legs[0].end_location.lng();
  manually_validate("listing_destination");
  manually_validate("listing_origin");
}

function initialize_communities_map() {
  infowindow = new google.maps.InfoWindow();
  helsinki = new google.maps.LatLng(60.2, 24.9);
  flagMarker = new google.maps.Marker();
  var myOptions = {
    zoom: 2,
    center: new google.maps.LatLng(20, 15),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);

  google.maps.event.addDomListener(window, 'load', addCommunityMarkers);
}

function addCommunityMarkers() {
  // Test requesting location data
  // Now the request_path needs to also have a query string with the wanted parameters

  markerContents = [];
  markers = [];

  var request_path = '/en/tribes';
  $.getJSON(request_path, {dataType: "json"}, function(data) {
    var data_arr = data.data;

    for (i in data_arr) {
      (function() {
        var entry = data_arr[i];
        markerContents[i] = entry["id"];
        if (entry["latitude"]) {
          var location;
          location = new google.maps.LatLng(entry["latitude"], entry["longitude"]);
          var marker = new google.maps.Marker({
            position: location,
            title: entry["name"],
            map: map,
            icon: '/assets/dashboard/map_icons/tribe.png'
          });
          markers.push(marker);
          markersArr.push(marker);

          var ind = i;
          google.maps.event.addListener(marker, 'click', function() {
            infowindow.close();
            //directionsDisplay.setMap(null);
            //flagMarker.setOptions({map:null});
            if (showingMarker==marker.getTitle()) {
              showingMarker = "";
            } else {
              showingMarker = marker.getTitle();
              infowindow.setContent("<div id='map_bubble'><div style='text-align: center; width: 360px; height: 70px; padding-top: 25px;'><img src='https://s3.amazonaws.com/sharetribe/assets/ajax-loader-grey.gif'></div></div>");
              infowindow.open(map,marker);
              $.get('/en/tribes/'+entry["id"], function(data) {
                $('#map_bubble').html(data);
              });
            }
          });
          google.maps.event.addListener(infowindow, 'closeclick', function() {
            showingMarker = "";
          });
        }
      })();
    }

  });
}

function initialize_listing_map(community_location_lat, community_location_lon, locale_to_use, use_community_location_as_default) {
  locale = locale_to_use;
  // infowindow = new google.maps.InfoWindow();
  infowindow = new InfoBubble({
    shadowStyle: 0,
    borderRadius: 5,
    borderWidth: 1,
    arrowPosition: 30,
    arrowStyle: 0,
    padding: 0,
    maxHeight: 150, // 150 for single, 180 for multi
    maxWidth: 200,
    hideCloseButton: true
  });
  if ($(window).width() >= 768) {
    infowindow.setMinHeight(235);
    infowindow.setMinWidth(425);
  } else {
    infowindow.setMinHeight(150);
    infowindow.setMinWidth(225);
  }
  directionsService = new google.maps.DirectionsService();
  directionsDisplay = new google.maps.DirectionsRenderer();
  directionsDisplay.setOptions( { suppressMarkers: true } );
  helsinki = new google.maps.LatLng(60.17, 24.94);
  flagMarker = new google.maps.Marker();
  var myOptions = {
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
  var prefer_param_loc = (use_community_location_as_default === 'true');
  addListingMarkers(community_location_lat, community_location_lon, prefer_param_loc);
}

function setMapCenter(communityLat, communityLng, preferCommunityLocation) {
  var hasCommunityLocation = communityLat && communityLng;
  var useCommunityLocation = hasCommunityLocation && preferCommunityLocation;

  function defaultLocation() {
    if(hasCommunityLocation) {
      map.setCenter(new google.maps.LatLng(communityLat, communityLng));
    } else {
      map.setCenter(new google.maps.LatLng(0, 0));
    }
  }

  function geoLocation(position) {
    map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
  }

  if(useCommunityLocation) {
    map.setCenter(new google.maps.LatLng(communityLat, communityLng));
  } else if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(geoLocation, defaultLocation);
  } else {
    defaultLocation();
  }
}

function addListingMarkers(community_location_lat, community_location_lon, prefer_param_loc) {
  // Test requesting location data
  // Now the request_path needs to also have a query string with the wanted parameters

  markerContents = [];
  markers = [];

  var starttime = new Date().getTime();
  var request_path = '/listings/locations_json';
  $.get(request_path, { transaction_type: transaction_type, 'category[]': listing_category, search: listing_search, custom_dropdown_field_options: listingCustomDropdownFieldOptions}, function(data) {

    var data_arr = data.data;
    for (i in data_arr) {
      (function() {
        var entry = data_arr[i];
        if (entry["latitude"]) {

          var location;
          location = new google.maps.LatLng(entry["latitude"], entry["longitude"]);

          var marker = new google.maps.Marker({
            position: location,
            title: entry["title"]
          });

          // Marker icon based on category
          var label = new Label({
                         map: map
                    });
                    label.set('zIndex', 1234);
                    label.bindTo('position', marker, 'position');
                    label.set('text', "");
                    label.set('color', "#FFF");
          marker.set("label", label);
          markers.push(marker);
          markerContents.push(entry["id"]);
          markersArr.push(marker);
          var ind = i;

          google.maps.event.addListener(map, 'mousedown', function() {
            infowindow.close();
            showingMarker = "";
          });

          google.maps.event.addListener(marker, 'click', function() {
            infowindow.close();
            directionsDisplay.setMap(null);
            flagMarker.setOptions({map:null});
            if (showingMarker==marker.getTitle()) {
              showingMarker = "";
            } else {
              showingMarker = marker.getTitle();
              infowindow.setContent("<div id='map_bubble'><img class='bubble-loader-gif' src='https://s3.amazonaws.com/sharetribe/assets/ajax-loader-grey.gif'></div>");
              infowindow.setMaxHeight(150);
              infowindow.setMinHeight(150);
              infowindow.open(map,marker);
              $.get('/' + locale + '/listing_bubble/' + entry["id"], function(data) {
                $('#map_bubble').html(data);
              });
            }
          });
        }
      })();
    }

    var latitudes = _(data_arr).pluck("latitude").filter().map(Number).value();
    var longitudes = _(data_arr).pluck("longitude").filter().map(Number).value();

    if(latitudes.length && longitudes.length) {
      map.fitBounds(new google.maps.LatLngBounds(
        new google.maps.LatLng(_.min(latitudes), _.min(longitudes)),
        new google.maps.LatLng(_.max(latitudes), _.max(longitudes))
      ));
    }

    markerCluster = new MarkerClusterer(map, markers, markerContents, infowindow, showingMarker, locale, {});
  });
}

function clearMarkers() {
    if (markersArr) {
        for (i in markersArr) {
            markersArr[i].setMap(null);
        }
    }
    directionsDisplay.setMap(null);
    flagMarker.setOptions({map:null});
    if (markerCluster) {
        markerCluster.resetViewport(true);
        markerCluster.clearMarkers();
        delete markerCluster;
        markerCluster = null;
    }
    if (markers) {
        for (n in markers) {
            markers[n].setMap(null);
        }
    }
}

function SetFiltersForMap(type, category, search, custom_dropdown_field_options) {
  if (type)                 { transaction_type = type;               } else { transaction_type = "all";}
  if (category)             { listing_category = [category];     } else { listing_category = ["all"];}
  if (search)               { listing_search = search ;           } else { listing_search = "";}
  if (custom_dropdown_field_options) { listingCustomDropdownFieldOptions = custom_dropdown_field_options;} else { listingCustomDropdownFieldOptions = [];}
  initialize_labels();
}
;