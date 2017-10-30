<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>403 | Admin PTiTShop</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<jsp:include page="//WEB-INF/jsp/admin/includes/_head.jsp"></jsp:include>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<jsp:include page="//WEB-INF/jsp/admin/includes/_header.jsp"></jsp:include>
		<jsp:include page="//WEB-INF/jsp/admin/includes/_sidebar.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
		
		<!-- Main content -->
	    <section class="content">
	      <div class="error-page">
	        <h2 class="headline text-yellow"> 403</h2>
	
	        <div class="error-content">
	          <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>
	          <p>
	            We could not find the page you were looking for.
	            Meanwhile, you may <a href="${pageContext.request.contextPath }/admin">return to Admin PTiTShop</a> or try using the search form.
	          </p>
	        </div>
	        <!-- /.error-content -->
	      </div>
	      <!-- /.error-page -->
	    </section>
	    <!-- /.content -->
			
		</div>
		
		
		<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
	</div>
	<!-- /.content-wrapper -->
</body>
</html>