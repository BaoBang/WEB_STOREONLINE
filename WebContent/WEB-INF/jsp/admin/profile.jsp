<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Thành viên: ${account.getFullName()} | PTiTShop AdminCP</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_account"/>
<c:set var="current_page" value="page_account_list"/>
<div class="wrapper">

<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        ${account.getFullName()}
        <small>Thành viên</small>
      </h1>
      
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		
		<div class="col-md-3">

          <!-- Profile Image -->
          <div class="box box-primary">
            <div class="box-body box-profile">
              <img class="profile-user-img img-responsive img-circle" src="${account.avatar}" alt="User profile picture">

              <h3 class="profile-username text-center">${account.getFullName()}</h3>

              <p class="text-muted text-center">${account.role}</p>
              
              <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Tên tài khoản</b> <a class="pull-right">${account.userName}</a>
                </li>
                <li class="list-group-item">
                  <b>Ngày lập</b> <a class="pull-right"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${account.createdAt}"/></a>
                </li>
                <li class="list-group-item">
                  <b>Tình trạng</b> 
                  <a class="pull-right">
                  	<c:if test="${account.status eq 1}"><span class="label label-success">Hoạt động</span></c:if>
	                <c:if test="${account.status eq 0}"><span class="label label-warning">Khóa</span></c:if>
                  </a>
                </li>
              </ul>
		      <button id="btn-delete-account" type="button" data-toggle="modal" data-target="#modal-delete-account" class="btn btn-danger btn-block"><b>Xóa tài khoản</b></button>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
         
        </div>
		
		
		<div class="col-md-9">
		  <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="${empty result_reset_password ? 'active':''}"><a href="#infomation" data-toggle="tab">Thông tin cá nhân</a></li>
              <li class="${not empty result_reset_password ? 'active':''}"><a href="#reset-password" data-toggle="tab">Bảo mật</a></li>
            </ul>
            <div class="tab-content">
            
              <div class="tab-pane${empty result_reset_password ? ' active':''}" id="infomation">
              
				<form class="form-horizontal" action="${pageContext.request.contextPath}/admin/profile/${account.id}" method="post">
				
				<div class="form-group">
	                  <div class="col-md-12">
				        <c:if test="${result}">
					        <div class="alert alert-success alert-dismissible">
					        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Cập nhật thông tin tài khoản <strong>${account.getFullName()}</strong> thành công.
					        </div>
				         </c:if>
				         <c:if test="${result eq false}">
					        <div class="alert alert-warning alert-dismissible">
				                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Cập nhật thông tin tài khoản <strong>${account.getFullName()}</strong> thất bại.
				              </div>
				         </c:if>
				       </div>
			       </div>
				
				
                  <div class="form-group">
                    <label for="inputFirstName" class="col-sm-2 control-label">Họ</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="inputFirstName" name="account_first_name" value="${account.firstName}" placeholder="Nhập họ">
                    </div>
                    
                    <label for="inputLastName" class="col-sm-2 control-label">Tên</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="inputLastName" name="account_last_name" value="${account.lastName}" placeholder="Nhập tên">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="inputEmail" name="account_email" value="${account.accountProfile.email}" placeholder="Nhập email">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputPhone" class="col-sm-2 control-label">Điện thoại</label>

                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="inputPhone" name="account_phone" value="${account.accountProfile.phone}" placeholder="Nhập số điện thoại">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputAddress" class="col-sm-2 control-label">Địa chỉ</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputAddress" name="account_address" placeholder="Nhập địa chỉ">${account.accountProfile.address}</textarea>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="inputBiography" class="col-sm-2 control-label">Tiểu sử</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputBiography" name="account_biography" placeholder="Nhập tiểu sử">${account.accountProfile.biography}</textarea>
                    </div>
                  </div>
                  
                  <!-- radio -->
              <div class="form-group">
              		<label for="inputSkills" class="col-sm-2 control-label">Giới tính</label>

                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="account_gender" id="optionsMen" value="1" ${account.accountProfile.gender ? 'checked':''}>
	                      Nam
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="account_gender" id="optionsWomen" value="0" ${account.accountProfile.gender eq false ? 'checked':''}>
	                      Nữ
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-6"></div>
              </div>
              
              	  <div class="form-group">
                    <label for="inputBiography" class="col-sm-2 control-label">Quyền</label>

                    <div class="col-sm-10">
                      <select class="form-control" name="account_role">
	                    <option value="ROLE_USER" ${account.role eq 'ROLE_USER' ? 'selected':''}>ROLE_USER</option>
	                    <option value="ROLE_ADMIN" ${account.role eq 'ROLE_ADMIN' ? 'selected':''}>ROLE_ADMIN</option>
	                  </select>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="inputBiography" class="col-sm-2 control-label">Avatar</label>

                    <div id="form-upload" class="col-sm-10">
	                  <input type="hidden" class="form-control" id="account_avatar" name="account_avatar" value="${account.avatar}" placeholder="Avatar">
                      <input type="file" id="file-data" class="form-control-file" name="files[]" aria-describedby="fileHelp">
                      <button type="button" id="btn-upload" class="btn btn-primary"><i class="fa fa-cloud-upload" ></i> Upload</button>
                    </div>
                  </div>
                  
                  <hr/>
                  
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-floppy-o""></i> Lưu</button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.tab-pane -->
              
              <div class="tab-pane${not empty result_reset_password ? ' active':''}" id="reset-password">
                <form class="form-horizontal" action="${pageContext.request.contextPath}/admin/profile/${account.id}/reset-password" method="post">
                  <div class="form-group">
	                  <div class="col-md-12">
				        <c:if test="${result_reset_password}">
					        <div class="alert alert-success alert-dismissible">
					        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Cập nhật mật khẩu tài khoản <strong>${account.getFullName()}</strong> thành công.
					        </div>
				         </c:if>
				         <c:if test="${result_reset_password eq false}">
					        <div class="alert alert-warning alert-dismissible">
				                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Cập nhật mật khẩu tài khoản <strong>${account.getFullName()}</strong> thất bại.
				              </div>
				         </c:if>
				       </div>
			       </div>
                  
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">Mật khẩu hiện tại</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" name="current_password" placeholder="Nhập mật khẩu hiện tại">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">Mật khẩu mới</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" name="new_password" placeholder="Nhập mật khẩu mới">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputComfirmPassword" class="col-sm-3 control-label">Nhập lại</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputComfirmPassword" name="confirm_password" placeholder="Nhập lại mật khẩu">
                    </div>
                  </div>
                  
                  <hr>
                  
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-floppy-o""></i> Lưu</button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.tab-pane -->
              
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- /.nav-tabs-custom -->
		
		</div>
		
		
		
	  </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
    
    <div id="modal-delete-account" class="modal fade">
	  <div class="modal-dialog" role="document">
	  <form action="${pageContext.request.contextPath}/admin/delete-account" method="post">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Xóa tài khoản</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <p>Bạn chắc chắn muốn xóa tài khoản <strong>${account.getFullName()}</strong></p>
	        <input type="hidden" name="id_account" value="${account.id}">
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-danger">Xóa</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
	      </div>
	    </div>
	  </form>
	  </div>
	</div>
    
	</div>
  <!-- /.content-wrapper -->
	
<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>	
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