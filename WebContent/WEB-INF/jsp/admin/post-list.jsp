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
        POST
        <small>Post list</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Admin</a></li>
        <li><a href="#">Post</a></li>
        <li class="active">Post list</li>
      </ol>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">Post list</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  	<th>ID</th>
	                <th>Image</th>
	                <th>Title</th>
	               <!--  <th>Description</th> -->
	                <th>Author</th>
	                <th>Publish Date</th>
	                <th>Last Edit</th>
	                <th>View</th>
	                <th>Status</th>
	                <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${result.list}">
                <tr id="${p.id}">
	                <td>${p.id}</td>
	                <td><img width="80px" height="60px" src="${p.image}" alt=""></td>
	                <td>${p.title}</td>
	                <%-- <td width="350px">${p.description}</td> --%>
	                <td>${p.account.getFullName()}</td>
	                <td><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${p.publishDate}"/></td>
	                <td><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${p.lastEdit}"/></td>
	                <td>${p.views}</td>
	                <td>
	                	<c:if test="${p.status eq 1}"><span class="label label-success">Publish</span></c:if>
	                	<c:if test="${p.status eq 0}"><span class="label label-warning">Hidden</span></c:if>
					</td>
	                <td>
	                	<div class="btn-group-vertical">
	                		<a class="btn btn-info" href="${pageContext.request.contextPath}/admin/edit-post/${p.id}"><i class="fa fa-pencil-square-o"></i></a>
	                		<button type="button" post-title="${p.title}" post-id="${p.id}" class="btn btn-danger btn-delete-post"><i class="fa fa-times"></i></button>
	                	</div>
	                </td>
                </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                	<th>ID</th>
	                <th>Image</th>
	                <th>Title</th>
	                <!-- <th>Description</th> -->
	                <th>Author</th>
	                <th>Publish Date</th>
	                <th>Last Edit</th>
	                <th>View</th>
	                <th>Status</th>
	                <th>Action</th>
                </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
            
           <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">&laquo;</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">&raquo;</a></li>
              </ul>
            </div>
            
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
	
<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
<!-- page script -->
<script>
$(document).ready(function(){
	$('.btn-modal-close').click(function(){
		$('#modalDeletePost').modal('hide');
	});
	
	$('.btn-delete-post').click(function(){
		var title = $(this).attr('post-title');
		var id = $(this).attr('post-id');
		$('#btn-modal-delete').attr('post-id', id);
		$('.modal-body').html('Bạn chắc chắn muốn xóa bài viết <strong>' + title + '</strong> không?');
		$('#modalDeletePost').modal();
	});
	
	$('#btn-modal-delete').click(function(){
		var postId = $(this).attr('post-id');
		
		$.ajax({
            url : "${pageContext.request.contextPath}/ajax/delete-post-with-ajax",
            type : "get",
            contentType : "application/json;charset=UTF-8",
            dataType:"text",
            data : {
                 post_id:postId
            },
            success : function(result) {
                console.log("SUCCESS: ", result);
                if (result == 'true'){
                	$('#modalDeletePost').modal('hide');
                	var id = '#' + postId;
                	$(id).remove();
                	
                } else {
                	$('.modal-body').html('<p class="text-danger">Xóa bài viết thất bại!</p>');
	                $('#modalDeletePost').modal('show');
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
                $('.modal-body').html('<p class="text-danger">Đã có lỗi xảy ra!</p>');
                $('#modalDeletePost').modal('show');
            }
        });
	});
});
</script>


</body>
</html>