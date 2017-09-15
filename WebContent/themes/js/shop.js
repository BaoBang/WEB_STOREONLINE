$(document)
		.ready(
				function() {

					/** ************slider************ */
					$('.product-slider').owlCarousel(
							{
								nav : true,
								loop : true,
								items : 4,
								autoHeight : true,
								navText : [
										"<i class='fa fa-chevron-left'></i>",
										"<i class='fa fa-chevron-right'></i>" ]
							});
					$('#brand-slider').owlCarousel(
							{
								nav : true,
								loop : true,
								items : 5,
								navText : [ "<i class='fa fa-angle-left'></i>",
										"<i class='fa fa-angle-right'></i>" ],
								autoplay : true,
								autoplayTimeout : 2000,
								autostopHoverPause : true,
							});

					$(
							'.content-shop .row .col-md-12 .product-box .slider .product-slider .owl-height .owl-stage .owl-item')
							.addClass('product-height');
					$(
							'.content-shop .row .col-md-12 .product-box .slider .product-slider .owl-height')
							.addClass('product-heightest');
					/** ************end ./slider************ */

					/** ************GO TO TOP************ */
					if ($(".btn-top").length > 0) {
						$(window).scroll(function() {
							var e = $(window).scrollTop();
							if (e > 300) {
								$(".btn-top").show()
							} else {
								$(".btn-top").hide()
							}
						});
						$(".btn-top").click(function() {
							$('body,html').animate({
								scrollTop : 0
							})
						})
					}
					/** ************ end./ GO TO TOP************ */

					/** ************thumbnail************ */
					$('.thumbnail').on(
							'click',
							function() {
								var clicked = $(this);
								var newSelection = clicked.data('big');
								var $img = $('.primary-image').attr("src",
										newSelection);
								clicked.parent().find('.thumbnail')
										.removeClass('selected');
								clicked.addClass('selected');
								$('.primary-image').empty().append(
										$img.hide().fadeIn('slow'));
							});
					/** ************end./ thumbnail************ */

					/** ************* Check register user name ************************ */

				

					/**
					 * ************* End Check register user name
					 * ************************
					 */
					
					

				});
/** *************SET HEIGHT FOR CARD PRODUCT*********************** */
function sortNumber(a, b) {
	return a - b;
}

var highest = 0;

function maxHeight() {
	var heights = new Array();
	$('.product-height').css('height', 'auto');
	$('.product-height').each(function() {
		heights.push($(this).height());
	});
	heights = heights.sort(sortNumber).reverse();
	highest = heights[0];
	$('.product-height, .product-heightest').css('height', highest);
	$('.product').css('height', highest - 20);
}

$(document).ready(maxHeight);
$(window).resize(maxHeight);

/** *****************SHOPPING CART********************* */
(function() {

	$("#navbarDropdownCart").on("click", function() {
		$(".shopping-cart").fadeToggle("slow/400/fast");
	});

})();
/** ***********NAV TAB********************** */
$('#digital a').click(function(e) {
	e.preventDefault();
	$(this).tab('show');
})