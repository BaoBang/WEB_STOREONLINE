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
				<div class="col-md-12 col-xs-12">
					<!-- general form elements -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">THÊM HÃNG SẢN XUẤT</h3>
						</div>
						<!-- /.box-header -->
						<!-- form start -->
						<form role="form"
							action="${pageContext.request.contextPath }/admin/edit-brand/${brand.id}"
							method="get" enctype="multipart/form-data">
							<div class="box-body">
								<div class="form-group">
									<label>Hãng sản xuất:</label> <input type="text"
										name="brandname" required value="${brand.name }"
										class="form-control" placeholder="Nhập vào tên hãng"/>
								</div>
								<div class="form-group">
									<label>Hình:</label>
									<input type="text" name="brandimage" readonly="readonly" class="form-control" value="${brand.image }"/>
									<input class="form-control" type="file"
										name="files[]" required>
										<button type="button" id="btn-upload" class="btn btn-primary">
										<i class="fa fa-cloud-upload"></i> Upload
									</button>
								</div>
									<div class="form-group">
									<label>Trạng thái:</label>
									<div class="radio">
										<label>
											<input name="brandstatus" type="radio" value="1" ${brand.status eq '1' ? 'checked' : '' } >Hiện
										</label>
									</div>
									<div class="radio">
										<label> 
											<input name="brandstatus" type="radio" value="0" ${brand.status eq '0' ? 'checked' : '' }>Ẩn
										</label>
									</div>
								</div>
							</div>
							<!-- /.box-body -->

							<div class="box-footer">
								<button type="submit" class="btn btn-primary" value="submit"
									name="submit">Submit</button>
							</div>
						</form>
					</div>
					<!-- /.box -->
				</div>
				<c:if test="${ not empty error}">
					<script>
						alert("${error}");
					</script>

				</c:if>
			</div>
			<!-- /.row --> </section>
			<!-- /.content -->
		</div>
	</div>
	<!-- /.content-wrapper -->


	<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
</body>
</html>