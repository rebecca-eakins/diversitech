$(function(){

	$("a.new-comment-link").click(function(e) {
		e.preventDefault();
		var parentPostID = $(this).data().id;
		$("#new-comment-for-" + parentPostID).toggleClass("hide");
	});

});