$(function(){
	var textForm = $("#text_form");
	var twitterForm = $("#twitter_form");
	var toggleSwitch = $("#toggle-form");
	var toggleText = $("#toggle-text");
	var dropZoneForm = $("#drop_form");
	var urlForm = $("#url_form");
	var multipleUrlForm = $("#multiple_url_form");
	var imageForm = $("#image_form");

	Dropzone.options.dropForm = {
		success: function(e, data) {
			var sample = new Sample(data.sample);
			var keywords = data.keywords.map(function(keyword) { return new Keyword(keyword) })
			sample.addKeywords(keywords);
			// make views
			var view = new SampleView(sample);
			view.showStatistics(data.averages);
			view.displayHighlightedContent();
			view.createNumberLine();
			view.bindPopups();
		},

		complete: function(){
			this.removeAllFiles();
		},

		dictDefaultMessage: "-- Drop Files Here To Upload --",

		addRemoveLinks: true,
		maxFiles: 1,
	};

	textForm.addClass("shown");
	urlForm.hide();
	multipleUrlForm.hide();
	twitterForm.hide();
	dropZoneForm.hide();
	imageForm.hide();

	toggleSwitch.on("click", "a", function(e){
		e.preventDefault();
		var active = $(".shown");
		var next = $(this).attr('href');

		active.animate({height: "toggle"});
		active.removeClass("shown");
		$(next).addClass("shown").animate({height: "toggle"});
	});
});
