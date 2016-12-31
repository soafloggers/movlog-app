$(function(){
  $(".dropdown-menu li a").click(function(){
    var btn = $(this).closest(".dropdown, .dropup").find("span:eq(0)");
    btn.text($(this).text());
    btn.attr('sky-id', $(this).attr('sky-id'));
  });

  $(".location-btn").on("click", function(){
    find_rooms($(this).text());
    find_airports($(this).text());
  });
});
