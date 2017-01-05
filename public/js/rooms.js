var AIRBNB_ROOM_URL = 'https://www.airbnb.com/rooms/';
var cities = [];
var city_room = {};

function create_room_element(room) {
  var room_url = AIRBNB_ROOM_URL+room.id;
  return '<a class="list-group-item" target="_blank" href="'+room_url+'">'+room.name+'</a>';
}

function create_city_element(city) {
  return '<li><a>'+city+'</a></li>';
}

function show_rooms(city) {
  var rooms = city_room[city];
  var rooms_content = '';

  if(!rooms) rooms = [];
  for(var i=0; i<rooms.length; i++) {
    var room = rooms[i];
    rooms_content += create_room_element(room);
  }
  $('#room-city-btn').html(city);
  $('#room-item-list').html(rooms_content);
}

function click_city_events() {
  $('#room-city-list li').off('click');
  $('#room-city-list li').on('click', function(){
    show_rooms($(this).text());
  });
}

function show_cities(cities) {
  console.log('all cities: '+cities.toString());
  var cities_content = '';

  for(var i=0; i<cities.length; i++) {
    cities_content += create_city_element(cities[i]);
  }
  $('#room-city-list').html(cities_content).promise().done(function(){
    click_city_events();
  });
}

function classify_rooms(rooms) {
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

function find_rooms(location) {
  $.ajax({
		url: "/rooms/"+location,
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      cities = [];
      city_room = {};
      console.log('location: '+data.location);
      classify_rooms(data.rooms);
      show_cities(cities);
    },
		error: function(data){
      alert('find rooms failed');
		}
  });
}
