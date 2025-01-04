<%-- 
    Document   : GOMAP
    Created on : Feb 11, 2020, 2:12:39 PM
    Author     : Rafiee.Siyavash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
          <meta name='viewport' content='initial-scale=1.0, user-scalable=no' /> 
            <meta content="" name="keywords">
            <meta content="" name="description">

        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,700|Open+Sans:300,300i,400,400i,700,700i" rel="stylesheet">
          <!-- Bootstrap CSS File -->
            <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
            <!-- Libraries CSS Files -->
            <link href="lib/animate/animate.min.css" rel="stylesheet">
            <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
            <link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">
            <link href="lib/magnific-popup/magnific-popup.css" rel="stylesheet">  
            <link href="css/style.css" rel="stylesheet">
            <script src="lib/jquery/jquery.min.js"></script>


        <script src="keydragzoom.js" type="text/javascript"></script>
         <script type='text/javascript'    src='http://maps.google.com/maps/api/js?sensor=false&language=fa&key=AIzaSyDPq1UJKxyEgE90Bq6dEAKJKXXlc86lgnM'></script>   
                                                 <script src="keydragzoom.js" type="text/javascript"></script>
                                                 <script type='text/javascript'>
                                                     
                                                     var imagered = 'http://tech2hn.com.au/Images/sc-sl-red.png';
                                                     var imageJobSelected = 'http://tech2hn.com.au/Images/JobSelected.png';

                                                     var cliked0 = true;
                                                     var cliked3 = true;
                                                     var markers = null;
                                                     var marker = null;

                                                     function SelectMarkers(Bounds) {

                                                         for (var i = 0; i < markers.length; i++) {
                                                             marker = markers[i];
                                                             if (Bounds.contains(marker.getPosition()) == true) {
                                                                 marker.setIcon(imageJobSelected)
                                                                 if (marker.get('id') == 0) { cliked0 = false };
                                                                 if (marker.get('id') == 3) { cliked3 = false };
                                                             }


                                                         }
                                                     }

                                                     var locationlat = 35.674590;
                                                     var locationlong = 51.440392;

                                                     function getLocation() {
                                                         if (navigator.geolocation) {
                                                             navigator.geolocation.getCurrentPosition(showPosition);
                                                           } 
                                                     }

                                                     function showPosition(position) {
                                                         locationlat = position.coords.latitude;
                                                         locationlong = position.coords.longitude;
                                                     }




                                                     

                                                     function initialize() {

                                                         if (txtlocation.value.length > 0)
                                                         {

                                                             var dataLat = txtlocation.value.split('-');
                                                             locationlat = dataLat[0];
                                                             locationlong = dataLat[1];

                                                         }

                                                         getLocation();
                                                         markers = [];
                                                         var latlng = new google.maps.LatLng(locationlat, locationlong);
                                                         var myOptions = { zoom: 14, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, gestureHandling:"greedy"};
                                                         var map = new google.maps.Map(document.getElementById('map_canvas'), myOptions); map.enableKeyDragZoom();
                                                         var geocoder = new google.maps.Geocoder();

                                                         map.setOptions({
                                                             zoomControl: false, disableDoubleClickZoom: true, mapTypeControl: false ,
                                                             enableCloseButton: false, clickableIcons: false, disableDefaultUI: true, rotateControl: true, scaleControl: true, fullscreenControl: true });

                                                         //google.maps.event.addListener(map, 'click', function (event) {
                                                         //    placeMarker(event.latLng);
                                                         //});

                                                         google.maps.event.addListener(map, 'drag', function () {
                                                             //myMarker.setPosition(this.getCenter()); // set marker position to map center
                                                             var latlng = new google.maps.LatLng(this.getCenter().lat(), this.getCenter().lng());
                                                             placeMarker(latlng,0);
                                                         });


                                                         google.maps.event.addListener(map, 'dragend', function () {
                                                             //myMarker.setPosition(this.getCenter()); // set marker position to map center
                                                             var latlng = new google.maps.LatLng(this.getCenter().lat(), this.getCenter().lng());
                                                             placeMarker(latlng,1);
                                                         });


                                                         var arrlocation = [];
                                                         var Circlelocation = [];
                                                         var nowlocation = null;
                                                         var marker = new google.maps.Marker({
                                                             position: latlng,
                                                             map: map
                                                         });

                                                         function placeMarker(location,showcircle) {

                                                             nowlocation = location;
                                                             marker.setPosition( location);
                                                              

                                                             

                                                            


                                                              if (showcircle == 1) {


                                                                  if (Circlelocation.length > 0) {
                                                                      var counter = 0;
                                                                      for (counter = 0; counter < Circlelocation.length; counter++) {


                                                                          Circlelocation[counter].setMap(null);
                                                                      }
                                                                  }



                                                             var txtloc = document.getElementById('txtlocation');
                                                             var txtselectrecord = document.getElementById('SelectRecordID');
                                                             txtloc.value =  marker.position.lat() +  '- ' + marker.position.lng() ;
                                                             txtselectrecord.value =  marker.position.lat() +  '- ' + marker.position.lng() ;


                                                             geocoder.geocode({ 'latLng': location }, function (results, status) {
                                                                 if (status == google.maps.GeocoderStatus.OK) {
                                                                     if (results[1]) {
                                                                         var addressdata = results[1].formatted_address;
                                                                         var txtaddress_value = document.getElementById('txtaddress');
                                                                         var SelectRecordV = document.getElementById('SelectRecordValue');
                                                                         txtaddress_value.value = addressdata;
                                                                         SelectRecordV.value = addressdata;
                                                                         
                                                                     }
                                                                 }
                                                             });


                                                             

                                                                 var distancevalue = txtdistance.value;
                                                                 var sunCircle = {
                                                                     strokeColor: "#999",
                                                                     strokeOpacity: 0.8,
                                                                     strokeWeight: 2,
                                                                     fillColor: "#555",
                                                                     fillOpacity: 0.35,
                                                                     map: map,
                                                                     center: location,
                                                                     radius: parseFloat(distancevalue)
                                                                 };

                                                                 cityCircle = new google.maps.Circle(sunCircle)
                                                                 Circlelocation.push(cityCircle);
                                                             }

                                                             //google.maps.event.addListener(marker, 'click', function () {                                                                 

                                                             //});

                                                             

                                                         }
                                                         

                                                         placeMarker(latlng,1);

                                                     }


                                                    

                                                     

                                                  
     </script> 

    
</head>
        
            
    <body onload='initialize()'>
        <input type="hidden" id="txtlocation" value="">
        <input type="hidden" id="txtdistance" value="">
        <input type="hidden" id="txtaddress_value"  value="">
        <input type="hidden" id="txt_full_address"  value="">
        <input type="hidden" id="txtaddress"  value="">
        <input type="hidden" id="SelectRecordID"  value="">
        <input type="hidden" id="SelectRecordValue"  value="">
        
                     <div id='map_canvas' style='width:100%; height:98vh'>
                                     
                     </div>                                      
                    
        
    </body>
</html>
