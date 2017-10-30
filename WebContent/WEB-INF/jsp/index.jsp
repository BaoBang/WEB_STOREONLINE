<%@ page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
<title>PTiT Shop</title>
</head>
<body>

	<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

	<!-- CONTENT -->
	<div class="container content-shop">
		<div class="row home-banner">
			<div class="col-md-8">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active">
							<img class="d-block img-fluid" src="/PTiTShop/themes/images/banner-1.png"
								alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="/PTiTShop/themes/images/banner-2.jpg"
								alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="/PTiTShop/themes/images/banner-3.png"
								alt="Third slide">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>


			<div class="col-md-4 pl-0">
				<aside class="home-news"> <figure>
				<h2>
					<a href="${pageContext.request.contextPath }/posts/">Tin công nghệ</a>
				</h2>
				<b></b> </figure>
				<ul>
					<c:forEach items="${posts }" var="post">
						<li>
							<a href="${pageContext.request.contextPath }/post/${post.id}/${post.slug}">
								<img src="${post.image }" alt="${post.title }">
								<h3 >${post.title }</h3>
								<span>Ngày đăng: <fmt:formatDate value="${post.publishDate }" pattern="dd/MM/YYYY"/></span>
							</a>
						</li>
					</c:forEach>
				</ul>
				</aside>
			</div>
		</div>


		<div class="row">
			<div class="col-md-12">
			
			
			<c:forEach var="item" items="${result}">
				<hr>
				<div class="product-box">
					<h3 class="product-box-title">
						<span>${item.category.name} mới nhất</span>
					</h3>
					<div class="slider">
						<div class="owl-carousel product-slider">
							<c:forEach items="${item.list}" var="p">
								<!--Start a product item-->
								<div class="product">
									<div class="product-img">
										<img class="" src="${p.image }" />
									</div>
									<h3 class="product-name">
										<a href="${pageContext.request.contextPath}/product?product_id=${p.id}">${p.name }</a>
									</h3>

									<h4 class="product-price">
										Giá:
										<fmt:formatNumber value="${p.price}" type="currency"></fmt:formatNumber>
									</h4>
									<div class="text-center txt-km">
										Tiết kiệm đến <strong><fmt:formatNumber value="${p.price - p.salePrice }" type="currency"></fmt:formatNumber></strong>
									</div>
									<span> <button type="button" class="btn btn-add-to-cart"  product-id="${p.id}">Thêm
											Giỏ Hàng</button>
									</span>
									<p class="info">${p.overview }</p>
								</div>
								<!--End a product item-->
							</c:forEach>
							
						</div>
					</div>
				</div>
			</c:forEach>

				<!--Brand-->
				<hr>
				<div class="brand-box">
					<div class="slider">
						<div class="owl-carousel owl-carousel-brand" id="brand-slider">
							<c:forEach items="${brand_list }" var="brand">
								<!--Start a brand item-->
								<div class="brand">
									<div class="brand-img">
										<img class="img-fluid" src="${brand.image }"
											alt="${brand.name }" />
									</div>
								</div>
								<!--End a brand item-->
							</c:forEach>
						</div>
					</div>
				</div>
				<hr>

			</div>
		</div>

	</div>
	<!-- END ./CONTENT -->
<!-- Modal -->
<div class="modal fade" id="modalAddToCart" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Thông báo</h5>
        <button type="button" class="close btn-close-modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-close-modal">Ok</button>
      </div>
    </div>
  </div>
</div>
<!-- end./ Modal -->

<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function(){
	
	
	// Close Modal
	$('.btn-close-modal').click(function(){
		$('#modalAddToCart').modal('hide');
	});
	
	//onclick Add-To-Cart
	$('.btn-add-to-cart').click(function(){
		var productId = $(this).attr('product-id');
		
		// AJAX: /ajax/add-to-cart
		$.ajax({
            url : "${pageContext.request.contextPath}/ajax/add-to-cart",
            type : "get",
            contentType : "application/json;charset=UTF-8",
            dataType:"text",
            data : {
                 product_id:productId,
                 quantity:1
            },
            timeout : 100000, 
            success : function(result) {
                console.log("SUCCESS: ", result);
                if (result == "false") {
                	$('.modal-body').html('<p class="text-warning">Sản phẩm tạm hết hàng!</p>');
	                $('#modalAddToCart').modal('show');
                } else {
	                $('.modal-body').html('<p class="text-success">Thêm thành công <strong>' + result + '</strong> vào giỏ hàng.</p>');
	                $('#modalAddToCart').modal('show');
	                reload_cart_list();
	                var totalCart = $('#total-product-in-cart').text();
	                $('#total-product-in-cart').text(Number(totalCart) + 1);
                }
            },
            error : function(e) {
                console.log("ERROR: ", e);
                $('.modal-body').html('<p class="text-danger">Thêm vào giỏ hàng thất bại!</p>');
                $('#modalAddToCart').modal('show');
            }
        });
	});
	
	// reload carts
	function reload_cart_list(){
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/cart-list",
            type : "get",
            contentType : "application/json;charset=UTF-8",
            dataType: "text",
            success : function(data) {
               console.log("SUCCESS: ", data);
			   $('#container-cart').empty();
			   $('#container-cart').html(data);
		
           },
           error : function(e) {
               console.log("ERROR: ", e);

           }
		});
	};

});
</script>
</body>
</html>