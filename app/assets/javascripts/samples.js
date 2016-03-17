$(document).ready(function(){

  $(".content-input").on("ajax:success", appendText);
  $(".content-input").on("ajax:error", function(event, response){
    $(".content-input")[0].reset(); // reset form
    // $("#output").off("click",".keyword")
    // $("body").off("click", ".keyword-popup input")
    $("#output").children().empty();
    $("#error").html(response.responseText)

  });
  $('form#image_submit').on("submit", function(e){
      e.preventDefault();
      var imageForm = new FormData();
      imageForm.append("image", $("#image_filename")[0].files[0])
      $.ajax({
              url: "/analyze",
              type: "post",
              processData: false,
              contentType: false,
              data: imageForm
      }).done(function(responseData) {
        $('form#image_submit')[0].reset();
        appendText(event, responseData)
      })
    })

});

function appendText(event, data) {
  // history.pushState("", "Analyze","/analyze")
  $(".content-input")[0].reset(); // reset form
  $("#output").off("click",".keyword")
  $("body").off("click", ".keyword-popup input")
  $("#error").empty();
  // create sample and keywords
  var sample = new Sample(data.sample);
  var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
  sample.addKeywords(keywords);

  // render views
  var view = new SampleView(sample);
  view.showStatistics();
  view.createNumberLine();
  view.displayHighlightedContent();
  view.bindPopups();
}
