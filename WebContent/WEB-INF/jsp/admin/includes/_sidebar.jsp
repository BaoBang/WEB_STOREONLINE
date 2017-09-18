<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="${pageContext.request.contextPath}/themes/admin/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Alexander Pierce</p>
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- search form 
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">Bảng hoạt động chính</li>
         <li class="treeview">
          <a href="${pageContext.request.contextPath}/admin/categories">
            <i class="fa fa-bars"></i>
            <span>Thể loại</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath}/admin/add-new-category"><i class="fa fa-circle-o"></i> Thêm thể loại</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-circle-o"></i> Danh sách thể loại</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-university" aria-hidden="true"></i>
            <span>Hãng sản xuất</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/add-brand"><i class="fa fa-circle-o"></i>Thêm hãng</a></li>
            <li><a href="${pageContext.request.contextPath }/admin/brand"><i class="fa fa-circle-o"></i>Danh sách hãng</a></li>
          </ul>
        </li>
         <li class="treeview">
          <a href="#">
           <i class="fa fa-scribd" aria-hidden="true"></i>
            <span>Sản phẩm</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/add-product"><i class="fa fa-circle-o"></i>Thêm sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath }/admin/product"><i class="fa fa-circle-o"></i>Danh sách sản phẩm</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>Đơn hàng</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="../charts/chartjs.html"><i class="fa fa-circle-o"></i> ChartJS</a></li>
            <li><a href="../charts/morris.html"><i class="fa fa-circle-o"></i> Morris</a></li>
            <li><a href="../charts/flot.html"><i class="fa fa-circle-o"></i> Flot</a></li>
            <li><a href="../charts/inline.html"><i class="fa fa-circle-o"></i> Inline charts</a></li>
          </ul>
        </li>
         <li class="treeview">
          <a href="#">
            <i class="fa fa-diamond" aria-hidden="true"></i>
            <span>Ưu đãi</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/add-promotion"><i class="fa fa-circle-o"></i>Thêm ưu đãi</a></li>
            <li><a href="${pageContext.request.contextPath }/admin/promotion"><i class="fa fa-circle-o"></i>Danh sách ưu đãi</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="${pageContext.request.contextPath}/admin/posts">
            <i class="fa fa-newspaper-o"></i>
            <span>Bài viết</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath}/admin/add-new-post"><i class="fa fa-circle-o"></i> Viết bài mới</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/posts"><i class="fa fa-circle-o"></i> Danh sách bài viết</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="${pageContext.request.contextPath}/admin/members">
            <i class="fa fa-users"></i> <span>Thành viên</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath}/admin/add-new-account"><i class="fa fa-circle-o"></i> Thêm thành viên</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/members"><i class="fa fa-circle-o"></i> Danh sách thành viên</a></li>
          </ul>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>