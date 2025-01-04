// See post: http://asmaloney.com/2014/01/code/creating-an-interactive-map-with-leaflet-and-openstreetmap/

var map = L.map( 'map', {
  center: [32.4279, 53.6880],
  minZoom: 5,
  zoom: 6
})

L.tileLayer( 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
  subdomains: ['a', 'b', 'c']
}).addTo( map )

var myURL = jQuery( 'script[src$="leaf-demo.js"]' ).attr( 'src' ).replace( 'leaf-demo.js', '' )

var NORMALICON = L.icon({
  iconUrl: myURL + 'images/Normal.ico',
  iconRetinaUrl: myURL + 'images/Normal.ico',
  iconSize: [29, 24],
  iconAnchor: [9, 21],
  popupAnchor: [0, -14]
})


var DISCONNECTICON = L.icon({
  iconUrl: myURL + 'images/Disconnect.ico',
  iconRetinaUrl: myURL + 'images/Disconnect.ico',
  iconSize: [29, 24],
  iconAnchor: [9, 21],
  popupAnchor: [0, -14]
})


var OUTOFSERVICEICON = L.icon({
  iconUrl: myURL + 'images/Broken.ico',
  iconRetinaUrl: myURL + 'images/Broken.ico',
  iconSize: [29, 24],
  iconAnchor: [9, 21],
  popupAnchor: [0, -14]
})

var WARNINGICON = L.icon({
  iconUrl: myURL + 'images/warning.ico',
  iconRetinaUrl: myURL + 'images/warning.png',
  iconSize: [29, 24],
  iconAnchor: [9, 21],
  popupAnchor: [0, -14]
})


var NOTACTIVE = L.icon({
  iconUrl: myURL + 'images/NOTACTIVE.png',
  iconRetinaUrl: myURL + 'images/NOTACTIVE.png',
  iconSize: [29, 24],
  iconAnchor: [9, 21],
  popupAnchor: [0, -14]
})

// Atm Status 
// 0 = NotActive
// 1 = NORMAL 
// 2 = WARNING
// 3 = OUTOFSERVICE
// 4 = DisConenct 


for ( var i=0; i < markers.length; ++i )
{
	
	if (markers[i].status == 0)
    {
            L.marker( [markers[i].lat, markers[i].lng], {icon: NOTACTIVE} )
           .bindPopup( '<a href="' + markers[i].url + '" >' + markers[i].name + '</a>' )
           .addTo( map );
    }
    
	
    if (markers[i].status == 1)
    {
            L.marker( [markers[i].lat, markers[i].lng], {icon: NORMALICON} )
           .bindPopup( '<a href="' + markers[i].url + '" >' + markers[i].name + '</a>' )
           .addTo( map );
    }
    
     if (markers[i].status == 2)
    {
            L.marker( [markers[i].lat, markers[i].lng], {icon: WARNINGICON} )
           .bindPopup( '<a href="' + markers[i].url + '">' + markers[i].name + '</a>' )
           .addTo( map );
    }
    
     if (markers[i].status == 3)
    {
            L.marker( [markers[i].lat, markers[i].lng], {icon: OUTOFSERVICEICON} )
           .bindPopup( '<a href="' + markers[i].url + '" >' + markers[i].name + '</a>' )
           .addTo( map );
    }
	if (markers[i].status == 4)
    {
            L.marker( [markers[i].lat, markers[i].lng], {icon: DISCONNECTICON} )
           .bindPopup( '<a href="' + markers[i].url + '" >' + markers[i].name + '</a>' )
           .addTo( map );
    }
	
}
