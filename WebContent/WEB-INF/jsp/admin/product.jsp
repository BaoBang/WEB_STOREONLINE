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
							<h3 class="box-title">DANH SÁCH SẢN PHẨM</h3>
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
									<c:forEach var="p" items="${result}">
										<tr id="${p.id }">
											<td class="">${p.id}</td>
											<td class="post-img">
												<img src="${p.image}" alt="${p.image }" width="150px" height="200px"></td>
											<td class="large-cell">${p.name}</td>
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
												<a class="btn btn-info " href="${pageContext.request.contextPath }/admin/edit-product/${p.id}">
													<i class="fa fa-pencil-square-o"></i>
												</a> 
												<button type="button" product-name="${p.name}"
														product-id="${p.id}" class="btn btn-danger btn-remove-product">
														<i class="fa fa-times"></i>
													</button>
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
					</div>
					<!-- /.box -->
				</div>

			</div>
			<!-- /.row --> </section>
			<!-- /.content -->
		<!-- Modal -->
			<div class="modal fade" id="modalRemoveProduct" tabindex="-1"
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
							<button id="btn-remove-product-from-list" type="button"
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
				// scroll
				 $('#example1').DataTable( {
			        "scrollX": true,
			        "fnDrawCallback": function( oSettings ) {
			        	showModal();
			        }
			    } );
				// close modal
				$('.btn-close-modal').click(function() {
					$('#modalRemoveProduct').modal('hide');
				});
				// show modal
				function showModal(){
					$('.btn-remove-product').click(function() {
						var productName = $(this).attr('product-name');
						var productId = $(this).attr('product-id');
						$('#btn-remove-product-from-list').attr('product-id',productId);
						$('.modal-body').html('<p class="text-danger">Bạn chắc chắn muốn xóa <strong>'
												+ productName+ '</strong> khỏi danh sách không?</p>');
						$('#modalRemoveProduct').modal('show');
					});
					}
				
				$('#btn-remove-product-from-list').click(function() {
					var productId = $(this).attr('product-id');
					// AJAX: /ajax/remove-product-from-cart
					$.ajax({url : "${pageContext.request.contextPath}/ajax/remove-product",
							type : "get",
							contentType : "application/json;charset=UTF-8",
							dataType : "text",
							data : {product_id : productId},
							success : function(result) {
										console.log("SUCCESS: ",result);
											if (result == 'true') {
												$('#modalRemoveProduct').modal('hide');
												var id = '#'+ productId;
												$(id).remove();
											} else {
												$('.modal-body').html('<p class="text-danger">Không thể xóa sản phẩm!</p>');
												$('#modalRemoveProduct').modal('show');
											}
							},
							error : function(e) {console.log("ERROR: ",e);
											$('.modal-body').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
											$('#modalRemoveProduct').modal('show');
									}
				});});});
		</script>
</body>
</html>