<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Admin</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_promotion"></c:set>
<c:set var="current_page" value="page_promotion_list"></c:set>
<div class="wrapper">
<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<h1>
				Khuyến Mãi <small>PTiTShop</small>
			</h1>
			
			</section>


			<!-- Main content -->
			<section class="content">
			<div class="row">
				<div class="col-md-12 col-xs-12">
					<!-- general form elements -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">THÊM ƯU ĐÃI</h3>
						</div>
						<!-- /.box-header -->
						<!-- form start -->
						<form role="form"
							action="${pageContext.request.contextPath }/admin/edit-promotion/${promotion.id}"
							method="get" enctype="multipart/form-data">
							<div class="box-body">
								<input type="hidden" name="promotionid" value="${promotion.id }">
								<div class="form-group">
									<label>Tên ưu đãi:</label> <input type="text"
										name="promotionname" required value="${promotion.name }" class="form-control"
										placeholder="Nhập vào tên hãng" />
								</div>
								<div id="form-upload" class="form-group">
									<label>Hình:</label> <input type="text" class="form-control"
										id="promotionImage" name="promotionimage" value="${promotion.image }"
										placeholder="Hình..." readonly="readonly"> <input
										class="form-control" type="file" name="files[]" >
									<button type="button" id="btn-upload" class="btn btn-primary">
										<i class="fa fa-cloud-upload"></i> Upload
									</button>
								</div>
								<div class="form-group">
									<label>Nội dung</label>
									<textarea id="txtAreaCKEditor" name="promotioncontent"
										class="form-control" rows="5" cols="">${promotion.content }</textarea>
								</div>
								<div class="form-group">
									<label>Thời gian :</label>

									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<fmt:formatDate pattern="MM'/'dd'/'yyyy" value="${promotion.startAt }" var="start" />
										<fmt:formatDate pattern="MM'/'dd'/'yyyy" value="${promotion.endAt }" var="end" />
										<input type="text" class="form-control pull-right"
											id="reservation" required name="promotiondate" value="${start} - ${end}">
									</div>
									<!-- /.input group -->
								</div>
								<!-- /.form group -->
								<div class="form-group">
									<label>Trạng thái:</label>
									<div class="radio">
										<label> <input name="promotionstatus" type="radio"
											value="1" ${promotion.status eq '1' ? 'checked': '' }><span class="badge bg-green">Hiện</span>
										</label>
									</div>
									<div class="radio">
										<label> <input name="promotionstatus" type="radio"
											value="0"  ${promotion.status eq '0' ? 'checked': '' }><span class="badge bg-yellow">Ẩn</span>
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


	<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>	
	<!--date range picker -->
	<script src="/PTiTShop/themes/plugins/daterangepicker/moment.min.js"></script>
	<script
		src="/PTiTShop/themes/plugins/daterangepicker/daterangepicker.js"></script>
	<script>
		$(function() {
			//Date range picker
			$('#reservation').daterangepicker();
		});
	</script>
	<script src="/PTiTShop/themes/plugins/ckeditor/ckeditor.js"></script>

	<script>
		CKEDITOR.replace('txtAreaCKEditor', {
			/* extraPlugins : 'syntaxhighlight',  */
			toolbar : [
					[ 'Source', '-', 'Save', 'NewPage', 'DocProps', 'Preview',
							'Print', '-', 'Templates' ],
					[ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord',
							'-', 'Undo', 'Redo' ],
					[ 'Find', 'Replace', '-', 'SelectAll', '-', 'SpellChecker',
							'Scayt' ],
					[ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea',
							'Select', 'Button', 'ImageButton', 'HiddenField' ],
					[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript',
							'Superscript', '-', 'RemoveFormat' ],
					[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent',
							'-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft',
							'JustifyCenter', 'JustifyRight', 'JustifyBlock',
							'-', 'BidiLtr', 'BidiRtl' ],
					[ 'Link', 'Unlink', 'Anchor' ],
					[ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley',
							'SpecialChar', 'PageBreak', 'Iframe' ],
					[ 'Styles', 'Format', 'Font', 'FontSize' ],
					[ 'TextColor', 'BGColor' ],
					[ 'Maximize', 'ShowBlocks', '-', 'About' ],
					[ 'Syntaxhighlight' ] ]
		});
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var files = [];
							$(document).on("change", "#form-upload",
									function(event) {
										files = event.target.files;
									});

							$(document).on("click", "#btn-upload", function() {
								processUpload();
							});

							function processUpload() {
								var oMyForm = new FormData();
								oMyForm.append("file", files[0]);
								$
										.ajax({
											dataType : 'json',
											url : "${pageContext.request.contextPath}/ajax/upload/one-file",
											data : oMyForm,
											type : "POST",
											enctype : 'multipart/form-data',
											processData : false,
											contentType : false,
											dataType : "text",
											success : function(result) {
												console.log("SUCCESS: ",result);
												$('#promotionImage').val(result);
											},
											error : function(e) {
												alert("Vui lòng chọn hình trước khi upload");
											}
										});
							}
						});
	</script>
</body>
</html>