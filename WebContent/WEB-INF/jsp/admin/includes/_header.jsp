<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header class="main-header">
    <!-- Logo -->
    <a href="${pageContext.request.contextPath }/admin" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>PS</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Admin</b> PTiT Shop</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
        
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${user.avatar}" class="user-image" alt="${user.getFullName()}">
              <span class="hidden-xs">${user.getFullName()}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="${user.avatar}" class="img-circle" alt="${user.getFullName()}">
                <p>${user.accountProfile.biography}</p>
              </li>
              <!-- Menu Body -->
             
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="${pageContext.request.contextPath}/admin/profile/${user.id}" class="btn btn-default btn-flat">Trang cá nhân</a>
                </div>
                <div class="pull-right">
                  <a href="${pageContext.request.contextPath}/j_spring_security_logout?${_csrf.parameterName}=${_csrf.token}" class="btn btn-default btn-flat">Đăng xuất</a>
                </div>
              </li>
            </ul>
          </li>
         
        </ul>
      </div>
    </nav>
  </header>