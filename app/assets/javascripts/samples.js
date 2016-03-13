$(document).ready(function(){
  $(".button").on("click", function(e){
    e.preventDefault();
    $("#output").empty();
    $("form")[0].reset();
    $("input[type=text], textarea").val("");
  });
})
