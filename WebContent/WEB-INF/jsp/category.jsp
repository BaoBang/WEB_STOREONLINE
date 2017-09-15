<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
  <title>${category.name} | ${category.description} | PTiT Shop</title>
</head>
<body>
<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

<!-- CONTENT -->
<div class="container content-shop">
  
  <div class="row">
    <div class="col-md-12">
      <ol class="breadcrumb breadcrumb-shop">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fa fa-home"></i> Trang chủ</a></li>
        <c:forEach var="c" items="${category_list}"><c:if test="${c.id eq category.parentId}">
        <li class="breadcrumb-item"><a href="#">${c.name}</a></li>
		</c:if></c:forEach>
        <li class="breadcrumb-item active">${category.name}</li>
      </ol>
    </div>
  </div>
  
  <div class="row">
    <div class="col-md-12">
      <div class="product-list-title">
        <span class="float-left">${category.description}</span>
        <form action="${pageContext.request.contextPath}/category/${category.slug}" method="get">
		<button type="submit" class="btn btn-primary float-right">Lọc</button>
          <div class="form-group float-right mr-1">
		    <select class="form-control" name="order_by">
		      <option value="ASC" ${(not empty param.order_by and param.order_by eq "ASC") ? 'selected':''}>Giá thấp đến cao</option>
		      <option value="DESC" ${not empty param.order_by and param.order_by eq "DESC" ? 'selected':''}>Giá cao đến thấp</option>
		      <!-- <option>Xem nhiều nhất</option> -->
		    </select>
		  </div>
		<c:if test="${not empty brand_list}">
		<div class="form-group float-right mr-1">
		   <select name="brand_id" class="form-control">
		      <option value="0" ${(param.brand_id eq "0") ? 'selected':''}>Hãng sản xuất</option>
		    <c:forEach var="b" items="${brand_list}">
		      <option value="${b.id}" ${(not empty param.brand_id and param.brand_id eq b.id) ? 'selected':''}>${b.name}</option>
		    </c:forEach>
		   </select>
		 </div>
		</c:if>
        </form>

      </div>
    </div>
  </div>
  
  
  	<c:choose>
	<c:when test="${products_is_empty}">
	<div class="row">
  	<div class="col-md-12">
    	<div class="alert alert-warning" role="alert">
		  <strong>Rất tiết!</strong> Không có sản phẩm để hiển thị.
		</div>
    </div>
    </div>
  	</c:when>
  	<c:otherwise>
  	<div class="row product-list">
     <c:forEach var="p" items="${result.list}">
        <!--Start a product item-->
         <div class="col-md-3 product-box product-heightest">
           <div class="product product-heightest">
             <div class="product-img">
               <img class="img-fluid" src="${p.image}" alt="${p.name}"/>
             </div>
             <h3 class="product-name"><a href="${pageContext.request.contextPath}/product?product_id=${p.id}">${p.name}</a></h3>
             <h4 class="product-price">Giá: <fmt:formatNumber value="${p.salePrice}" type="currency"/></h4>
             <div class="text-center txt-km">Khuyến mãi trị giá đến <strong>500.000₫</strong></div>
             <span>
               <!-- <a href="#" class="btn btn-add-to-cart">Thêm Giỏ Hàng</a> -->
               <button type="button" class="btn btn-add-to-cart" product-id="${p.id}">Thêm vào giỏ</button>
             </span>
             <p class="info">${p.overview}</p>
           </div>
        </div>
        <!--End a product item-->
     </c:forEach>

     <!-- FIX -->
    <!--  <div class="col-md-6" style="border: 1px solid #EEEEEE;"></div> -->
    </div>	    
  	</c:otherwise>
  	</c:choose>
  
  
  
<c:if test="${result.totalPage gt 1}">
  <!-- pagination -->
  <nav class="pagination-shop" aria-label="Page navigation example">
    <ul class="pagination justify-content-center mt-4">
    <c:if test="${result.currentPage gt 1}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-1?brand_id=${(not empty param.brand_id) ? param.brand_id : 0}&order_by=${(not empty param.order_by) ? param.order_by:'ASC'}">Đầu</a>
      </li>
    </c:if>
    <c:forEach var="p" begin="${1}" end="${result.currentPage}">
    <c:if test="${p lt result.currentPage}">
      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${p}?brand_id=${not empty param.brand_id ? param.brand_id : 0}&order_by=${not empty param.order_by ? param.order_by:'ASC'}">${p}</a></li>
    </c:if>
    </c:forEach>
    
      <li class="page-item active"><span class="page-link">${result.currentPage}</span></li>
	
	<c:forEach var="p" begin="${result.currentPage}" end="${result.totalPage}">
	<c:if test="${p gt result.currentPage}">
      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${p}?brand_id=${not empty param.brand_id ? param.brand_id : 0}&order_by=${not empty param.order_by ? param.order_by:'ASC'}">${p}</a></li>
	</c:if>
    </c:forEach>
	
	<c:if test="${result.currentPage lt result.totalPage}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${result.totalPage}?brand_id=${not empty param.brand_id ? param.brand_id : 0}&order_by=${not empty param.order_by ? param.order_by:'ASC'}">Cuối</a>
      </li>
	</c:if>
    </ul>
  </nav>
  <!-- end./pagination -->
</c:if>

</div>
<!-- END ./CONTENT -->

<!-- Modal -->
<div class="modal fade" id="modalAddToCart" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Message</h5>
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
<!-- Category JS -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/category.js"></script> --%>
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
            /* timeout : 100000, */
            success : function(result) {
                console.log("SUCCESS: ", result);
                
                $('.modal-body').html('<p class="text-success">Thêm thành công <strong>' + result + '</strong> vào giỏ hàng.</p>');
                $('#modalAddToCart').modal('show');
                
                reload_cart_list();
                var totalCart = $('#total-product-in-cart').text();
                $('#total-product-in-cart').text(Number(totalCart) + 1);
                
             	// 2 giay sau sẽ tắt popup
                /* setTimeout(function(){
                    $('#modalAddToCart').modal('hide');
                }, 2000); */
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