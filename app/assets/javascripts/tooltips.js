$(function(){
	$(".tool-popup-icon").each(function(i,popup){
		$("body").append("<div class='tool-popup' id='tool-popup"+i+"'><p>"+$(popup).attr('title')+"</p></div>");
		var toolTip = $("#tool-popup"+i);
		toolTip.css({"display": "none", "opacity": 0.9});
		
		$(popup).mouseover(function(){
			var itemOffset = $(this).offset();
			$(this).removeAttr("title");
			toolTip.css({"left": itemOffset.left+15, "top": itemOffset.top+15}).fadeIn();
		}).mouseout(function(){
			toolTip.fadeOut();
		});
	});
});