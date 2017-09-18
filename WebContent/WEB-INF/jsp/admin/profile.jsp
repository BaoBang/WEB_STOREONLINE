<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Tables</a></li>
        <li class="active">Data tables</li>
      </ol>
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
                  <b>User name</b> <a class="pull-right">${account.userName}</a>
                </li>
                <li class="list-group-item">
                  <b>Created at</b> <a class="pull-right"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${account.createdAt}"/></a>
                </li>
                <li class="list-group-item">
                  <b>Status</b> 
                  <a class="pull-right">
                  	<c:if test="${account.status eq 1}"><span class="label label-success">Actived</span></c:if>
	                <c:if test="${account.status eq 0}"><span class="label label-warning">Block</span></c:if>
                  </a>
                </li>
              </ul>

              <a href="#" class="btn btn-primary btn-block"><b>Profile</b></a>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
         
        </div>
		
		
		<div class="col-md-9">
		  <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="${empty result_reset_password ? 'active':''}"><a href="#infomation" data-toggle="tab">Infomation</a></li>
              <li class="${not empty result_reset_password ? 'active':''}"><a href="#reset-password" data-toggle="tab">Security</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane${empty result_reset_password ? ' active':''}" id="infomation">
				<form class="form-horizontal" action="${pageContext.request.contextPath}/admin/profile/${account.id}" method="post">
                  <div class="form-group">
                    <label for="inputFirstName" class="col-sm-2 control-label">First Name</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="inputFirstName" name="account_first_name" value="${account.firstName}" placeholder="First name">
                    </div>
                    
                    <label for="inputLastName" class="col-sm-2 control-label">Last Name</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="inputLastName" name="account_last_name" value="${account.lastName}" placeholder="Last name">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="inputEmail" name="account_email" value="${account.accountProfile.email}" placeholder="Email">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputPhone" class="col-sm-2 control-label">Phone</label>

                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="inputPhone" name="account_phone" value="${account.accountProfile.phone}" placeholder="Phone">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputAddress" class="col-sm-2 control-label">Address</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputAddress" name="account_address" placeholder="Address">${account.accountProfile.address}</textarea>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="inputBiography" class="col-sm-2 control-label">Biography</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputBiography" name="account_biography" placeholder="Biography">${account.accountProfile.biography}</textarea>
                    </div>
                  </div>
                  
                  <!-- radio -->
              <div class="form-group">
              		<label for="inputSkills" class="col-sm-2 control-label">Gender</label>

                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="account_gender" id="optionsMen" value="1" ${account.accountProfile.gender ? 'checked':''}>
	                      Men
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="account_gender" id="optionsWomen" value="0" ${account.accountProfile.gender eq false ? 'checked':''}>
	                      Women
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-6"></div>
              </div>
                  
                  <hr/>
                  
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
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">SAVE</button>
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
					        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Cập nhật thông tin tài khoản <strong>${account.getFullName()}</strong> thành công.
					        </div>
				         </c:if>
				         <c:if test="${result_reset_password eq false}">
					        <div class="alert alert-warning alert-dismissible">
				                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Cập nhật thông tin tài khoản <strong>${account.getFullName()}</strong> thất bại.
				              </div>
				         </c:if>
				       </div>
			       </div>
                  
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">Current password</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" name="current_password" placeholder="Current password ...">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">New Password</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" name="new_password" placeholder="New password ...">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputComfirmPassword" class="col-sm-3 control-label">Comfirm password</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputComfirmPassword" name="confirm_password" placeholder="Comfirm password ...">
                    </div>
                  </div>
                  
                  <hr>
                  
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">SAVE</button>
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
    
	</div>
  <!-- /.content-wrapper -->
	

<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
</body>
</html>