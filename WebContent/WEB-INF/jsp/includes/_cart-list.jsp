<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="shopping-cart">
        
    <!--START SHOPPING CART HEADER-->
    <div class="shopping-cart-header">
      <i class="fa fa-shopping-cart cart-icon"></i>
      <span id="total-product-in-cart" class="badge cart-header-badge">${(not empty cart_list) ? cart_list.totalProduct : 0}</span>
      <div class="shopping-cart-total">
        <span class="lighter-text">Tổng cộng: </span>
        <span id="total-price-in-cart" class="main-color-text"><fmt:formatNumber value="${(not empty cart_list) ? cart_list.totalPrice : 0}" type="currency"/></span>
      </div>
    </div>
    <!--END SHOPPING CART HEADER-->
    
	  <c:if test="${not empty cart_list}">
	    <ul id="cart_list" class="shopping-cart-items">
	    <c:forEach var="cart" items="${cart_list.carts}">
	      <li class="clearfix">
	        <a href="#">
	          <img src="${cart.product.image}" alt="">
	          <span class="item-name">${cart.product.name}</span>
	          <span class="item-price"><fmt:formatNumber value="${cart.product.salePrice}" type="currency"/></span>
	          <span class="item-quantity">Quantity: ${cart.quantity}</span>
	        </a>
	      </li>
	    </c:forEach>
	    </ul>
	 </c:if>
    <div class="detail-cart"><a href="${pageContext.request.contextPath}/carts" class="btn btn-detail-cart">Chi tiết</a></div>
  </div>
  
  
  