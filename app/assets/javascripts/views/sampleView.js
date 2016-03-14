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
    contentHtml.highlight(keyword.text, { wordsOnly: true, element: 'span', className: keyword.gender + " keyword " + keyword.sentiment_type, data: { sentiment_score: keyword.sentiment_score } })
  })
  return contentHtml;
};

SampleView.prototype.showStatistics = function() {
  $("#output").append(this.generateAverageView(this.sample.calculateAverages()));
}

SampleView.prototype.generateAverageView = function(averages) {
  var ul = $("<ul>");
  for(var average in averages) {
    // debugger;
    ul.append($("<li>").text(average + ": " + averages[average].toFixed(2)))
  }
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

SampleView.prototype.bindPopups = function() {
  var that = this;
  $("#output").on("click",".keyword",function() {
    var popup = $(JST["templates/keywordPopup"]());
    var keyword_text = $(this).text();
    var x = $(this).offset().left;
    var y = $(this).offset().top - 50;
    $("body").append(popup);
    popup.css({
                "position":"absolute",
                "top": y, "left": x,
                "background-color": "white",
                "border": "1px solid black"
                })

      $("body").on("click", ".keyword-popup input", function() {
        var gender = $(this).val();
        var keyword = that.sample.keywords.find(function(keyword) {
          return keyword.text === keyword_text
        });
        keyword.gender = gender;
        that.displayHighlightedContent();
        that.showStatistics();
        that.createNumberLine();
        $(this).closest(".keyword-popup").remove();
        $("body").off("click", ".keyword-popup input")
      });
  });
}
