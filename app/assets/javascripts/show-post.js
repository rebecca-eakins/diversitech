$(function(){

	$("a.new-comment-link").click(function(e) {
		e.preventDefault();
		var parentPostID = $(this).data().id;
		$("#comment-for-" + parentPostID).toggleClass("hide");
	});

});