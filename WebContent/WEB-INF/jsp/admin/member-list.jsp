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
        MEMBER
        <small>Member list</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Admin</a></li>
        <li><a href="#">Member</a></li>
        <li class="active">Member List</li>
      </ol>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<c:forEach var="a" items="${account_list}">
		<div class="col-md-3">
	      <!-- Profile Image -->
          <div class="box box-primary">
            <div class="box-body box-profile">
              <img class="profile-user-img img-responsive img-circle" src="${a.avatar}" alt="User profile picture">
              <h3 class="profile-username text-center">${a.getFullName()}</h3>
              <p class="text-muted text-center">${a.role}</p>
              <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>User name</b> <a class="pull-right">${a.userName}</a>
                </li>
                <li class="list-group-item">
                  <b>Created at</b> <a class="pull-right"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${a.createdAt}"/></a>
                </li>
                <li class="list-group-item">
                  <b>Status</b> 
                  <a class="pull-right">
                  	<c:if test="${a.status eq 1}"><span class="label label-success">Actived</span></c:if>
	                <c:if test="${a.status eq 0}"><span class="label label-warning">Block</span></c:if>
                  </a>
                </li>
              </ul>
              <a href="${pageContext.request.contextPath}/admin/profile/${a.id}" class="btn btn-primary btn-block"><b>Profile</b></a>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
		</div>
		</c:forEach>
		
		
	  </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
    
	</div>
  <!-- /.content-wrapper -->
	

<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
</body>
</html>