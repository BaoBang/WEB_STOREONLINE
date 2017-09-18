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
					<div class="box box-primary ">
						<div class="box-header with-border">
							<h3 class="box-title title-name">CẬP NHẬT SẢN PHẨM</h3>
						</div>
						<!-- /.box-header -->
						<!-- form start -->
						<form role="form" action="" method="post"
							enctype="multipart/form-data">
							<div class="box-body">
								<input type="hidden" value="${product.id }">
								<div class="form-group">
									<label for="productname">Tên Sản phẩm</label> <input
										type="text" class="form-control" id="productname"
										name="productname" placeholder="Nhập vào tên sản phẩm"
										value="${product.name }" required>
								</div>
								<div id="form-upload" class="form-group">
									<label class="control-label col-md-4 col-lg-4">Hình</label>
									<textarea type="text" class="form-control" id="productImage"
										name="productimage" placeholder="Hình..." readonly="readonly" rows="5">${productImageStrings }</textarea>
									<input type="file" name="files">
									<button type="button" id="btn-upload" class="btn btn-primary">
										<i class="fa fa-cloud-upload"></i> Upload
									</button>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Loại sản phẩm</label> <select
										class="form-control" name="productcategory">
										<c:forEach items="${category_list }" var="category">
											<option value="${category.id }">${category.name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Hãng sản xuất</label> <select
										class="form-control" name="productbrand">
										<c:forEach items="${brand_list }" var="brand">
											<option value="${brand.id }">${brand.name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="productprice">Đơn giá</label> <input type="number"
										min="0" class="form-control" id="productprice"
										name="productprice" placeholder="Nhập vào đơn giá sản phẩm"
										required value="${product.price }">
								</div>
								<div class="form-group">
									<label for="productname">Giảm giá</label> <input type="number"
										min="0" class="form-control" id="productsaleprice"
										name="productsaleprice"
										placeholder="Nhập vào đơn giá khuyến mãi" required value="${product.salePrice }">
								</div>
								<div class="form-group">
									<label for="productquantity">Số lượng</label> <input
										type="number" min="0" class="form-control"
										id="productquantity" name="productquantity"
										placeholder="Nhập vào số lượng sản phẩm" required value="${product.productDetail.quantity }">
								</div>
								<div class="form-group">
									<label for="productquantity">Đặc điểm</label>
									<textarea id="txtAreaCKEditor" name="productdescription"
										class="form-control" rows="5" cols="">${product.productDetail.description }</textarea>
								</div>
								<div class="form-group">
									<label for="productname">Chi tiết sản phẩm</label>
									<div class="input-digital">
										<ul id="list-inputs">
											${digitalDetails }
										</ul>
										<button type="button"
											class="btn btn-default btn-category-digital"
											onclick="addInputTitle()">Thêm loại thông số</button>
										<button type="button" class="btn btn-default btn-digital"
											onclick="addInputs()">Thêm thông số</button>
									</div>
								</div>
								<div class="form-group">
									<label for="productname">Ưu đải</label> <select
										multiple="multiple" size="5" class="form-control"
										name="promotions">
										<c:forEach items="${promotion_list }" var="promotion">
											<c:set value="false" var="check"></c:set>
											<c:forEach items="${product.promotions }" var="p">
												<c:if test="${promotion.id eq p.id }">
													<c:set value="true" var="check"></c:set>
												</c:if>
											</c:forEach>
											<option style="padding: 5px 0px;" value="${promotion.id }" ${check eq 'true' ? 'selected' : '' }>${promotion.name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label>Trạng thái:</label>
									<div class="radio">
										<label>
											<input name="productstatus" type="radio" value="1" ${product.status eq '1' ? 'checked' : '' } ><span class="badge bg-green">Hiện</span>
										</label>
									</div>
									<div class="radio">
										<label> 
											<input name="productstatus" type="radio" value="0" ${product.status eq '0' ? 'checked' : '' }><span class="badge bg-yellow">Ẩn</span>
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
					<c:if test="${not empty message || message ne ''}">
						<script type="text/javascript">
							alert("${message}");
						</script>
					</c:if>

				</div>
			</div>
			<!-- /.row --> </section>
			<!-- /.content -->

		</div>
	</div>
	<!-- /.content-wrapper -->


	<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
	<script type="text/javascript">
		var li_id = $('ul#list-inputs li').length - 1, flagCateDigi = false, flagDigi = true;
		disableButton(flagCateDigi, flagDigi);
		function disableButton(flagCateDigi, flagDigi) {
			if (flagCateDigi == true) {
				$('.btn-category-digital').attr('disabled', true);
			} else {
				$('.btn-category-digital').removeAttr('disabled');
			}
			if (flagDigi == true) {
				$('.btn-digital').attr('disabled', true);
			} else {
				$('.btn-digital').removeAttr('disabled');
			}
		}
		function addInputTitle() {
			flagCateDigi = true;
			flagDigi = false;
			var ul = document.getElementById('list-inputs');
			var li = document.createElement('li');
			li.setAttribute('id', li_id);
			var input = document.createElement('input');
			input.setAttribute('class', 'form-control input-digital-title');
			input.setAttribute('placeholder', 'Nhập vào loai thông số');
			input.setAttribute('name', 'digital-details');
			var input2 = document.createElement('input');
			input2.setAttribute('type', 'hidden');
			input2.setAttribute('value', '/');
			input2.setAttribute('name', 'digital-details');
			var link = document.createElement('a');
			link.setAttribute('li-id', li_id);
			link.setAttribute('class', 'delete-input');
			link.addEventListener("click", function() {
				var li_id = '#' + $(this).attr('li-id');
				$(li_id).remove();
				flagCateDigi = false;
				flagDigi = false;
				disableButton(flagCateDigi, flagDigi);
			});
			var icon = document.createElement('i');
			icon.setAttribute('class', 'fa fa-times');
			link.appendChild(icon);
			li.appendChild(input);
			li.appendChild(input2);
			li.appendChild(link);
			ul.appendChild(li);
			li_id++;

			disableButton(flagCateDigi, flagDigi);
		}

		function addInputs() {
			flagCateDigi = false;
			flagDigi = false;
			var ul = document.getElementById('list-inputs');
			var li = document.createElement('li');
			li.setAttribute('id', li_id);
			var input = document.createElement('input');
			var input2 = document.createElement('input');
			input.setAttribute('class', 'form-control input-digital-lable');
			input.setAttribute('placeholder', 'Nhập vào tên thông số');
			input.setAttribute('name', 'digital-details');
			input2.setAttribute('class', 'form-control input-digital-span');
			input2.setAttribute('placeholder', 'Nhập vào giá trị thông số');
			input2.setAttribute('name', 'digital-details');
			var link = document.createElement('a');
			link.setAttribute('li-id', li_id);
			link.setAttribute('class', 'delete-input');
			link.addEventListener("click", function() {
				var li_id = '#' + $(this).attr('li-id');
				$(li_id).remove();
				flagCateDigi = true;
				flagDigi = false;
				disableButton(flagCateDigi, flagDigi);
			});
			var icon = document.createElement('i');
			icon.setAttribute('class', 'fa fa-times');
			link.appendChild(icon);
			li.appendChild(input);
			li.appendChild(input2);
			li.appendChild(link);
			ul.appendChild(li);
			li_id++;

			disableButton(flagCateDigi, flagDigi);
		}
	</script>
	<script
		src="${pageContext.request.contextPath}/themes/plugins/ckeditor/ckeditor.js"></script>
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
$(document).ready(function(){
	var files = [];
	$(document).on( "change","#form-upload",function(event) {
       files=event.target.files;
     });

	$(document) .on( "click","#btn-upload",function() {
       processUpload();
    });
	
	function processUpload() {
        var oMyForm = new FormData();
        var imagePaths ="";
        for(var i = 0; i < files.length; i++){
        	oMyForm.append("file", files[i]);
        	$.ajax({dataType : 'json',
                url : "${pageContext.request.contextPath}/ajax/upload/one-file",
                data : oMyForm,
                type : "POST",
                enctype: 'multipart/form-data',
                processData: false, 
                contentType:false,
                dataType:"text",
                success: function(result) {
              	  console.log("SUCCESS: ", result);
              	  imagePaths += result + "\n";
              	  $('#productImage').val(imagePaths);
                    /* alert(result); */
                },
  	          error : function(e) {
  	              console.log("ERROR: ", e);
  	          }
            });
        }
       
    }
});

</script>
</body>

</html>