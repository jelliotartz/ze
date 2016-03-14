function SampleView(sample) {
  this.sample = sample;
};

SampleView.prototype.displayHighlightedContent = function() {
  $("#output").html(this.wrapSampleContent());
};

SampleView.prototype.wrapSampleContent = function() {

  var keywords = this.sample.keywords;
  var contentHtml = $("<div>" + this.sample.content + "</div>");

  keywords.forEach(function(keyword) {
    contentHtml.highlight(keyword.text, { element: 'span', className: keyword.gender + " keyword " + keyword.sentiment_type, data: { sentiment_score: keyword.sentiment_score } })
  })
  return contentHtml;
};

SampleView.prototype.showStatistics = function(averages) {
  $("#output").append(this.generateAverageView(averages));
}

SampleView.prototype.generateAverageView = function(averages) {
  var ul = $("<ul>"); // why does this automatically get navbar styling??
  // debugger;
  averages.forEach(function(average) {
    ul.append($("<li>").text(average[0] + ": " + average[1].toFixed(2)))
  })
  return ul;
}

SampleView.prototype.createNumberLine = function(sample) {

  var svgContainer = d3.select("#output")
                       .append("svg")
                       .attr("width", 500)
                       .attr("height", 500);

  var linearScale = d3.scale.linear()
                      .domain([-1,1])
                      .range([50,450]);

  var xAxis = d3.svg.axis()
                    .scale(linearScale);

  var genderedKeywords = this.sample.keywords.filter(function(keyword) {
    return keyword.gender !== "neutral";
  })         

  var circles = svgContainer.selectAll("circle")
    .data(genderedKeywords)
    .enter()
    .append("circle")
    .attr("cx", function(d) { return linearScale(d.sentiment_score) })
    .attr("cy", 70)
    .attr("r", 15)
    .style("fill", function(d) { return colorFromGender(d.gender) })
    .on("mouseover", function() {return tooltip.style("visibility", "visible");})
    .on("mousemove", function() {return tooltip.style("top", (d3.event.pageY-35)+"px").style("left", (d3.event.pageX+10)+"px").text(d3.event.currentTarget.__data__.text);})
    .on("mouseout", function(){return tooltip.style("visibility", "hidden");});

  var tooltip = d3.select("body")
                  .append("div")
                  .style("position", "absolute")
                  .style("z-index", "10")
                  .style("visibility", "hidden")


  var xAxisGroup = svgContainer.append("g")
                               .attr("transform", "translate(0, 100)")
                               .call(xAxis);

  svgContainer.append("text")
              .attr("x", 75 )
              .attr("y", 165 )
              .style("text-anchor", "middle")
              .text("negative sentiment");
        
  svgContainer.append("text")
              .attr("x", 425 )
              .attr("y", 165 )
              .style("text-anchor", "middle")
              .text("positive sentiment");
}

function colorFromGender(gender) {
  if (gender == "male") {
    return '#52CFF8'
  } else if (gender == "female") {
    return 'pink'
  } else if (gender == "neutral") {
    return 'transparent'
  }
}