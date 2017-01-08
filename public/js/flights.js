function create_flight_element(flight) {
  return '<p class="list-group-item item_scrollable" style="cursor: text">'+
         flight_content(flight)+'</p>';
}

function flight_content(flight) {
  return date(flight.date)+carrier(flight.carriers[0])+
  icon('map-marker')+place(flight.origin.name)+
  icon('arrow-right')+place(flight.destination.name)+
  direct(flight.direct)+price(flight.min_price);
}

function date(date) {
  return span(icon('calendar')+date.substring(0, 10));
}

function carrier(carrier) {
  return span(icon('plane')+carrier);
}

function direct(is_direct) {
  var str = is_direct? 'Direct' : 'Transfer';
  return span(icon('transfer')+str);
}

function place(loc) {
  return span(loc);
}

function price(price) {
  return span(icon('usd')+price+' NTD');
}

function span(content) {
  return '<span style="margin:10px;">'+content+'</span>';
}

function icon(style) {
  return '<i class="glyphicon glyphicon-'+style+'"></i>';
}

function click_flight_events() {

}

function show_flights(flights) {
  var content = '';

  for(var i=0; i<flights.length; i++) {
    content += create_flight_element(flights[i]);
  }
  $('#flight-item-list').html(content).promise().done(function(){
    click_flight_events();
  });
}

function find_flights(origin, destination) {
  if(origin.text() == 'Origin' || destination.text() == 'Destination')
    return;
  $.ajax({
    url: "/flights/"+origin.text()+"/"+destination.text(),
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      console.log(data);
      show_flights(data);
    },
		error: function(data){
      alert('Flight not found...');
		}
  });
}
