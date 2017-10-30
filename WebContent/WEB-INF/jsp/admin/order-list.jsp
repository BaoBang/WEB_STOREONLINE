<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Đơn hàng| Admin PTiTShop</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_order"/>
<c:set var="current_page" value="page_order_list"/>
<div class="wrapper">
<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>

 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
       	Đơn hàng
        <small>PTiTShop</small>
      </h1>
     
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">Danh sách đơn hàng</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  	<th style="text-align: center;">#</th>
	                <th style="text-align: center;">Avatar</th>
	                <th style="text-align: center;">Khách hàng</th>
	                <th style="text-align: center;">Tổng giá trị</th>
	                <th style="text-align: center;">Thời gian</th>
	                <th style="text-align: center;">Địa chỉ</th>
	                <th style="text-align: center;">Tình trạng</th>
	                <th style="text-align: center;"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${result.list}">
                <tr>
	                <td style="text-align: center;" width="15px;">${o.id}</td>
	                <td style="text-align: center;" width="90px;"><img width="80px" src="${o.account.avatar}" alt=""></td>
	                <td style="text-align: center;">${o.account.getFullName()}</td>
	                <td style="text-align: center;"><fmt:formatNumber value="${o.total}" type="currency"/></td>
	                <td style="text-align: center;"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${o.createdAt}"/></td>
	                <td width="300px;">${o.address}</td>
	                <td style="text-align: center;" width="35px;">
	                	<c:if test="${o.status eq -1}"><span class="label label-danger">Đã hủy</span></c:if>
	                	<c:if test="${o.status eq 0}"><span class="label label-warning">Chờ duyệt</span></c:if>
	                	<c:if test="${o.status eq 1}"><span class="label label-success">Đã giao hàng</span></c:if>
					</td>
	                <td style="text-align: center;" width="10px;">
	                	<div class="btn-group-vertical">
	                		<a class="btn btn-info" href="${pageContext.request.contextPath}/admin/order-detail/${o.id}"><i class="fa fa-eye"></i></a>
	                	</div>
	                </td>
                </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- /.box-body -->
            
           <c:if test="${result.totalPage gt 1}">
           <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
              <c:if test="${result.currentPage gt 1}">
                <li><a href="#">&laquo;</a></li>
               </c:if>
              <c:forEach var="p" begin="${1}" end="${result.currentPage}">
              <c:if test="${p lt result.currentPage}">
                <li><a href="${pageContext.request.contextPath}/admin/posts?page=${p}">${p}</a></li>
              </c:if>
              </c:forEach>
                <li class="active"><a>${result.currentPage}</a></li>
                
             <c:forEach var="p" begin="${result.currentPage}" end="${result.totalPage}">
			 <c:if test="${p gt result.currentPage}">
                <li><a href="${pageContext.request.contextPath}/admin/posts?page=${p}">${p}</a></li>
             </c:if>
             </c:forEach>
               
               <c:if test="${result.currentPage lt result.totalPage}">
                <li><a href="#">&raquo;</a></li>
               </c:if>
              </ul>
            </div>
           </c:if>
            
            
            
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
		
	  </div>
      <!-- /.row -->
      
        <div id="modalDeletePost" class="modal modal-danger">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close btn-modal-close" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Xác nhận</h4>
              </div>
              <div class="modal-body"></div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline btn-modal-close pull-left" >Close</button>
                <button type="button" id="btn-modal-delete" post-id="" class="btn btn-outline">Delete</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      
    </section>
    <!-- /.content -->
    
	</div>
  <!-- /.content-wrapper -->
	
<%@ include file="//WEB-INF/jsp/admin/includes/_footer.jsp" %>	
</body>
</html>