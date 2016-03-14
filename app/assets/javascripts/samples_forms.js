$(function(){
	var textForm = $("#text_form");
	var twitterForm = $("#twitter_form");
	var toggleSwitch = $("#toggle-form");
	var toggleText = $("#toggle-text");
	
	Dropzone.options.dropForm = {
		success: function(e, data) {
			var sample = new Sample(data.sample);
			var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
			sample.addKeywords(keywords);
			// make views
			var view = new SampleView(sample);
			view.displayHighlightedContent();
			view.showStatistics(data.averages);
			view.createNumberLine();
		},
		addRemoveLinks: true,
		maxFiles: 5,
	};

	twitterForm.hide();

	var toggleCount = 0;

	toggleSwitch.on("click", function(e){
		e.preventDefault();
		textForm.animate({height: "toggle"});
		twitterForm.animate({height: "toggle"});
		if(toggleCount%2===1) {
			toggleText.text("Twitter");
		}
		else {
			toggleText.text("Text");
		}
		toggleCount++;
	});
});