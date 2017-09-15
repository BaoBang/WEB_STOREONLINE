<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
        Data Tables
        <small>advanced tables</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Admin</a></li>
        <li><a href="#">Post</a></li>
        <li class="active">Add new post</li>
      </ol>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
      
       <div class="col-md-12">
        <c:if test="${not empty result and result}">
	        <div class="alert alert-success alert-dismissible">
	        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Thêm bài viết <strong>${post.title}</strong> thành công.
	        </div>
         </c:if>
         <c:if test="${not empty result and result eq false}">
	        <div class="alert alert-warning alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Thêm bài viết <strong>${post.title}</strong> thất bại.
              </div>
         </c:if>
        </div>
		
		<div class="col-md-12">
		
		<!-- general form elements disabled -->
          <div class="box box-primary">
              <form role="form" action="${pageContext.request.contextPath}/admin/add-new-post" method="post">
            <div class="box-header with-border">
              <h3 class="box-title">Add new post</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              	
              	<!-- input states -->
                <!-- <div class="form-group has-success">
                  <label class="control-label" for="inputSuccess"><i class="fa fa-check"></i> Input with success</label>
                  <input type="text" class="form-control" id="inputSuccess" placeholder="Enter ...">
                  <span class="help-block">Help block with success</span>
                </div>
                <div class="form-group has-warning">
                  <label class="control-label" for="inputWarning"><i class="fa fa-bell-o"></i> Input with
                    warning</label>
                  <input type="text" class="form-control" id="inputWarning" placeholder="Enter ...">
                  <span class="help-block">Help block with warning</span>
                </div>
                <div class="form-group has-error">
                  <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> Input with
                    error</label>
                  <input type="text" class="form-control" id="inputError" placeholder="Enter ...">
                  <span class="help-block">Help block with error</span>
                </div> -->
              
                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.title)) ? ' has-warning':''}">
                  <label>Title</label>
                  <input type="text" name="post_title" value="${post.title}" class="input-lg form-control${((not empty errors) and (not empty errors.title)) ? ' form-control-warning':''}" placeholder="Enter title ..." required>
                  <c:if test="${(not empty errors) and (not empty errors.title)}">
              	  <small class="form-text text-warning">${errors.title}</small>
                  </c:if>
                </div>

                <!-- textarea -->
                <div class="form-group${((not empty errors) and (not empty errors.description)) ? ' has-warning':''}">
                  <label>Description</label>
                  <textarea class="form-control${((not empty errors) and (not empty errors.description)) ? ' form-control-warning':''}" rows="3" name="post_description" placeholder="Enter description ..." required>${post.description}</textarea>
                  <c:if test="${(not empty errors) and (not empty errors.description)}">
	              <small class="form-text text-warning">${errors.description}</small>
	              </c:if>
                </div>
                
                <div class="form-group${((not empty errors) and (not empty errors.content)) ? ' has-warning':''}">
                  <label>Content</label>
                  <textarea id="textAreaCKEditor" class="form-control${((not empty errors) and (not empty errors.content)) ? ' form-control-warning':''}" rows="10" name="post_content" placeholder="Enter content ..." required>${post.content}</textarea>
                  <c:if test="${(not empty errors) and (not empty errors.content)}">
                  <small class="form-text text-warning">${errors.content}</small>
                  </c:if>
                </div>

                <div id="form-upload" class="form-group">
                  <label for="file-data">File input</label>
                  <input type="text" class="form-control" id="postImage" name="post_image" value="${post.image}" placeholder="Image...">
                  <input type="file" id="file-data" class="form-control-file" name="files[]" aria-describedby="fileHelp" required>
                  <button type="button" id="btn-upload" class="btn btn-primary"><i class="fa fa-cloud-upload" ></i> Upload</button>
                  <!-- <i class="fa fa-spinner fa-pulse fa-fw"></i> -->
                  <!-- <p class="help-block">Example block-level help text here.</p> -->
                </div>


                <!-- radio -->
                <div class="form-group">
                  <label>Status</label>
                 
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="1" ${post.status eq 1 ? 'checked':''}>
                      Publish
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="0" ${post.status eq 0 ? 'checked':''}>
                      Hidden
                    </label>
                  </div>
                   <c:if test="${(not empty errors) and (not empty errors.status)}">
                  <small class="form-text text-warning">${errors.status}</small>
                  </c:if>
                </div>


            </div>
            <!-- /.box-body -->
			  <div class="box-footer text-center">
	            <button type="submit" class="btn btn-lg btn-primary"><i class="fa fa-plus"></i> PUBLISH</button>
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
	

<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
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