$(function(){
  $(".dropdown-menu li a").click(function(){
    $(this).closest(".dropdown, .dropup").find("span:first").text($(this).text());
  });

  $(".location-btn").on("click", function(){
    find_rooms($(this).text());
  });
});
