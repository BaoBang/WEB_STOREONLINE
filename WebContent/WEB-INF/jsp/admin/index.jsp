<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Admin | PTiT Shop</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">  

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&amp;subset=latin-ext,vietnamese" rel="stylesheet">

<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.min.css">
<!-- Admin CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">

</head>
<body>
<!-- WRAPPER -->
<div class="wrapper">

  <!-- HEADER -->
  <nav class="navbar navbar-toggleable-md fixed-top navbar-admin">
    <!-- <div class="container"> -->
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fa fa-navicon"></i>
      </button>

      <a id="sibar-toggler" class="navbar-logo" href="#"><img src="../images/logo.png" alt=""></a>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="#"><i class="fa fa-navicon"></i></a>
          </li>
        </ul>
        
        <div class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-user-circle-o"></i> Administrator
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </div>
      </div>
    <!-- </div> -->
  </nav>
  <!-- END./ HEADER -->

<div class="container-fluid">
<div class="row">
  <!-- SIDEBAR -->
    <section id="sidebar" class="sidebar">
      <div class="sidebar-header">
        <h3>Bootstrap Sidebar</h3>
      </div>
      <ul class="sidebar-menu">
        
        <li><a href="#"><i class="fa fa-tachometer"></i> Dashboard</a></li>
        <li class="sub-menu">
          <a href="#"><i class="fa fa-cart-plus"></i> Product <span class="icon-plus">+</span></a>
          <ul >
            <li class="border-none"><a href="#"><i class="fa fa-circle-o"></i> List</a></li>
            <li><a href="#"><i class="fa fa-circle-o"></i> Add</a></li>
            <li><a href="#"><i class="fa fa-circle-o"></i> Remove</a></li>
          </ul>
        </li>
        <li><a href="#"><i class="fa fa-envelope-o"></i> Message</a></li>
        <li><a href="#"><i class="fa fa-gift"></i> Promotion</a></li>
        <li><a href="#"><i class="fa fa-users"></i> Members</a></li>
        <li><a href="#"><i class="fa fa-cogs"></i> Settings</a></li>
      </ul>
    </section>
  <!-- END./ SIDEBAR -->

<div class="col-md-12">

</div>

</div>
</div>
</div>
<!-- END./ WRAPPER -->


<!-- jQuery -->
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap -->
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<!-- Admin -->
<script type="text/javascript" src="../js/admin.js"></script>
</body>
</html>