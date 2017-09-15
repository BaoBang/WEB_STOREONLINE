<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
<title>PTit Shop | Sản Phẩm</title>
</head>
<body>
	<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>



	<!-- CONTENT -->
	<div class="container content-shop">

		<div class="row">
			<div class="col-md-12">
				<ol class="breadcrumb breadcrumb-shop">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home"><i
							class="fa fa-home"></i> Trang chủ</a></li>
					<li class="breadcrumb-item active">${product.category.name}</li>
				</ol>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="product-title">
					<span>${product.name }</span>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="card-deck product-detail mt-3">
					<div class="col-md-1 card pr-0 mr-0">
						<div class="image-gallery pr-0 pl-0">
							<div class="thumbnails">
							
							
								<c:forEach items="${productImages }" var="image">
									
									<a href="#" class="thumbnail"
										data-big="${image.url }">
										<div class="thumbnail-image">
											<img src="${image.url }" alt="">
										</div>
									</a>
									
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-md-6 card pl-0 pr-0 ml-0 mr-0">
						<div class="image-gallery pl-0">
							<div class="primary ">
								<img class="primary-image img-fluid" src="${productImages.get(0).url }"
									alt="${product.name}">
							</div>
						</div>
					</div>
					<div class="col-md-5 card pl-0 ml-0">
						<div class="price-sale">
							<div class="area-price">

								<strong><fmt:formatNumber type="currency"
										value="${product.salePrice }"></fmt:formatNumber></strong>
								<del>
									<fmt:formatNumber type="currency" value="${product.price }"></fmt:formatNumber>
								</del>
							</div>
							<div class="area-promotion">
								<c:if test="${product.promotions.size() gt 0 }">
									</p>
									<strong>${product.promotions.size()} khuyến mãi áp
										dụng đến <fmt:formatDate pattern="dd-MM-yyyy"
											value="${product.promotions.get(0).endAt }" />
									</strong>
									<c:forEach items="${product.promotions }" var="promotion">
										<span>${promotion.name }</span>
									</c:forEach>
								</c:if>
							</div>
							<a href="#" class="btn btn-add-to-cart mr-0 ml-0"
								style="visibility: visible;">Thêm Giỏ Hàng</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="product-detail">
					<ul class="nav nav-tabs">
						<li class="nav-item active"><a href="#feature"
							class="nav-link" data-toggle="tab" role="tab">Đặc điểm nỗi
								bật</a></li>
						<li class="nav-item"><a href="#digital" class="nav-link"
							data-toggle="tab" role="tab">Thông số kĩ thuật</a></li>
						<li class="nav-item"><a href="#comment" class="nav-link"
							data-toggle="tab" role="tab">Bình luận</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="feature" role="tabpanel">
									${product.productDetail.description }
						</div>
						<div class="tab-pane" id="digital" role="tabpanel">
							<ul class="digital-ul">
							${product.productDetail.digitals}
							</ul>
						</div>

						<div class="tab-pane" id="comment" role="tabpanel">
							<div class="comment-box" style="height: 500px;"></div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END ./CONTENT -->


	<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>
</body>
</html>