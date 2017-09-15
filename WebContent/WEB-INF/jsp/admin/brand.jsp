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
						<div><a href="${pageContext.request.contextPath }/admin/add-product" class="btn btn-info"><i class="fa fa-plus-square" aria-hidden="true"></i>
						Thêm hãng</a></div>
							<table id="example1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Hình</th>
										<th>Tên Hãng</th>
										<th>Trạng thái</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="p" items="${result.list}">
										<tr id="${p.id}">
											<td>${p.id}</td>
											<td><img width="80px" height="60px" src="${p.image}"
												alt=""></td>
											<td>${p.name}</td>
											<td><c:if test="${p.status eq 1}">
													<span class="label label-success">Publish</span>
												</c:if> <c:if test="${p.status eq 0}">
													<span class="label label-warning">Hidden</span>
												</c:if></td>
											<td>
												<div class="btn-group-vertical">
													<a class="btn btn-info"
														href="${pageContext.request.contextPath}/admin/edit-brand/${p.id}"><i
														class="fa fa-pencil-square-o"></i></a>
													<button type="button" brand-name="${p.name}"
														brand-id="${p.id}" class="btn btn-danger btn-remove-brand">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<th>ID</th>
										<th>Hình</th>
										<th>Tên Hãng</th>
										<th>Trạng Thái</th>
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
			<!-- Modal -->
			<div class="modal fade" id="modalRemoveBrand" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Message</h5>
							<button type="button" class="close btn-close-modal"
								data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary btn-close-modal"
								data-dismiss="modal">Close</button>
							<button id="btn-remove-brand-from-list" type="button"
								product-name="" product-id="" class="btn btn-danger">Delete</button>
						</div>
					</div>
				</div>
			</div>
			<!-- end./ Modal -->
		</div>
		<!-- /.content-wrapper -->


		<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
		<script type="text/javascript">
			$(document).ready(function() {
				// close modal
				$('.btn-close-modal').click(function() {
					$('#modalRemoveBrand').modal('hide');
				});
				// show modal
				$('.btn-remove-brand').click(function() {
					var brandName = $(this).attr('brand-name');
					var brandId = $(this).attr('brand-id');
					$('#btn-remove-brand-from-list').attr('brand-id',brandId);
					$('.modal-body').html('<p class="text-danger">Bạn chắc chắn muốn xóa <strong>'
											+ brandName+ '</strong> khỏi danh sách không?</p>');
					$('#modalRemoveBrand').modal('show');
				});
				$('#btn-remove-brand-from-list').click(function() {
					var brandId = $(this).attr('brand-id');
					// AJAX: /ajax/remove-product-from-cart
					$.ajax({url : "${pageContext.request.contextPath}/ajax/remove-brand",
							type : "get",
							contentType : "application/json;charset=UTF-8",
							dataType : "text",
							data : {brand_id : brandId},
							success : function(result) {
										console.log("SUCCESS: ",result);
											if (result == 'true') {
												$('#modalRemoveBrand').modal('hide');
												var id = '#'+ brandId;
												$(id).remove();
											} else {
												$('.modal-body').html('<p class="text-danger">Không thể xóa hãng đã có sản phẩm!</p>');
												$('#modalRemoveBrand').modal('show');
											}
							},
							error : function(e) {console.log("ERROR: ",e);
											$('.modal-body').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
											$('#modalRemoveBrand').modal('show');
									}
				});});});
		</script>
</body>
</html>