<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- HEADER -->
<nav class="navbar fixed-top navbar-toggleable-md navbar-shop">
	<div class="container">
		<button class="navbar-toggler" style="background-color: #333;"
			type="button" data-toggle="collapse" data-target="#navbarShop"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<i class="fa fa-navbar"></i>
		</button>
		<a class="logo" href="${pageContext.request.contextPath}/"><img
			src="${pageContext.request.contextPath}/themes/images/logo.png"
			alt="#"></a>

		<div class="collapse navbar-collapse" id="navbarShop">

			<form class="form-inline form-search" action="${pageContext.request.contextPath }/search" method="get">
				<input class="form-control input-search" type="search" autocomplete="off" placeholder="Tìm kiếm sản phẩm..." id="input-search" name="q">
				<button class="btn btn-search" type="submit">
					<i class="fa fa-search"></i>
				</button>
				<div id="search-result" class="search-result">
					<div class="search-result-main" id="search-result-main">
						
					</div>
				</div>

			</form>

			<ul class="navbar-nav">

				<c:forEach items="${category_list }" var="category">
					<c:if test="${category.parentId eq 0 }">
						<c:set var="check" value="false"></c:set>
						<c:forEach var="c" items="${category_list}">
							<c:if test="${c.parentId eq category.id}">
								<c:set var="check" value="true"></c:set>
							</c:if>
						</c:forEach>
						<li class="nav-item-cat ${check ? ' dropdown':''}"><a
							class="nav-link ${check ? ' dropdown-toggle':''}"
							data-toggle="${check ? 'dropdown':''}"
							href="${pageContext.request.contextPath}/category/${category.slug}"><i class="fa fa-lg ${category.image}"></i>
								${category.name}</a> <c:if test="${check}">
								<div class="dropdown-menu dropdown-cat"
									aria-labelledby="navbarDropdownMenuLink">
									<c:forEach var="c" items="${category_list}">
										<c:if test="${c.parentId eq category.id}">
											<a class="dropdown-item dropdown-item-cat"
												href="${pageContext.request.contextPath}/category/${c.slug}">
												${c.name}</a>
										</c:if>
									</c:forEach>
								</div>
							</c:if></li>
					</c:if>
				</c:forEach>

				<li class="nav-item-cat"><a class="nav-link"
					href="${pageContext.request.contextPath }/posts"><i
						class="fa fa-newspaper-o fa-lg"></i> Tin tức</a></li>

				<li class="nav-item-cat dropdown dropdown-cart"><a
					class="nav-link" href="#" id="navbarDropdownCart"
					data-toggle="dropdown">
						<div class="product-cart">
							<i class="fa fa-shopping-cart"></i><span
								id="total-product-in-cart" class="badge">${not empty CART_LIST ? CART_LIST.totalProduct : 0}</span>
						</div>
				</a></li>

				<c:if test="${empty pageContext.request.userPrincipal}">
					<li class="nav-item-cat"><a class="nav-link"
						href="${pageContext.request.contextPath }/login">Đăng nhập</a></li>
				</c:if>
				<c:if test="${not empty pageContext.request.userPrincipal}">
					<li class="nav-item-cat dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="userDropdownMenuLink" data-toggle="dropdown"> ${user.lastName}</a>
						<div class="dropdown-menu dropdown-cat"
							aria-labelledby="userDropdownMenuLink">
							<c:if test="${user.role eq 'ROLE_ADMIN'}">
							<a class="dropdown-item dropdown-item-cat" href="${pageContext.request.contextPath}/admin" target="_blank">Trang quản trị</a> 
							</c:if>
							<a class="dropdown-item dropdown-item-cat" href="${pageContext.request.contextPath}/profile?username=${user.userName}">Thông tin tài khoản</a> 
							<a class="dropdown-item dropdown-item-cat" href="${pageContext.request.contextPath}/j_spring_security_logout?${_csrf.parameterName}=${_csrf.token}">Đăng xuất</a>
						
						</div></li>
				</c:if>

			</ul>
		</div>
	</div>
</nav>
<!-- END ./HEADER -->

<!--SHOPPING CART-->
<div id="container-cart" class="container">
	<div class="shopping-cart">

		<!--START SHOPPING CART HEADER-->
		<div class="shopping-cart-header">
			<i class="fa fa-shopping-cart cart-icon"></i> <span
				id="total-product-in-cart" class="badge cart-header-badge">${(not empty CART_LIST) ? CART_LIST.totalProduct : 0}</span>
			<div class="shopping-cart-total">
				<span class="lighter-text">Tổng cộng: </span> <span
					id="total-price-in-cart" class="main-color-text"><fmt:formatNumber
						value="${(not empty CART_LIST) ? CART_LIST.totalPrice : 0}"
						type="currency" /></span>
			</div>
		</div>
		<!--END SHOPPING CART HEADER-->

		<c:if test="${not empty CART_LIST}">
			<ul id="cart_list" class="shopping-cart-items">
				<c:forEach var="cart" items="${CART_LIST.carts}">
					<li class="clearfix"><a href="#"> <img
							src="${cart.product.image}" alt=""> <span class="item-name">${cart.product.name}</span>
							<span class="item-price"><fmt:formatNumber
									value="${cart.product.salePrice}" type="currency" /></span> <span
							class="item-quantity">Quantity: ${cart.quantity}</span>
					</a></li>
				</c:forEach>
			</ul>
		</c:if>
		<div class="detail-cart">
			<a href="${pageContext.request.contextPath}/carts"
				class="btn btn-detail-cart">Chi tiết</a>
		</div>
	</div>
</div>
<!--END SHOPPING CART-->

