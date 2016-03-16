$(function(){

	$(".tool-popup-icon").each(function(i,a){
		console.log(a);
		$("body").append("<div class='tool-popup' id='tool-popup"+i+"'><p>"+$(a).attr('title')+"</p></div>");
		var toolTip = $("#tool-popup"+i);
		toolTip.css({"display": "none", "opacity": 0.8});
		
		$(a).mouseover(function(){
			var itemOffset = $(this).offset();
			$(this).removeAttr("title");
			toolTip.css({"left": itemOffset.left+20, "top": itemOffset.top+15}).fadeIn();
		}).mouseout(function(){
			toolTip.fadeOut();
		});
	});
});

