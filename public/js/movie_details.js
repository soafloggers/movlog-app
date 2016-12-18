function show_rooms_result(data) {
  var rooms = data.rooms;
  var room_html = '';
  for(var i=0; i<rooms.length; i++) {
    var room = rooms[i];
    room_html += '<a class="list-group-item">'+room.name+'</a>'
  }
  console.log(room_html);
  $("#room-item-list").html(room_html);
}

function find_rooms(location) {
  $.ajax({
		url: "/rooms/"+location,
		type: "GET",
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
      console.log('location: '+data.location);
      show_rooms_result(data);
    },
		error: function(data){
      alert('find rooms failed');
		}
  });
}

function find_flights() {

}

function bind_room_btn() {

}

function bind_flight_btn() {

}

$(function(){
  $(".location-btn").on("click", function(){
    find_rooms($(this).text());
  });
});
