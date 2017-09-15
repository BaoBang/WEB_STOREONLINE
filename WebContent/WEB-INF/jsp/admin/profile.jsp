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

              <a href="#" class="btn btn-primary btn-block"><b>Follow</b></a>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
         
        </div>
		
		
		<div class="col-md-9">
		  <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#infomation" data-toggle="tab">Infomation</a></li>
              <li><a href="#reset-password" data-toggle="tab">Security</a></li>
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="infomation">
				<form class="form-horizontal">
                  <div class="form-group">
                    <label for="inputFirstName" class="col-sm-2 control-label">First Name</label>
                    <div class="col-sm-4">
                      <input type="email" class="form-control" id="inputFirstName" placeholder="First name">
                    </div>
                    
                    <label for="inputLastName" class="col-sm-2 control-label">Last Name</label>
                    <div class="col-sm-4">
                      <input type="email" class="form-control" id="inputLastName" placeholder="Last name">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputPhone" class="col-sm-2 control-label">Phone</label>

                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="inputPhone" placeholder="Phone">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputAddress" class="col-sm-2 control-label">Address</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputAddress" placeholder="Address"></textarea>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="inputBiography" class="col-sm-2 control-label">Biography</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputBiography" placeholder="Biography"></textarea>
                    </div>
                  </div>
                  
                  <!-- radio -->
              <div class="form-group">
              		<label for="inputSkills" class="col-sm-2 control-label">Gender</label>

                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
	                      Men
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-2">
	                 <!-- radio -->
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">
	                      Women
	                    </label>
	                  </div>
                    </div>
                    
                    <div class="col-sm-6"></div>
              </div>
                  
                 <!--  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                        </label>
                      </div>
                    </div>
                  </div> -->
                  
                  <hr/>
                  
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">Submit</button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.tab-pane -->
              
              <div class="tab-pane" id="reset-password">
                <form class="form-horizontal">
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">Current password</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" placeholder="Current password ...">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputNewPassword" class="col-sm-3 control-label">New Password</label>

                    <div class="col-sm-9">
                      <input type="password" class="form-control" id="inputNewPassword" placeholder="New password ...">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputComfirmPassword" class="col-sm-3 control-label">Comfirm password</label>

                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="inputComfirmPassword" placeholder="Comfirm password ...">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">Submit</button>
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