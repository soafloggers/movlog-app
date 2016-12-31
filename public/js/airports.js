function create_airport_element(ap) {
  return '<li><a>'+ap+'</a></li>';
}

// function click_ap_events() {
//   $('#flight-to-list li').off('click');
//   $('#flight-to-list li').on('click', function(){
//     find_flights($(this).text());
//   });
// }

function show_airports(aps) {
  console.log('all airports: '+aps.toString());
  var content = '';

  for(var i=0; i<aps.length; i++) {
    var ap = aps[i];
    content += create_airport_element(ap['name']);
  }
  $('#flight-to-list').html(content)
  // .promise().done(function(){
  //   click_ap_events();
  // });
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
