<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="${user.avatar}" class="img-circle" alt="${user.getFullName()}">
        </div>
        <div class="pull-left info">
          <p>${user.getFullName()}</p>
          <a><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">Bảng hoạt động chính</li>
        
         <li class="treeview ${current_page eq 'page_dashboard' ? 'active':''}">
          <a href="${pageContext.request.contextPath}/admin">
            <i class="fa fa-tachometer" aria-hidden="true"></i>
            <span>Tổng quan</span>
          </a>
         </li>
         
         <li class="treeview ${current_page_parent eq 'page_category' ? 'active':''}">
          <a href="${pageContext.request.contextPath}/admin/categories">
            <i class="fa fa-bars"></i>
            <span>Thể loại</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_category' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/add-new-category"><i class="fa fa-circle-o"></i> Thêm thể loại</a></li>
            <li class="${current_page eq 'page_category_list' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-circle-o"></i> Danh sách thể loại</a></li>
          </ul>
        </li>
        <li class="treeview ${current_page_parent eq 'page_brand' ? 'active':''}">
          <a href="#">
            <i class="fa fa-university" aria-hidden="true"></i>
            <span>Hãng sản xuất</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_brand' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/add-brand"><i class="fa fa-circle-o"></i>Thêm hãng</a></li>
            <li class="${current_page eq 'page_brand_list' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/brand"><i class="fa fa-circle-o"></i>Danh sách hãng</a></li>
          </ul>
        </li>
         <li class="treeview ${current_page_parent eq 'page_product' ? 'active':''}">
          <a href="#">
           <i class="fa fa-shopping-bag" aria-hidden="true"></i>
            <span>Sản phẩm</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_product' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/add-product"><i class="fa fa-circle-o"></i>Thêm sản phẩm</a></li>
            <li class="${current_page eq 'page_product_list' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/product"><i class="fa fa-circle-o"></i>Danh sách sản phẩm</a></li>
          </ul>
        </li>
        <li class="treeview ${current_page_parent eq 'page_order' ? 'active':''}">
          <a href="${pageContext.request.contextPath }/admin/order-list">
            <i class="fa fa-shopping-cart"></i>
            <span>Đơn hàng</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_order_list' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/order-list"><i class="fa fa-circle-o"></i> Danh sách đơn hàng</a></li>
          </ul>
        </li>
         <li class="treeview ${current_page_parent eq 'page_promotion' ? 'active':''}">
          <a href="#">
            <i class="fa fa-bullhorn" aria-hidden="true"></i>
            <span>Khuyến mãi</span>
             <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_promotion' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/add-promotion"><i class="fa fa-circle-o"></i>Thêm khuyến mãi</a></li>
            <li class="${current_page eq 'page_promotion_list' ? 'active':''}"><a href="${pageContext.request.contextPath }/admin/promotion"><i class="fa fa-circle-o"></i>Danh sách khuyến mãi</a></li>
          </ul>
        </li>
        <li class="treeview ${current_page_parent eq 'page_post' ? 'active':''}">
          <a href="${pageContext.request.contextPath}/admin/posts">
            <i class="fa fa-newspaper-o"></i>
            <span>Bài viết</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_post' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/add-new-post"><i class="fa fa-circle-o"></i> Viết bài mới</a></li>
            <li class="${current_page eq 'page_post_list' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/posts"><i class="fa fa-circle-o"></i> Danh sách bài viết</a></li>
          </ul>
        </li>
        <li class="treeview ${current_page_parent eq 'page_account' ? 'active':''}">
          <a href="${pageContext.request.contextPath}/admin/members">
            <i class="fa fa-users"></i> <span>Thành viên</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="${current_page eq 'page_add_new_account' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/add-new-account"><i class="fa fa-circle-o"></i> Thêm thành viên</a></li>
            <li class="${current_page eq 'page_account_list' ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/members"><i class="fa fa-circle-o"></i> Danh sách thành viên</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="${pageContext.request.contextPath}/" target="_blank">
            <i class="fa fa-external-link" aria-hidden="true"></i>
            <span>PTiT Shop</span>
          </a>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>