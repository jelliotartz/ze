$(document).ready(function(){

  $(".content-input").on("ajax:success",function(event, data) {
    this.reset(); // reset form

    // create sample and keywords
    var sample = new Sample(data.sample);
    var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
    sample.addKeywords(keywords);

    // render views
    var view = new SampleView(sample);
    view.displayHighlightedContent();
    view.showStatistics(data.averages);
    view.createNumberLine();
  })
})
