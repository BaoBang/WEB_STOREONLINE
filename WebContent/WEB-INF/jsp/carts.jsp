<%@ page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
  <title>Giỏ hàng | PTiT Shop</title>
</head>
<body>

<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

<!-- CONTENT -->
<div class="container content-shop">
  
  <div class="row">
    <div class="col-md-12">
      <ol class="breadcrumb breadcrumb-shop">
        <li class="breadcrumb-item"><a href="home"><i class="fa fa-home"></i> Trang chủ</a></li>
        <li class="breadcrumb-item active">Giỏ hàng</li>
      </ol>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="product-list-title">
        <span>Giỏ hàng</span>
      </div>
    </div>
  </div>
  
  <c:if test="${not empty result}">
  <div class="row">
    <div class="col-md-12">
      <div class="alert alert-success" role="alert">
	     <strong>Thông báo: </strong>${result}
	  </div>
    </div>
  </div>
  </c:if>
        
  <div class="row cart-page">
    <div class="col-md-12">
      <table class="table table-bordered table-cart">
        <thead class="thead-cart">
          <th>Sản phẩm</th>
          <th>Tên sản phẩm</th>
          <th>Số lượng</th>
          <th>Giá gốc</th>
          <th>Giá đã giảm</th>
          <th>Tổng giá</th>
          <th></th>
        </thead>
        <tbody class="tbody-cart">
		<c:if test="${not empty cart_list}">
        <c:forEach var="cart" items="${cart_list.carts}" >
        <tr id="${cart.product.id}">
            <td class="cart-image"><img src="${cart.product.image}" alt=""></td>
            <td class="cart-name">
              <div class="cart-name-info">
                <a href="${pageContext.request.contextPath}/product?product_id=${cart.product.id}">${cart.product.name}</a>
                <p class="txt-km">Khuyến mãi trị giá đến <strong><fmt:formatNumber value="${cart.product.price - cart.product.salePrice}" type="currency"/></strong></p>
              </div>
            </td> 
            <td class="cart-quantity">
            	${cart.quantity}
              <%-- <input type="number" size="4" class="input-text" title="Quantity" value="${cart.quantity}" name="quantity[113]" max="120" min="0" step="1"> --%>
            </td>
            <td class="cart-price"><fmt:formatNumber value="${cart.product.price}" type="currency"/></td>
            <td class="cart-price"><fmt:formatNumber value="${cart.product.salePrice}" type="currency"/></td>
            <td class="cart-price"><fmt:formatNumber value="${cart.quantity * cart.product.salePrice}" type="currency"/></td>
            <td class="btn-remove">
            	<div>
            		<button class="btn btn-cart-remove" product-name="${cart.product.name}" product-id="${cart.product.id}" product-quantity="${cart.quantity}"><i class="fa fa-remove"></i></button>
            	</div>
            </td>
          </tr>
        </c:forEach>
		</c:if>
        </tbody>
        <tfoot class="tfoot-cart">
          <tr>
            <td class="clearfix" colspan="7">
                <div class="float-right">
                <!-- <button class="btn btn-update-cart">Shopping</button> -->
                  <button ${empty cart_list.carts ? 'disabled':''} id="btn-proceed-to-checkout" class="btn btn-block btn-proceed-to-checkout" >XÁC NHẬN ĐẶT HÀNG</button>
                </div>
            </td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>

</div>
<!-- END ./CONTENT -->

<!-- Modal -->
<div class="modal fade" id="modalRemoveProductFromCarts" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Thông báo</h5>
        <button type="button" class="close btn-close-modal" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="modal-body-remove-cart" class="modal-body"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-close-modal" data-dismiss="modal">Hủy</button>
        <button id="btn-remove-product-from-carts" type="button" product-id="" product-quantity="" class="btn btn-danger">Xóa</button>
      </div>
    </div>
  </div>
</div>
<!-- end./ Modal -->
<c:if test="${not empty pageContext.request.userPrincipal}">

