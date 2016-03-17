function SamplesView(samples) {
  this.samples = samples;
}

SamplesView.prototype.drawScatter = function() {

    var width = 500;
    var height = 500;
    var margins = 0.15

    var div = $("<div>")
    var averages = this.samples.map(function(sample) { return sample.calculateAverages() });


    var linearScale = d3.scale.linear()
                               .domain([-1,1])
                               .range([margins * width, (1 - margins) * width]);

    var xAxis = d3.svg.axis()
                   .scale(linearScale)
                   .ticks(2);

    var yAxis = d3.svg.axis()
                    .scale(linearScale)
                    .ticks(2);

    var svgContainer = d3.select(div[0]).append("svg")
                                            .attr("width", width)
                                            .attr("height", height)
                                            .style("border", "1px solid black")


    var xAxisGroup = svgContainer.append("g")
                                 .call(xAxis)
                                 .attr("transform","translate(0," + 0.5 * height + ")");



    var yAxisGroup = svgContainer.append("g")
                                .call(yAxis)
                                .attr("transform","translate(" + 0.5 * width + "," + width + ") rotate(270 0 0)")
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

    svgContainer.append("text")
                .attr("x", (1 - margins + 0.02) * width )
                .attr("y", (0.5 + 0.01) * height )
                .style("stroke", "red")
                .text("female");

    svgContainer.append("text")
                .attr("x", 0.5 * width )
                .attr("y", (margins - 0.03) * height )
                .style("text-anchor", "middle")
                .style("stroke", "blue")
                .text("male");

    svgContainer.append("text")
                .attr("x", (1 - margins) * width )
                .attr("y", margins * height )
                .style("text-anchor", "middle")
                .text("uniformly positive");

    svgContainer.append("text")
                .attr("x", (margins) * width )
                .attr("y", (1 - margins) * height )
                .style("text-anchor", "middle")
                .text("uniformly negative");

    svgContainer.append("text")
                .attr("x", (1 - margins) * width )
                .attr("y", (1 - margins) * height )
                .style("text-anchor", "middle")
                .text("biased against men");

    svgContainer.append("text")
                .attr("x", (margins + 0.02) * width )
                .attr("y", margins * height )
                .style("text-anchor", "middle")
                .text("biased against women");
    return div;
}