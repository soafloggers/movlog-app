function find_flights(origin, destination) {
  $.ajax({
    url: "/flights/"+location,
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      cities = [];
      city_room = {};
      console.log('location: '+data.location);
      classify_rooms(data.rooms);
      show_cities(cities);
      show_rooms(cities[0]);
    },
		error: function(data){
      alert('find rooms failed');
		}
  });
}