<div class="modal fade" id="modal-checkout" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Xác nhận đặt hàng</h5>
        <button type="button" class="close close-checkout" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     <form action="${pageContext.request.contextPath}/checkout" method="post">
      <div id="modal-body-checkout" class="modal-body">
          <h2>ĐƠN HÀNG</h2>
          <table class="table table-bordered table-cart-totals">
            <tbody>
              <tr>
                <td class="cart-title">Số lượng</td>
                <td id="c-total-product" class="cart-price">${cart_list.totalProduct}</td>
              </tr>
              <tr>
                <td class="cart-title-lg">Tổng giá trị</td>
              
                <td id="c-total-price" class="cart-price-lg"><fmt:formatNumber value="${cart_list.totalPrice}" type="currency"/></td>
              </tr>
            </tbody>
          </table>
      	  <hr>
          <div class="form-group">
            <label for="message-text" class="form-control-label">Nhập địa chỉ nhận hàng:</label>
            <textarea name="address" class="form-control" id="message-text"></textarea>
            <input type="hidden" name="id-account" value="${user.id}">
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary close-checkout" data-dismiss="modal">Hủy</button>
        <button type="submit" class="btn btn-primary">Đặt hàng</button>
      </div>
     </form>
    </div>
  </div>
</div>
</c:if>


<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function(){
	
		$('#btn-proceed-to-checkout').click(function(){
			$('#modal-checkout').modal('show');
		});
	
		$('.close-checkout').click(function(){
			$('#modal-checkout').modal('hide');
		});
	
		// close modal
		$('.btn-close-modal').click(function(){
			$('#modalRemoveProductFromCarts').modal('hide');
		});
		
		// show modal
		$('.btn-cart-remove').click(function(){
			var productName = $(this).attr('product-name');
			var productId = $(this).attr('product-id');
			var productQuantity = $(this).attr('product-quantity');
			
			$('#btn-remove-product-from-carts').attr('product-quantity', productQuantity);
			$('#btn-remove-product-from-carts').attr('product-id', productId);
			$('#modal-body-remove-cart').html('<p class="text-danger">Bạn chắc chắn muốn xóa <strong>' + productName + '</strong> khỏi giỏ hàng không?</p>');
			
			$('#modalRemoveProductFromCarts').modal('show');
		});
		
		$('#btn-remove-product-from-carts').click(function(){
			var productId = $(this).attr('product-id');
			var productQuantity = $(this).attr('product-quantity');
			
			// AJAX: /ajax/remove-product-from-cart
			$.ajax({
	            url : "${pageContext.request.contextPath}/ajax/remove-product-from-cart",
	            type : "get",
	            contentType : "application/json;charset=UTF-8",
	            dataType:"text",
	            data : {
	                 product_id:productId
	            },
	            success : function(result) {
	                //console.log("SUCCESS: ", result);
	                if (result == 'true'){
	                	$('#modalRemoveProductFromCarts').modal('hide');
	                	var id = '#' + productId;
	                	$(id).remove();
	                	
	                	reload_cart_list();
	                	get_total_product_in_cart();
	        			get_total_price_in_cart();
	                	
	                	var totalCart = $('#total-product-in-cart').text();
	                    $('#total-product-in-cart').text(Number(totalCart) - productQuantity);
	                	
	                } else {
	                	$('#modal-body-checkout').html('<p class="text-danger">Xóa sản phẩm trong giỏ hàng thất bại!</p>');
		                $('#modalRemoveProductFromCarts').modal('show');
	                }
	            },
	            error : function(e) {
	                console.log("ERROR: ", e);
	                $('#modalRemoveProductFromCarts').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
	                $('#modalRemoveProductFromCarts').modal('show');
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
	               console.log('SUCCESS Reload Cart List');
	               console.log(data);
				   $('#container-cart').empty();
				   $('#container-cart').html(data);
	           },
	           error : function(e) {
	               console.log("ERROR: ", e);
	           }
			});
		};
		
		// reload carts
		function get_total_product_in_cart(){
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/get-total-product",
	            type : "get",
	            contentType : "application/json;charset=UTF-8",
	            dataType: "text",
	            success : function(data) {
	            alert(result);
	               //console.log('SUCCESS Reload Cart Info');
	               $('#c-total-product').empty();
				   $('#c-total-product').html(result);
	           },
	           error : function(e) {
	               console.log("ERROR: ", e);
	           }
			});
		};
		
		function get_total_price_in_cart(){
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/get-total-price",
	            type : "get",
	            contentType : "application/json;charset=UTF-8",
	            dataType: "text",
	            success : function(data) {
	               console.log('SUCCESS Reload Cart Info');
	               $('#c-total-price').empty();
				   $('#c-total-price').html(data);
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