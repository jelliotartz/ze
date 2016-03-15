function appendText(event, data) {
  debugger
  this.reset(); // reset form
  $("#output").off("click",".keyword")
  $("body").off("click", ".keyword-popup input")
  // create sample and keywords
  var sample = new Sample(data.sample);
  var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
  sample.addKeywords(keywords);

  // render views
  var view = new SampleView(sample);
  view.displayHighlightedContent();
  view.showStatistics();
  view.createNumberLine();
  view.bindPopups();
}

    function getBase64Image(img) {

    var canvas = document.createElement("canvas");
    canvas.width = img.width;
    canvas.height = img.height;

    var ctx = canvas.getContext("2d");
    ctx.drawImage(img, 0, 0);

    var dataURL = canvas.toDataURL("image/png");

    return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
}

$(document).ready(function(){

  $(".button").on("click", function(e){
    e.preventDefault();
    $("#output").empty();
    $("form")[0].reset();
    $("input[type=text], textarea").val("");
  });

  $(".content-input").on("ajax:success", appendText);
  $("#submit_image").on("click", function(e){


    console.log(e)
  });
});

