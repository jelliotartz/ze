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
    createVisualization(sample);
  })

  function wrapSampleContent(sample) {
    var keywords = sample.keywords;
    var contentHtml = $("<div>" + sample.content + "</div>");

    keywords.forEach(function(keyword) {
      contentHtml.highlight(keyword.text, { element: 'span', className: keyword.gender + " keyword " + keyword.sentiment_type, data: { sentiment_score: keyword.sentiment_score } })
    })
    return contentHtml;
  }

  function createVisualization(sample) {
    // debugger

    var svgContainer = d3.select("#output").append("svg").attr("width", 500).attr("height", 500);

    var linearScale = d3.scale.linear()
                        .domain([-1,1])
                        .range([50,450]);

    var xAxis = d3.svg.axis()
                      .scale(linearScale);



    var circles = svgContainer.selectAll("circle")
      .data(sample.keywords)
      .enter()
      .append("circle")
      .attr("cx", function(d) { return linearScale(d.sentiment_score) })
      .attr("cy", 70)
      .attr("r", 15)
      .style("fill", function(d) { return colorFromGender(d.gender) })

      .on("mouseover", function() {return tooltip.style("visibility", "visible");})
      .on("mousemove", function() {return tooltip.style("top", (d3.event.pageY-10)+"px").style("left", (d3.event.pageX+10)+"px").text(d3.event.currentTarget.__data__.text);})
      .on("mouseout", function(){return tooltip.style("visibility", "hidden");});



    // var text = svgContainer.selectAll("text")
    //   .data(sample.keywords)
    //   .enter()
    //   .append("text");

    var tooltip = d3.select("body")
      .append("div")
      .style("position", "absolute")
      .style("z-index", "10")
      .style("visibility", "hidden")

    //Add SVG Text Element Attributes
    // var textLabels = text
    //   .attr("x", function(d) { return linearScale(d.sentiment_score) })
    //   .attr("y", 45)
    //   .text(function(d) { return d.text })
    //   .attr("font-family", "sans-serif")
    //   .attr("font-size", "20px")
    //   .attr("fill", "black")
    //   .style("text-anchor", "middle")




        // d3.select(this)
        // .enter()
        // .append("text")
        // .text(function(d) { return d.text })
        // .attr("x", function(d) {return x(d.x);})
        // .attr("y", function(d) {return y(d.y);})
      // });

      // .on("mouseover", function(d) {
      //   d3.select()
      // })

    var xAxisGroup = svgContainer.append("g")
      .attr("transform", "translate(0, 100)")
      .call(xAxis);
  }

  function colorFromGender(gender) {
    if (gender == "male") {
      return '#52CFF8'
    } else if (gender == "female") {
      return 'pink'
    } else {
      return 'transparent'
    }
  }
})
