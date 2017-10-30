<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Tổng quan | Admin PTiTShop</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page" value="page_dashboard"/>
<div class="wrapper">

<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	
	<!-- Content Header (Page header) -->
	<section class="content-header">
	  <h1>
	    Tổng quan
	    <small>PTiTShop</small>
	  </h1>
	</section>
	    
	<!-- Main content -->
    <section class="content">
	  <!-- Small boxes (Stat box) -->
      <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3> ${totalProduct}</h3>
              <p>SẢN PHẨM</p>
            </div>
            <div class="icon" style="padding: 15px;">
             <!--  <i class="ion ion-bag"></i> -->
             <i class="fa fa-shopping-bag"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/product" class="small-box-footer">Chi tiết <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>${totalOrder}</h3>
              <p>ĐƠN HÀNG</p>
            </div>
            <div class="icon" style="padding: 15px;">
              <i class="fa fa-shopping-cart"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/order-list" class="small-box-footer">Chi tiết <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>${totalAccount}</h3>
              <p>TÀI KHOẢN</p>
            </div>
            <div class="icon" style="padding: 15px;">
              <i class="fa fa-users"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/members" class="small-box-footer">Chi tiết <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>${totalPost}</h3>
              <p>BÀI VIẾT</p>
            </div>
            <div class="icon" style="padding: 15px;">
              <!-- <i class="ion ion-compose"></i> -->
              <i class="fa fa-newspaper-o"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/posts" class="small-box-footer">Chi tiết <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
      </div>
      <!-- /.row -->
      
      <!-- Main row -->
      <div class="row">
      
      
      <div class="col-md-12">
          <div class="box">
            <div class="box-header with-border">
              <h3 class="box-title">Thống kê</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            
            <div class="box-body">
              <div class="row">
              
      			<div class="col-md-12">
		          <div id="chart1"></div>
      			</div>
      
		      	<!-- <div class="col-md-12">
		      		<div id="chart2"></div>
		    	</div> -->
		  </div>
		 </div>
		</div>
		
        <div class="col-md-6">
          <!-- PRODUCT LIST -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Sản phẩm mới thêm gần đây</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <ul class="products-list product-list-in-box">
              <c:forEach var="p" items="${productList}">
                <li class="item">
                  <div class="product-img">
                    <img src="${p.image}" alt="${p.name}">
                  </div>
                  <div class="product-info">
                    <a href="${pageContext.request.contextPath}/admin/edit-product/${p.id}" class="product-title"> ${p.name}
                      	<c:if test="${p.status eq 1}"><span class="label label-success pull-right">Công khai</span></c:if>
                      	<c:if test="${p.status eq 0}"><span class="label label-warning pull-right">Đã ẩn</span></c:if>
                     </a>
                        
                        <span class="product-description">
                          <fmt:formatNumber type="currency" value="${p.price }" />
                        </span>
                  </div>
                </li>
                <!-- /.item -->
              </c:forEach>
              </ul>
            </div>
            <!-- /.box-body -->
            <div class="box-footer text-center">
              <a href="${pageContext.request.contextPath}/admin/product" class="uppercase">Xem tất cả</a>
            </div>
            <!-- /.box-footer -->
          </div>
          <!-- /.box -->
        </div>
        
        <div class="col-md-6">
          <!-- PRODUCT LIST -->
          <div class="box box-danger">
            <div class="box-header with-border">
              <h3 class="box-title">Các bài viết mới thêm gần đây</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <ul class="products-list product-list-in-box">
              <c:forEach var="p" items="${postList}">
                <li class="item">
                  <div class="product-img">
                    <img src="${p.image}" alt="${p.title}">
                  </div>
                  <div class="product-info">
                    <a href="${pageContext.request.contextPath}/admin/edit-post/${p.id}" class="product-title">${p.title}
                    <c:if test="${p.status eq 1}"><span class="label label-success pull-right">Công khai</span></c:if>
	                <c:if test="${p.status eq 0}"><span class="label label-warning pull-right">Đã ẩn</span></c:if>
	                </a>
                      
                        <span class="product-description">
                          ${p.description}
                        </span>
                  </div>
                </li>
                <!-- /.item -->
              </c:forEach>
              </ul>
            </div>
            <!-- /.box-body -->
            <div class="box-footer text-center">
              <a href="${pageContext.request.contextPath}/admin/posts" class="uppercase">Xem tất cả</a>
            </div>
            <!-- /.box-footer -->
          </div>
          <!-- /.box -->
        </div>
        
         <div class="col-md-8">
        	<!-- TABLE: LATEST ORDERS -->
          <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">Đơn hàng mới nhất</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="table-responsive">
                <table class="table no-margin">
                  <thead>
                  <tr>
                    <th style="text-align: center;">#</th>
	                <th style="text-align: center;">Avatar</th>
	                <th style="text-align: center;">Khách hàng</th>
	                <th style="text-align: center;">Tổng giá trị</th>
	                <th style="text-align: center;">Thời gian</th>
	                <th style="text-align: center;">Địa chỉ</th>
	                <th style="text-align: center;">Tình trạng</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="o" items="${orderList}">
                  <tr>
                    <td style="text-align: center;"><a href="${pageContext.request.contextPath}/admin/order-detail/${o.id}">${o.id}</a></td>
	                <td style="text-align: center;"><img width="45px" src="${o.account.avatar}" alt=""></td>
	                <td style="text-align: center;">${o.account.getFullName()}</td>
	                <td style="text-align: center;"><fmt:formatNumber value="${o.total}" type="currency"/></td>
	                <td style="text-align: center;"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${o.createdAt}"/></td>
	                <td style="text-align: center;">${o.address}</td>
	                <td style="text-align: center;">
	                	<c:if test="${o.status eq -1}"><span class="label label-danger">Đã hủy</span></c:if>
	                	<c:if test="${o.status eq 0}"><span class="label label-warning">Chờ duyệt</span></c:if>
	                	<c:if test="${o.status eq 1}"><span class="label label-success">Đã giao hàng</span></c:if>
					</td>
                  </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
              <!-- /.table-responsive -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer text-center">
              <a href="${pageContext.request.contextPath}/admin/order-list" class="uppercase">Xem tất cả</a>
            </div>
            <!-- /.box-footer -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        
        <div class="col-md-4">
              <!-- USERS LIST -->
              <div class="box box-warning">
                <div class="box-header with-border">
                  <h3 class="box-title">Thành viên mới</h3>

                  <div class="box-tools pull-right">
                    <!-- <span class="label label-danger">8 New Members</span> -->
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>
                    </button>
                  </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body no-padding">
                  <ul class="users-list clearfix">
                  <c:forEach var="a" items="${accountList}">
                    <li>
                      <img src="${a.avatar}" alt="${a.getFullName()}">
                      <a class="users-list-name" href="${pageContext.request.contextPath}/admin/profile/${a.id}">${a.lastName}</a>
                      <span class="users-list-date"><fmt:formatDate pattern="dd'/'MM'/'yyyy" value="${a.createdAt}"/></span>
                    </li>
                  </c:forEach>
                  </ul>
                  <!-- /.users-list -->
                </div>
                <!-- /.box-body -->
                <div class="box-footer text-center">
                  <a href="${pageContext.request.contextPath}/admin/members" class="uppercase">Xem tất cả</a>
                </div>
                <!-- /.box-footer -->
              </div>
              <!--/.box -->
            </div>
            <!-- /.col -->
            
            
      
      
      </div>
      <!-- end ./ Main row -->
		
	  </div>	
	</section>
	<!-- end./Main content -->	
