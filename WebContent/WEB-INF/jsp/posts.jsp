<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <div class="row">
    <div class="col-md-12">
      <ol class="breadcrumb breadcrumb-shop">
        <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
        <li class="breadcrumb-item active">Tin tức</li>
      </ol>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="product-list-title">
        <span>TIN CÔNG NGHỆ</span>
        <div class="dropdown float-right mr-0">
          <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
            Sắp xếp theo
          </button>
          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="#">Tin mới nhất</a>
            <a class="dropdown-item" href="#">Xem nhiều nhất</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="post-list">
      
      	<c:forEach var="p" items="${result.list}">
        <!-- post item -->
        <div class="post-item">
          <div class="row">
            <div class="col-md-4 post-image"><img class="img-fluid" src="${p.image}" alt=""></div>
            <div class="col-md-8 post-info">
              <h3><a href="${pageContext.request.contextPath}/post/${p.id}/${p.slug}">${p.title}</a></h3>
              <span><fmt:formatDate pattern="HH:mm ', Ngày ' dd ' Tháng ' MM ' Năm' yyyy" value="${p.publishDate}"/></span>
              <p>${p.description}</p>
              <a class="btn btn-read-more" href="${pageContext.request.contextPath}/post/${p.id}/${p.slug}">Xem thêm</a>
            </div>
          </div>
        </div>
        <!-- end./ post item -->
      	</c:forEach>


      </div>
    </div>
  </div>

  <c:if test="${result.totalPage gt 1}">
  <!-- pagination -->
  <nav class="pagination-shop" aria-label="Page navigation example">
    <ul class="pagination justify-content-center mt-4">
    <c:if test="${result.currentPage gt 1}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-1">Đầu</a>
      </li>
    </c:if>
    <c:forEach var="p" begin="${1}" end="${result.currentPage}">
    <c:if test="${p lt result.currentPage}">
      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${p}">${p}</a></li>
    </c:if>
    </c:forEach>
    
      <li class="page-item active"><span class="page-link">${result.currentPage}</span></li>
	
	<c:forEach var="p" begin="${result.currentPage}" end="${result.totalPage}">
	<c:if test="${p gt result.currentPage}">
      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${p}">${p}</a></li>
	</c:if>
    </c:forEach>
	
	<c:if test="${result.currentPage lt result.totalPage}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/category/${category.slug}/page-${result.totalPage}">Cuối</a>
      </li>
	</c:if>
    </ul>
  </nav>
  <!-- end./pagination -->
</c:if>

</div>
<!-- END ./CONTENT -->


<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>
</body>
</html>