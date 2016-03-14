$(function() {
  $("#scatter-link").on("ajax:success",function(response, data) {
    // var data = JSON.parse(data);
    var samples = data.samples.map(function(sample) { return new Sample(sample) });
    var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) });
    keywords.forEach(function(keyword) {
      var sample = samples.find(function(sample) { return sample.id === keyword.sample_id });
      sample.addKeyword(keyword);
    })
    // debugger;
    // sample.addKeywords(keywords);
    var averages = samples.map(function(sample) { return sample.calculateAverages() });


    var linearScale = d3.scale.linear()
                               .domain([-1,1])
                               .range([50,350]);

    var xAxis = d3.svg.axis()
                   .scale(linearScale)
                   .ticks(2);

    var yAxis = d3.svg.axis()
                    .scale(linearScale)
                    .ticks(2);

    var svgContainer = d3.select("#scatter").append("svg")
                                            .attr("width", 400)
                                            .attr("height", 400)
                                            .style("border", "1px solid black")


    var xAxisGroup = svgContainer.append("g")
                                 .call(xAxis)
                                 .attr("transform","translate(0,200)");



    var yAxisGroup = svgContainer.append("g")
                                .call(yAxis)
                                .attr("transform","translate(200,400) rotate(270 0 0)")
                                .selectAll("text")
                                    .attr("transform", "translate(15, 20) rotate(90)")
                                    .style("text-anchor","end");

    svgContainer.selectAll(".tick")
                .filter(function(d) { return d === 0})
                .remove();

    svgContainer.selectAll("circle")
                .data(averages)
                .enter()
                .append("circle")
                .attr("cx", function(d) { return linearScale(d.female || 0) })
                .attr("cy", function(d) { return linearScale(d.male || 0) })
                .attr("r", 5 )
  })
});
