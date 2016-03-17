$(function() {
  $("body").on("click", ".sample-link", function(event) {
    event.preventDefault();
    var url = $(this).attr("href");
    var req = $.ajax({
      url: url,
      method: "get"
    })
    req.done(function(data) {
      // debugger
      var sample = new Sample(data.sample);
      var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
      sample.addKeywords(keywords);

// unbind lingering popups
    $("body").off("click", ".keyword-popup input");
    $("#output").off("click",".keyword")


      var view = new SampleView(sample);
      var div = $("<div id=sample-show></div>")
      $("#content").html(div.append(view.render()));
      view.bindPopups2();
    })
  })
})