$(function() {
	$("#listings").on("click", ".pagination a", function() {
		$.getScript(this.href);
		return false;
	});
	$("#search_form input").keyup(function() {
		$.get($("#search_form").attr("action"), $("#search_form").serialize(), null, "script");
		return false;
	});
});
