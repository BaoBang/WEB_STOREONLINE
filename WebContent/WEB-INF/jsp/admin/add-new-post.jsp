<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Viết bài mới | PTiTShop AdminCP</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_post"/>
<c:set var="current_page" value="page_add_new_post"/>
<div class="wrapper">

<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Viết bài mới
        <small>Bài viết</small>
      </h1>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
      
       <div class="col-md-12">
        <c:if test="${not empty result and result}">
	        <div class="alert alert-success alert-dismissible">
	        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Thêm bài viết <strong>${post_title}</strong> thành công.
	        </div>
         </c:if>
         <c:if test="${not empty result and result eq false}">
	        <div class="alert alert-warning alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Thêm bài viết <strong>${post_title}</strong> thất bại.
              </div>
         </c:if>
        </div>
		
		<div class="col-md-12">
		
		<!-- general form elements disabled -->
          <div class="box box-primary">
              <form role="form" action="${pageContext.request.contextPath}/admin/add-new-post" method="post">
            <div class="box-header with-border">
              <h3 class="box-title">Viết bài mới</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              	
                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.title)) ? ' has-warning':''}">
                  <label>Tiêu đề</label>
                  <input type="text" name="post_title" value="${post.title}" class="input-lg form-control${((not empty errors) and (not empty errors.title)) ? ' form-control-warning':''}" placeholder="Nhập tiêu đề" required>
                  <c:if test="${(not empty errors) and (not empty errors.title)}">
              	  <small class="form-text text-warning">${errors.title}</small>
                  </c:if>
                </div>

                <!-- textarea -->
                <div class="form-group${((not empty errors) and (not empty errors.description)) ? ' has-warning':''}">
                  <label>Mô tả</label>
                  <textarea class="form-control${((not empty errors) and (not empty errors.description)) ? ' form-control-warning':''}" rows="3" name="post_description" placeholder="Nhập mô tả" required>${post.description}</textarea>
                  <c:if test="${(not empty errors) and (not empty errors.description)}">
	              <small class="form-text text-warning">${errors.description}</small>
	              </c:if>
                </div>
                
                <div class="form-group${((not empty errors) and (not empty errors.content)) ? ' has-warning':''}">
                  <label>Nội dung</label>
                  <textarea id="textAreaCKEditor" class="form-control${((not empty errors) and (not empty errors.content)) ? ' form-control-warning':''}" rows="10" name="post_content" placeholder="Nhập nội dung" required>${post.content}</textarea>
                  <c:if test="${(not empty errors) and (not empty errors.content)}">
                  <small class="form-text text-warning">${errors.content}</small>
                  </c:if>
                </div>

                <div id="form-upload" class="form-group">
                  <label for="file-data">Hình ảnh</label>
                  <input type="hidden" class="form-control" id="postImage" name="post_image" value="${post.image}" placeholder="Hình ảnh">
                  <input type="file" id="file-data" class="form-control-file" name="files[]" aria-describedby="fileHelp" required>
                  <button type="button" id="btn-upload" class="btn btn-primary"><i class="fa fa-cloud-upload" ></i> Upload</button>
                  <!-- <i class="fa fa-spinner fa-pulse fa-fw"></i> -->
                  <!-- <p class="help-block">Example block-level help text here.</p> -->
                </div>


                <!-- radio -->
                <div class="form-group">
                  <label>Trạng thái</label>
                 
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="1" ${post.status eq 1 ? 'checked':''}>
                      <span class="badge bg-green">Công khai</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="0" ${post.status eq 0 ? 'checked':''}>
                      <span class="badge bg-yellow">Ẩn</span>
                    </label>
                  </div>
                   <c:if test="${(not empty errors) and (not empty errors.status)}">
                  <small class="form-text text-warning">${errors.status}</small>
                  </c:if>
                </div>


            </div>
            <!-- /.box-body -->
			  <div class="box-footer text-center">
	            <button type="submit" class="btn btn-lg btn-primary"><i class="fa fa-plus"></i> ĐĂNG BÀI VIẾT</button>
	          </div>
           </form>
          </div>
          <!-- /.box -->
		
		
		</div>
		
		
	  </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
    
	</div>
  <!-- /.content-wrapper -->
	


<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>	
<script src="${pageContext.request.contextPath}/themes/plugins/ckeditor/ckeditor.js"></script>
<script>
	CKEDITOR.replace( 'textAreaCKEditor' ,{
    	/* extraPlugins : 'syntaxhighlight',  */       
    	toolbar: [
    		[ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] ,
			[ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ],
			[ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ],
			[ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] ,
			[ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ],
			[ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ],
			[ 'Link','Unlink','Anchor' ] ,
			[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ],
			[ 'Styles','Format','Font','FontSize' ],
			[ 'TextColor','BGColor' ], 
			[ 'Maximize', 'ShowBlocks','-','About' ] ,
			['Syntaxhighlight']
    	]              
	});
</script>  


<script type="text/javascript">
$(document).ready(function(){
	var files = [];
	$(document)
        .on(
                "change",
                "#form-upload",
                function(event) {
                 files=event.target.files;
                })

	$(document)
        .on(
                "click",
                "#btn-upload",
                function() {
                	processUpload();
                })	
	
	function processUpload() {
        var oMyForm = new FormData();
        oMyForm.append("file", files[0]);
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
            	  $('#postImage').val(result);
                  /* alert(result); */
              },
	          error : function(e) {
	              console.log("ERROR: ", e);
	          }
          });
    }
});

</script>

</body>
</html>