<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Upload</title>
<jsp:include page="//WEB-INF/jsp/admin/includes/_head.jsp"></jsp:include>

</head>
<body>

					

          	<%-- <form id="form-upload" action="${pageContext.request.contextPath}/up/oneFile" enctype="multipart/form-data" method="POST">
          	<div class="box-body">
                <div class="form-group">
                  <label>File to upload:</label>
				  <input id="file-data" name="file" type="file"/>
                </div>
               </div>
              <div class="box-footer">
              	<center>
	                <button id="btn-submit" type="button" class="btn btn-primary"><i class="fa fa-upload"></i> Upload File</button>
              	</center>
              </div>
          	</form> --%>
			<hr>

			   <div id="form-upload" class="form-group">
                  <label for="exampleInputFile">File input</label>
                  
                  <input type="hidden" class="form-control" id="postImage" name="post_image" value="${post.image}" placeholder="Image...">
                  <input type="file" id="file-data" class="form-control-file" name="files[]" aria-describedby="fileHelp" required>
                  <button type="button" id="btn-upload" class="btn btn-primary"><i class="fa fa-cloud-upload" ></i> Upload</button>
                  
                  <!-- <p class="help-block">Example block-level help text here.</p> -->
                </div>



<!-- jQuery 2.2.0 -->
<script src="${pageContext.request.contextPath}/themes/admin/plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${pageContext.request.contextPath}/themes/admin/bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="${pageContext.request.contextPath}/themes/admin/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/themes/admin/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="${pageContext.request.contextPath}/themes/admin/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/themes/admin/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/themes/admin/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/themes/admin/dist/js/demo.js"></script>
<!-- fileuploader -->
<script src="${pageContext.request.contextPath}/themes/plugins/fileuploader/jquery.fileuploader.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/themes/plugins/fileuploader/thumbnails_custom.js" type="text/javascript"></script>


<script type="text/javascript">
/* $(document).ready(function(){
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
                "#btn-submit",
                function() {
                	processUpload();
                })	
	
	function processUpload() {
        var oMyForm = new FormData();
        oMyForm.append("file", files[0]);
       	$.ajax({dataType : 'json',
              url : "${pageContext.request.contextPath}/ajax/upload/oneFile",
              data : oMyForm,
              type : "POST",
              enctype: 'multipart/form-data',
              processData: false, 
              contentType:false,
              dataType:"text",
              success: function(result) {
            	  console.log("SUCCESS: ", result);
                  alert(result);
              },
	          error : function(e) {
	              console.log("ERROR: ", e);
	          }
          });
    }
}); */

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
              url : "${pageContext.request.contextPath}/ajax/upload/oneFile",
              data : oMyForm,
              type : "POST",
              enctype: 'multipart/form-data',
              processData: false, 
              contentType:false,
              dataType:"text",
              success: function(result) {
            	  console.log("SUCCESS: ", result);
                  alert(result);
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