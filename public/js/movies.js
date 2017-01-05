function find_movies() {

  if($('#title').val()) {
    window.location.href = '/movie?title='+$('#title').val();
  }
  else {
    alert('Movie Not Found');
    // $('#movie-not-found').show();
  }
}
