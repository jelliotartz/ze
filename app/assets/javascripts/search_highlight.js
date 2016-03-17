$(function(){
	$(".sample-content").each(function(i,sample) {
		var keywords = [];
		var scores = [];
		var genders = [];
		var types = [];

		var contentHtml = $("<div>" + $(sample).text() + "</div>");

		$(sample).siblings(".keyword-table").find("td:nth-child(1)").each(function(i, keyword){
			keywords.push($(keyword).text());
		});

		$(sample).siblings(".keyword-table").find("td:nth-child(2)").each(function(i, score){
			scores.push($(score).text());
		});
		
		$(sample).siblings(".keyword-table").find("td:nth-child(3)").each(function(i, gender){
			genders.push($(gender).text());
		});

		$(sample).siblings(".keyword-table").find("td:nth-child(4)").each(function(i, type){
			types.push($(type).text());
		});

		for(var i=0; i < keywords.length; i++) {
			contentHtml.highlight(keywords[i], { wordsOnly: true, element: 'span', className: genders[i] + " keyword " + types[i], data: { sentiment_score: parseInt(scores[i]) } });
			
		}

    	$(sample).html(contentHtml)
   //  	i++;
	});

});