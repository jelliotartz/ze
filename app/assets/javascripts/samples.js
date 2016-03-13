$(document).ready(function(){
  $(".button").on("click", function(e){
    e.preventDefault();
    $("#output").empty();
    $("form")[0].reset();
    $("input[type=text], textarea").val("");
  });

  $(".content-input").on("ajax:success",function(event, data) {
    event.preventDefault();
    var sample = new Sample(data.sample);
    var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
    sample.addKeywords(keywords);
    $("#output").append(wrapSampleContent(sample))
  })

  function wrapSampleContent(sample) {
    var keywords = sample.keywords;
    var contentHtml = $("<div>" + sample.content + "</div>");

    keywords.forEach(function(keyword) {
      contentHtml.highlight(keyword.text, { element: 'span', className: keyword.gender + " keyword " + keyword.sentiment_type, data: { sentiment_score: keyword.sentiment_score } })
    })
    return contentHtml;
  }
})
