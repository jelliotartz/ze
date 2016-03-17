$(function(){
	$(".tool-popup").each(function(i,popup){
		$("body").append("<div class='tool-popup-modal' id='tool-popup"+i+"'><p>"+$(popup).attr('title')+"</p></div>");
		var toolTip = $("#tool-popup"+i);
		toolTip.css({"display": "none"});
		var widthOffset = $(this).width();
		var heightOffset = $(this).height();

		$(popup).mouseover(function(){
			var itemOffset = $(this).offset();
			$(this).removeAttr("title");
			toolTip.css({"left": itemOffset.left+widthOffset, "top": itemOffset.top+heightOffset}).fadeIn();
		}).mouseout(function(){
			toolTip.fadeOut();
		});
	});
});