</div>
		
<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>
</div>


<!-- /.content-wrapper -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/plugins/charts/light-all.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/themes/plugins/charts/shieldui-all.min.js"></script>

<!-- <link rel="stylesheet" type="text/css" href="http://www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="http://www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script> -->
<script type="text/javascript">
jQuery(function ($) {
    //var data1 = [12, 3, 4, 2, 12, 3, 4, 17, 22, 34, 54, 67];
    var data2 = [3, 9, 12, 14, 22, 32, 45, 12, 67, 45, 55, 7];
    var data3 = [23, 19, 11, 134, 242, 352, 435, 22, 637, 445, 555, 57];
    //var data2 = new Array();
    var data1 = new Array();
    var data4 = new Array();

    <% 
    	String [] arrCategory = (String []) request.getAttribute("arrCategory");
    	int [] arrTotalProduct = (int []) request.getAttribute("arrTotalProduct");
    	for (int i = 0; i < arrCategory.length; i++){
    		%>
    		data4[<%=i%>] = '<%= arrCategory[i]%>';
    		data1[<%=i%>] = <%= arrTotalProduct[i] %>;
    		<%
    	}
    %>
    
    for (var i = 0; i < data1.length; i++){
    	console.log(data4[i] + ": ", data1[i]);
    }
	
    
    $("#chart1").shieldChart({
        exportOptions: {
            image: false,
            print: false
        },
        primaryHeader: {
            text: "Thống kê sản phẩm theo thể loại"
        },
        axisX: {
            categoricalValues: data4
        },
        axisY: {
            title: {
                text: "Thông kê sản phẩm theo thể loại"
            }
        },
        dataSeries: [{
            seriesType: "bar",
            collectionAlias: "Số lượng sản phẩm",
            data: data1
        }]
    });

   /*  $("#chart2").shieldChart({
        exportOptions: {
            image: false,
            print: false
        },
        axisY: {
            title: {
                text: "Break-Down for selected quarter"
            }
        },
        dataSeries: [{
            seriesType: "bar",
            data: data2
        }, {
            seriesType: "bar",
            data: data3
        }]
    }); */
});
</script>
</body>
</html>