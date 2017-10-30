<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Thêm thành viên mới | PTiTShop AdminCP</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_account"/>
<c:set var="current_page" value="page_add_new_account"/>
<div class="wrapper">

<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Thêm thành viên
        <small>Thành viên</small>
      </h1>
    </section>
	
	<!-- Main content -->
    <section class="content">
      <div class="row">
      
       <div class="col-md-12">
        <c:if test="${not empty result and result}">
	        <div class="alert alert-success alert-dismissible">
	        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Thêm thành viên <strong>${account.getFullName()}</strong> thành công.
	        </div>
         </c:if>
         <c:if test="${not empty result and result eq false}">
	        <div class="alert alert-warning alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Thêm thành viên <strong>${account.getFullName()}</strong> thất bại.
              </div>
         </c:if>
        </div>
		
		<div class="col-md-12">
		
		<!-- general form elements disabled -->
          <div class="box box-primary">
              <form role="form" action="${pageContext.request.contextPath}/admin/add-new-account" method="post">
            <div class="box-header with-border">
              <h3 class="box-title">Thêm thành viên mới</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              	
                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.userName)) ? ' has-warning':''}">
                  <label><c:if test="${((not empty errors) and (not empty errors.userName))}"><i class="fa fa-times-circle-o"></i> </c:if>Tên tài khoản</label>
                  <input type="text" name="account_user_name" value="${account.userName}" class="input-lg form-control${((not empty errors) and (not empty errors.userName)) ? ' form-control-warning':''}" placeholder="Nhập tên tài khoản" autoforcus required>
                  <c:if test="${(not empty errors) and (not empty errors.userName)}">
              	  <small class="form-text text-warning">${errors.userName}</small>
                  </c:if>
                </div>

                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.firstName)) ? ' has-warning':''}">
                  <label><c:if test="${((not empty errors) and (not empty errors.firstName))}"><i class="fa fa-times-circle-o"></i> </c:if>Họ</label>
                  <input type="text" name="account_first_name" value="${account.firstName}" class="form-control${((not empty errors) and (not empty errors.firstName)) ? ' form-control-warning':''}" placeholder="Nhập họ" required>
                  <c:if test="${(not empty errors) and (not empty errors.firstName)}">
              	  <small class="form-text text-warning">${errors.firstName}</small>
                  </c:if>
                </div>
                
                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.lastName)) ? ' has-warning':''}">
                  <label><c:if test="${((not empty errors) and (not empty errors.lastName))}"><i class="fa fa-times-circle-o"></i> </c:if>Tên</label>
                  <input type="text" name="account_last_name" value="${account.lastName}" class="form-control${((not empty errors) and (not empty errors.lastName)) ? ' form-control-warning':''}" placeholder="Nhập tên" required>
                  <c:if test="${(not empty errors) and (not empty errors.lastName)}">
              	  <small class="form-text text-warning">${errors.lastName}</small>
                  </c:if>
                </div>

                <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.password)) ? ' has-warning':''}">
                  <label><c:if test="${((not empty errors) and (not empty errors.password))}"><i class="fa fa-times-circle-o"></i> </c:if>Mật khẩu</label>
                  <input type="password" name="account_password" value="${account.password}" class="form-control${((not empty errors) and (not empty errors.password)) ? ' form-control-warning':''}" placeholder="Nhập mật khẩu" required>
                  <c:if test="${(not empty errors) and (not empty errors.password)}">
              	  <small class="form-text text-warning">${errors.password}</small>
                  </c:if>
                </div>
                
                <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.confirm)) ? ' has-warning':''}">
                  <label><c:if test="${((not empty errors) and (not empty errors.confirm))}"><i class="fa fa-times-circle-o"></i> </c:if>Nhập lại mật khẩu</label>
                  <input type="password" name="account_confirm_password" value="${account.confirm}" class="form-control${((not empty errors) and (not empty errors.confirm)) ? ' form-control-warning':''}" placeholder="Nhập mật khẩu" required>
                  <c:if test="${(not empty errors) and (not empty errors.confirm)}">
              	  <small class="form-text text-warning">${errors.confirm}</small>
                  </c:if>
                </div>
                
                <div id="form-upload" class="form-group">
                  <label for="file-data">Avatar</label>
                  <input type="hidden" class="form-control" id="account_avatar" name="account_avatar" value="${account.avatar}" placeholder="Avatar">
                  <input type="file" id="file-data" class="form-control-file" name="files[]" aria-describedby="fileHelp">
                  <button type="button" id="btn-upload" class="btn btn-primary"><i class="fa fa-cloud-upload" ></i> Upload</button>
                </div>
                
				<!-- select -->
                <div class="form-group">
                  <label>Quyền</label>
                  <select name="account_role" class="form-control">
                    <option value="ROLE_USER">Người dùng</option>
                    <option value="ROLE_ADMIN">Quản trị viên</option>
                  </select>
                </div>

                <!-- radio -->
                <div class="form-group">
                  <label><c:if test="${((not empty errors) and (not empty errors.status))}"><i class="fa fa-times-circle-o"></i> </c:if>Tình trạng</label>
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="1" ${account.status eq 1 ? 'checked':''}>
                      <span class="label label-success">Hoạt động</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="post_status" value="0" ${account.status eq 0 ? 'checked':''}>
                      <span class="label label-warning">Khóa</span>
                    </label>
                  </div>
                   <c:if test="${(not empty errors) and (not empty errors.status)}">
                  <small class="form-text text-warning">${errors.status}</small>
                  </c:if>
                </div>
                

            </div>
            <!-- /.box-body -->
			  <div class="box-footer text-center">
	            <button type="submit" class="btn btn-lg btn-primary"><i class="fa fa-plus"></i> Thêm</button>
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
            	  $('#account_avatar').val(result);
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