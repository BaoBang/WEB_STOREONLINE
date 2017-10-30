<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Chi tiết đơn hàng | Admin PTiTShop</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_order"/>
<c:set var="current_page" value="page_order_list"/>
<div class="wrapper">
<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Chi tiết đơn hàng
        <small>Đơn hàng</small>
      </h1>
     
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		<div class="col-xs-3">
			<!-- Profile Image -->
          <div class="box box-primary">
            <div class="box-body box-profile">
              <img class="profile-user-img img-responsive img-circle" src="${order.account.avatar}" alt="${order.account.getFullName()}">

              <h3 class="profile-username text-center"><a href="${pageContext.request.contextPath}/admin/profile/${order.account.id}">${order.account.getFullName()}</a></h3>

              <p class="text-muted text-center">Khách hàng</p>

              <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Tổng giá trị</b> <a class="pull-right"><fmt:formatNumber value="${order.total}" type="currency"/></a>
                </li>
                <li class="list-group-item">
                  <b>Thời gian</b> <a class="pull-right"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${order.createdAt}"/></a>
                </li>
                <li class="list-group-item">
                  <b>Tình trạng</b> 
                  <a class="pull-right">
                  
						<c:if test="${order.status eq -1}"><span class="label label-danger">Đã hủy</span></c:if>
	                	<c:if test="${order.status eq 0}"><span class="label label-warning">Chờ duyệt</span></c:if>
	                	<c:if test="${order.status eq 1}"><span class="label label-success">Đã giao hàng</span></c:if>
				  </a>
                </li>
                
                </ul>
                
              <a href="${pageContext.request.contextPath}/admin/profile/${order.account.id}" class="btn btn-primary btn-block"><b>Thông tin cá nhân</b></a>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
          
          <div class="box box-primary">
	          <div class="box-body box-profile">
	          	<h3 class="profile-username text-center">Tình trạng</h3>
	          	<form action="${pageContext.request.contextPath}/admin/order-detail/${order.id}" method="post">
	          	<!-- radio -->
              <div class="form-group">
                <label>
                  <input type="radio" name="order_status" value="-1" class="minimal" ${order.status eq -1 ? 'checked' : '' }>
                  <span class="label label-danger">Đã hủy</span>
                </label>
                <label>	
                  <input type="radio" name="order_status" value="0" class="minimal" ${order.status eq 0 ? 'checked' : '' }>
                  <span class="label label-warning">Chờ duyệt</span>
                </label>
                <label>
                  <input type="radio" name="order_status" value="1" class="minimal" ${order.status eq 1 ? 'checked' : '' }>
                  <span class="label label-success">Đã giao hàng</span>
                </label>
              </div>
              <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-floppy-o"></i> Lưu</button>
              </form>
	          </div>
          </div>
		</div>
		
		<div class="col-xs-9">
          <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title">Danh sách sản phẩm</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  	<th>#</th>
	                <th>Sản phẩm</th>
	                <th>Tên sản phẩm</th>
	                <th>Số lượng</th>
	                <th>Giá gốc</th>
	                <th>Giá đã giảm</th>
	                <th>Thời gian</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${order_detail_list}">
                <tr>
	                <td>${o.id}</td>
	                <td width="120px;"><img width="100px" src="${o.product.image}" alt=""></td>
	                <td>${o.product.name}</td>
	                <td>${o.quantity}</td>
	                <td><fmt:formatNumber value="${o.price}" type="currency"/></td>
	                <td><fmt:formatNumber value="${o.discount}" type="currency"/></td>
	                <td><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${o.order.createdAt}"/></td>
                </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- /.box-body -->
            
            
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
		
	  </div>
      <!-- /.row -->
      
    </section>
    <!-- /.content -->
    
	</div>
  <!-- /.content-wrapper -->
	
<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>	
</body>
</html>