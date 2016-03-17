$(function() {
  $("#multiple_url_form").on("ajax:success", function(response, data) {
    var form = $("#multiple_url_form").find("form")
    form[0].reset();
    $("#multiple-url-messages").html(data.message);
  })
})
