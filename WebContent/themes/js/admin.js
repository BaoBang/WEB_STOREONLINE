$(document).ready(function() {
	
 
  $(".sub-menu").on("click", function() {
   		$(this).find("ul").toggle("slow/400/fast");
  });
  $(".nav-link").on("click", function() {
   		$(".sidebar").toggle("slow/400/fast");
  });
});