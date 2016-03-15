function appendText(data) {
  $(".content-input")[0].reset(); // reset form
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

$(document).ready(function(){


  $(".content-input").on("ajax:success", appendText);

  $('form#image_submit').on("submit", function(e){
      e.preventDefault();
      var thing = new FormData();
      thing.append("image", $("#image_filename")[0].files[0])
      // console.log(thing)
      $.ajax({
              url: "/analyze",
              type: "post",
              processData: false,
              contentType: false,
              data: thing
      }).done(function(responseData) {
        appendText(responseData)
      })
    })

});



//     function getBase64Image(img) {

//     var canvas = document.createElement("canvas");
//     canvas.width = img.width;
//     canvas.height = img.height;

//     var ctx = canvas.getContext("2d");
//     ctx.drawImage(img, 0, 0);

//     var dataURL = canvas.toDataURL("image/png");

//     return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
// }
