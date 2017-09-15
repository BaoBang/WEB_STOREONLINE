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
        Category
        <small>Category list</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Admin</a></li>
        <li><a href="#">Category</a></li>
        <li class="active">Category List</li>
      </ol>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<div class="col-md-12">
		<div class="box">
            <div class="box-header with-border">
              <h3 class="box-title">Category List</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table class="table table-bordered">
                <tr>
                  <th style="width: 10px">ID</th>
                  <th style="width: 10px">Icon</th>
                  <th>Name</th>
                  <th>Slug</th>
                  <th>Description</th>
                  <th>Parent Id</th>
                  <th>Position</th>
                  <th style="width: 40px">Status</th>
                  <th style="width: 40px">Action</th>
                </tr>
                <c:forEach var="c" items="${category_list}">
                <c:if test="${c.parentId eq 0}">
                <tr id="${c.id}">
                  <td>${c.id}</td>
                  <td>${c.image}</td>
                  <td>${c.name}</td>
                  <td>${c.slug}</td>
                  <td>${c.description}</td>
                  <td>${c.parentId}</td>
                  <td>${c.position}</td>
                  <td>
                  	<c:if test="${c.status eq 1}"><span class="badge bg-green">Publish</span></c:if>
                  	<c:if test="${c.status eq 0}"><span class="badge bg-yellow">Hidden</span></c:if>
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
                  <td>${c2.id}</td>
                  <td></td>
                  <td>${c2.name}</td>
                  <td>${c2.slug}</td>
                  <td>${c2.description}</td>
                  <td>${c2.parentId}</td>
                  <td>${c2.position}</td>
                  <td>
                  	<c:if test="${c2.status eq 1}"><span class="badge bg-green">Publish</span></c:if>
                  	<c:if test="${c2.status eq 0}"><span class="badge bg-yellow">Hidden</span></c:if>
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
                <button type="button" class="btn btn-outline btn-modal-close pull-left" >Close</button>
                <button type="button" id="btn-modal-delete" category-id="" class="btn btn-outline">Delete</button>
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
	

<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
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