<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Thể loại | Admin PTiTShop</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_category"></c:set>
<c:set var="current_page" value="page_category_list"></c:set>
<div class="wrapper">

<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Thể loại
        <small>PTiTShop</small>
      </h1>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<div class="col-md-12">
		<div class="box">
            <div class="box-header with-border">
              <h3 class="box-title">Danh sách các thể loại</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table class="table table-bordered">
                <tr>
                  <th style="width: 10px; text-align: center;">ID</th>
                  <th style="width: 10px; text-align: center;">Icon</th>
                  <th style="text-align: center;">Tên</th>
                  <th style="text-align: center;">Đường dẫn</th>
                  <th style="text-align: center;">Mô tả</th>
                  <th style="text-align: center;">ID gốc</th>
                  <th style="text-align: center;">Thứ tự</th>
                  <th style="width: 40px; text-align: center;">Trạng thái</th>
                  <th style="width: 40px; text-align: center;"></th>
                </tr>
                <c:forEach var="c" items="${category_list}">
                <c:if test="${c.parentId eq 0}">
                <tr id="${c.id}">
                  <td style="text-align: center;">${c.id}</td>
                  <td style="text-align: center;"><i class="fa fa-lg ${c.image}"></i></td>
                  <td>${c.name}</td>
                  <td>${c.slug}</td>
                  <td>${c.description}</td>
                  <td style="text-align: center;">${c.parentId}</td>
                  <td style="text-align: center;">${c.position}</td>
                  <td style="text-align: center;">
                  	<c:if test="${c.status eq 1}"><span class="badge bg-green">Công khai</span></c:if>
                  	<c:if test="${c.status eq 0}"><span class="badge bg-yellow">Đã ẩn</span></c:if>
                  </td>
                  <td>
                  	<div class="btn-group-vertical">
	                	<a class="btn btn-info" href="${pageContext.request.contextPath}/admin/edit-category/${c.id}"><i class="fa fa-pencil-square-o"></i></a>
	                	<button type="button" category-name="${c.name}" category-id="${c.id}" class="btn btn-danger btn-delete-post"><i class="fa fa-times"></i></button>
	                </div>
                  </td>
                </tr>
                <c:forEach var="c2" items="${category_list}">
                <c:if test="${c2.parentId eq c.id}">
                <tr id="${c2.id}">
                  <td style="text-align: center;">${c2.id}</td>
                  <td></td>
                  <td>${c2.name}</td>
                  <td>${c2.slug}</td>
                  <td>${c2.description}</td>
                  <td style="text-align: center;">${c2.parentId}</td>
                  <td style="text-align: center;">${c2.position}</td>
                  <td style="text-align: center;">
                  	<c:if test="${c2.status eq 1}"><span class="badge bg-green">Công khai</span></c:if>
                  	<c:if test="${c2.status eq 0}"><span class="badge bg-yellow">Đã ẩn</span></c:if>
                  </td>
                  <td>
                  	<div class="btn-group-vertical">
	                	<a class="btn btn-info" href="${pageContext.request.contextPath}/admin/edit-category/${c2.id}"><i class="fa fa-pencil-square-o"></i></a>
	                	<button type="button" category-name="${c2.name}" category-id="${c2.id}" class="btn btn-danger btn-delete-post"><i class="fa fa-times"></i></button>
	                </div>
                  </td>
                </tr>
                </c:if>
                </c:forEach>
                </c:if>
                </c:forEach>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
		</div>
		
		
	  </div>
      <!-- /.row -->
      
      <div id="modalDeleteCategory" class="modal modal-danger">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close btn-modal-close" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Xác nhận</h4>
              </div>
              <div class="modal-body"></div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline btn-modal-close pull-left" >Hủy</button>
                <button type="button" id="btn-modal-delete" category-id="" class="btn btn-outline">Xóa</button>
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
<script type="text/javascript">
$(document).ready(function(){
	$('.btn-modal-close').click(function(){
		$('#modalDeleteCategory').modal('hide');
	});
	
	$('.btn-delete-post').click(function(){
		var name = $(this).attr('category-name');
		var id = $(this).attr('category-id');
		$('#btn-modal-delete').attr('category-id', id);
		$('.modal-body').html('Bạn chắc chắn muốn xóa thể loại <strong>' + name + '</strong> không?');
		$('#modalDeleteCategory').modal();
	});
	
	$('#btn-modal-delete').click(function(){
		var categoryId = $(this).attr('category-id');
		
		$.ajax({
            url : "${pageContext.request.contextPath}/ajax/delete-caregory-with-ajax",
            type : "get",
            contentType : "application/json;charset=UTF-8",
            dataType:"text",
            data : {
                 category_id:categoryId
            },
            success : function(result) {
                console.log("SUCCESS: ", result);
                if (result == 'true'){
                	$('#modalDeleteCategory').modal('hide');
                	var id = '#' + categoryId;
                	$(id).remove();
                	
                } else {
                	$('.modal-body').html('<p class="text-danger">Xóa thể loại thất bại!</p>');
	                $('#modalDeleteCategory').modal('show');
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
                $('.modal-body').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
                $('#modalDeleteCategory').modal('show');
            }
        });
	});
});
</script>

</body>
</html>