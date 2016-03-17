$(function() {
  $("#scatter-link").on("ajax:success",function(response, data) {
    // var data = JSON.parse(data);
    var samples = data.samples.map(function(sample) { return new Sample(sample) });
    var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) });
    keywords.forEach(function(keyword) {
      var sample = samples.find(function(sample) { return sample.id === keyword.sample_id });
      sample.addKeyword(keyword);
    })

    // sample.addKeywords(keywords);

    $("#scatter").append(drawScatter(samples));
  })


});
