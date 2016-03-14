$(function(){
	var textForm = $("#text_form");
	var twitterForm = $("#twitter_form");
	var toggleSwitch = $("#toggle-form");
	var toggleText = $("#toggle-text");

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