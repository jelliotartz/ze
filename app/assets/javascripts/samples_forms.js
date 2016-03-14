$(function(){
	var textForm = $("#text_form");
	var twitterForm = $("#twitter_form");
	var toggleSwitch = $("#toggle-form");
	var toggleText = $("#toggle-text");
	var dropZoneForm = $("#drop-form");

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

		complete: function(){
			this.removeAllFiles();
		},

		addRemoveLinks: true,
		maxFiles: 1,
	};

	textForm.addClass("shown");
	twitterForm.hide();
	dropZoneForm.parent().hide();

	toggleSwitch.on("click", "a", function(e){
		e.preventDefault();
		var active = $(".shown");
		var next = $(this).attr('href');

		active.animate({height: "toggle"});
		active.removeClass("shown");
		$(next).addClass("shown").animate({height: "toggle"});
	});
});