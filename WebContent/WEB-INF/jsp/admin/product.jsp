<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Admin</title>
<jsp:include page="//WEB-INF/jsp/admin/includes/_head.jsp"></jsp:include>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<jsp:include page="//WEB-INF/jsp/admin/includes/_header.jsp"></jsp:include>
		<jsp:include page="//WEB-INF/jsp/admin/includes/_sidebar.jsp"></jsp:include>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<h1>
				Data Tables <small>advanced tables</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li><a href="#">Tables</a></li>
				<li class="active">Data tables</li>
			</ol>
			</section>
			<!-- Main content -->
			<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">HÃNG SẢN XUẤT</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<table id="example1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>STT</th>
										<th>Hình</th>
										<th>Tên sản phẩm</th>
										<th>Loại sản phẩm</th>
										<th>Hãng sản xuất</th>
										<th>đơn giá</th>
										<th>Giảm giá</th>
										<th>Trạng thái</th>
										<th>Ngày tạo</th>
										<th>Chi tiết sản phẩm</th>
										<th>Ưu đải</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="p" items="${result.list}">
										<tr>
											<td>${p.id}</td>
											<td class="post-img">
												<img src="${p.image}" alt="${p.image }" width="150px" height="200px"></td>
											<td>${p.name}</td>
											<td>${p.category.name}</td>
											<td>${p.brand.name }</td>
											<td><fmt:formatNumber type="currency" value="${p.price }" /></td>
											<td><fmt:formatNumber type="currency" value="${p.salePrice }" /></td>
											<td>
												<c:if test="${p.status eq 1}">
													<span class="label label-success">Publish</span>
												</c:if> 
												<c:if test="${p.status eq 0}">
													<span class="label label-warning">Hidden</span>
												</c:if>
											</td>
											<td>
												<fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${p.createdAt }" />
											</td>
											<td>
												<a class="btn btn-info " href="${pageContext.request.contextPath }/admin/add-brand?brand-id=${p.id}">
													<i class="fa fa-pencil-square-o"></i>
												</a>
											</td>
											<td>
												<a class="btn btn-info " href="${pageContext.request.contextPath }/admin/add-brand?brand-id=${p.id}">
													<i class="fa fa-pencil-square-o"></i>
												</a>
											</td>
											<td>
												<a class="btn btn-info " href="${pageContext.request.contextPath }/admin/add-brand?brand-id=${p.id}">
													<i class="fa fa-pencil-square-o"></i>
												</a> 
												<a class="btn btn-danger " href="#">
													<i class="fa fa-times"></i>
												</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<th>STT</th>
										<th>Hình</th>
										<th>Tên sản phẩm</th>
										<th>Loại sản phẩm</th>
										<th>Hãng sản xuất</th>
										<th>đơn giá</th>
										<th>Giảm giá</th>
										<th>Trạng thái</th>
										<th>Ngày tạo</th>
										<th>Chi tiết sản phẩm</th>
										<th>Ưu đải</th>
										<th></th>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- /.box-body -->

						<div class="box-footer clearfix">
							<ul class="pagination pagination-sm no-margin pull-right">
								<li><a href="#">&laquo;</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">&raquo;</a></li>
							</ul>
						</div>

					</div>
					<!-- /.box -->
				</div>

			</div>
			<!-- /.row --> </section>
			<!-- /.content -->

		</div>
		<!-- /.content-wrapper -->


		<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
</body>
</html>