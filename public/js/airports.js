function create_airport_element(ap) {
  return '<li><a sky-id="'+sky_id(ap)+'">'+ap['name']+'</a></li>';
}

function sky_id(ap) {
  return ap['lat']+","+ap['lng']+"-Latlong"
}

function click_ap_events() {
  $('#flight-to-list li a').off('click');
  $('#flight-to-list li a').on('click', function(){
    $('#destination-airport').html($(this).text());
    $('#destination-airport').attr('sky-id', $(this).attr('sky-id'));
  });
}

function show_airports(aps) {
  console.log('all airports: '+aps.toString());
  var content = '';

  for(var i=0; i<aps.length; i++) {
    var ap = aps[i];
    content += create_airport_element(ap);
  }
  $('#flight-to-list').html(content).promise().done(function(){
    click_ap_events();
  });
}

function find_airports(location) {
  $.ajax({
    url: "/airports/"+location,
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      show_airports(data);
    },
		error: function(data){
      alert('find rooms failed');
		}
  });
}
