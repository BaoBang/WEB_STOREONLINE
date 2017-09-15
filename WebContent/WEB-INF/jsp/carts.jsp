<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
  <title>Cart List | PTiT Shop</title>
</head>
<body>

<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

<!-- CONTENT -->
<div class="container content-shop">
  
  <div class="row">
    <div class="col-md-12">
      <ol class="breadcrumb breadcrumb-shop">
        <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
        <li class="breadcrumb-item active">Cart</li>
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
          <th>PRODUCT</th>
          <th>PRODUCT NAME</th>
          <th>QUANTITY</th>
          <th>UNIT PRICE</th>
          <th>SALE PRICE</th>
          <th>TOTAL PRICE</th>
          <th>REMOVE</th>
        </thead>
        <tbody class="tbody-cart">
		<c:if test="${not empty CART_LIST}">
        <c:forEach var="cart" items="${CART_LIST.carts}" >
        <tr id="${cart.product.id}">
            <td class="cart-image"><img src="${cart.product.image}" alt=""></td>
            <td class="cart-name">
              <div class="cart-name-info">
                <a href="#">${cart.product.name}</a>
                <p class="txt-km">Khuyến mãi trị giá đến <strong>500.000₫</strong></p>
              </div>
            </td>
            <td class="cart-quantity">
              <input type="number" size="4" class="input-text" title="Quantity" value="${cart.quantity}" name="quantity[113]" max="120" min="0" step="1">
            </td>
            <td class="cart-price"><fmt:formatNumber value="${cart.product.price}" type="currency"/></td>
            <td class="cart-price"><fmt:formatNumber value="${cart.product.salePrice}" type="currency"/></td>
            <td class="cart-price"><fmt:formatNumber value="${cart.quantity * cart.product.salePrice}" type="currency"/></td>
            <td class="btn-remove"><div><button class="btn btn-cart-remove" product-name="${cart.product.name}" product-id="${cart.product.id}" product-quantity="${cart.quantity}"><i class="fa fa-remove"></i></button></div></td>
          </tr>
        </c:forEach>
		</c:if>
        
        </tbody>
        <tfoot class="tfoot-cart">
          <tr>
            <td class="clearfix" colspan="7">
                <div class="float-right">
                  <button class="btn btn-update-cart">UPDATE CART</button>
                </div>
            </td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>

  <div class="row justify-content-end">
    <div class="col-md-5">
        <div class="cart-totals">
          <h2>TOTAL</h2>
          <table class="table table-bordered table-cart-totals">
            <tbody>
              <tr>
                <td class="cart-title">Total Product</td>
                <td class="cart-price">${CART_LIST.totalProduct}</td>
              </tr>
              <tr>
                <td class="cart-title-lg">TOTAL SALE PRICE</td>
                <td class="cart-price-lg"><fmt:formatNumber value="${CART_LIST.totalPrice}" type="currency"/></td>
              </tr>
            </tbody>
          </table>
          <button class="btn btn-block btn-proceed-to-checkout" data-toggle="modal" data-target="#modal-checkout">PROCEED TO CHECKOUT</button>
        </div>
    </div>
  </div>

  

</div>
<!-- END ./CONTENT -->

<!-- Modal -->
<div class="modal fade" id="modalRemoveProductFromCarts" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Message</h5>
        <button type="button" class="close btn-close-modal" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-close-modal" data-dismiss="modal">Close</button>
        <button id="btn-remove-product-from-carts" type="button" product-id="" product-quantity="" class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>
</div>
<!-- end./ Modal -->

<div class="modal fade" id="modal-checkout" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Xác nhận thanh đặt hàng</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     <form action="${pageContext.request.contextPath}/checkout" method="get">
      <div class="modal-body">
          <!-- <div class="form-group">
            <label for="recipient-name" class="form-control-label">Recipient:</label>
            <p class="form-control-static">email@example.com</p>
          </div> -->
          <div class="form-group">
            <label for="message-text" class="form-control-label">Nhập địa chỉ nhận hàng:</label>
            <textarea name="address" class="form-control" id="message-text"></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hũy</button>
        <button type="submit" class="btn btn-primary">Đặt hàng</button>
      </div>
     </form>
    </div>
  </div>
</div>


<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function(){
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
			$('.modal-body').html('<p class="text-danger">Bạn chắc chắn muốn xóa <strong>' + productName + '</strong> khỏi giỏ hàng không?</p>');
			
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
	                console.log("SUCCESS: ", result);
	                if (result == 'true'){
	                	$('#modalRemoveProductFromCarts').modal('hide');
	                	var id = '#' + productId;
	                	$(id).remove();
	                	
	                	reload_cart_list();
	                	var totalCart = $('#total-product-in-cart').text();
	                    $('#total-product-in-cart').text(Number(totalCart) - productQuantity);
	                	
	                } else {
	                	$('.modal-body').html('<p class="text-danger">Xóa sản phẩm trong giỏ hàng thất bại!</p>');
		                $('#modalRemoveProductFromCarts').modal('show');
	                }

	            },
	            error : function(e) {
	                console.log("ERROR: ", e);
	                $('.modal-body').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
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