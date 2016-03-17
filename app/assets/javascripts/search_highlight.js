$(function(){
	var keys = [];
	// var samples = [];

	// $(".sample-content").each(function(i, keyword){
	// 	samples.push(keyword.innerText);
	// });

	$(".key").each(function(i, keyword){
		keys.push(keyword.innerText);
	});


	var i = 0;
	$(".sample-content").each(function(sample) {

  	var contentHtml = $("<div>" + sample.innerText + "</div>");

    var higlightedContent = contentHtml.highlight(keys[i].text, { wordsOnly: true, element: 'span', className: keys[i].gender + " keyword " + keys[i].sentiment_type, data: { sentiment_score: keys[i].sentiment_score } });

    	sample.innerHTML = higlightedContent;
    	i++;
  	});

	console.log(keys);
	console.log(samples);
});