function classify_flights(rooms) {
  for(var i=0; i<rooms.length; i++) {
    var room = rooms[i];
    if(city_room[room.city]) {
      city_room[room.city].push(room);
    } else {
      cities.push(room.city);
      city_room[room.city] = [room];
    }
  }
}

function find_flights(origin, destination) {
  $.ajax({
    url: "/flights/"+origin+"/"+destination,
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      airports = [];
      city_room = {};
      classify_flights(data);
      show_airports(cities);
    },
		error: function(data){
      alert('find rooms failed');
		}
  });
}
