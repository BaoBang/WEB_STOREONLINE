<%@ page errorPage="//WEB-INF/jsp/error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Bài viết | PTiTShop AdminCP</title>
<%@ include file="//WEB-INF/jsp/admin/includes/_head.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="current_page_parent" value="page_post"/>
<c:set var="current_page" value="page_post_list"/>
<div class="wrapper">
<%@ include file="//WEB-INF/jsp/admin/includes/_header.jsp" %>  
<%@ include file="//WEB-INF/jsp/admin/includes/_sidebar.jsp" %>


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Bài viết
        <small>PTiTShop</small>
      </h1>
     
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
		
		<div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">Danh sách bài viết</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  	<th style="text-align: center;">#</th>
	                <th style="text-align: center;">Hình</th>
	                <th style="text-align: center;">Tiêu đề</th>
	               <!--  <th>Description</th> -->
	                <th style="text-align: center;">Tác giả</th>
	                <th style="text-align: center;">Ngày đăng</th>
	                <th style="text-align: center;">Lần sửa cuối</th>
	                <th style="text-align: center;">Lượt xem</th>
	                <th style="text-align: center;">Tình trạng</th>
	                <th style="text-align: center;"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${result.list}">
                <tr id="${p.id}">
	                <td style="text-align: center;">${p.id}</td>
	                <td style="text-align: center;"><img width="80px" height="60px" src="${p.image}" alt=""></td>
	                <td>${p.title}</td>
	                <%-- <td width="350px">${p.description}</td> --%>
	                <td style="text-align: center;">${p.account.getFullName()}</td>
	                <td style="text-align: center;"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${p.publishDate}"/></td>
	                <td style="text-align: center;"><fmt:formatDate pattern="dd '/' MM '/' yyyy" value="${p.lastEdit}"/></td>
	                <td style="text-align: center;">${p.views}</td>
	                <td style="text-align: center;">
	                	<c:if test="${p.status eq 1}"><span class="label label-success">Công khai</span></c:if>
	                	<c:if test="${p.status eq 0}"><span class="label label-warning">Đã ẩn</span></c:if>
					</td>
	                <td style="text-align: center;">
	                	<div class="btn-group-vertical">
	                		<a class="btn btn-info" href="${pageContext.request.contextPath}/admin/edit-post/${p.id}"><i class="fa fa-pencil-square-o"></i></a>
	                		<button type="button" post-title="${p.title}" post-id="${p.id}" class="btn btn-danger btn-delete-post"><i class="fa fa-times"></i></button>
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
                <li><a href="${pageContext.request.contextPath}/admin/posts?page=${result.currentPage - 1}">&laquo;</a></li>
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
                <li><a href="${pageContext.request.contextPath}/admin/posts?page=${result.currentPage + 1}">&raquo;</a></li>
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
                <button type="button" class="btn btn-outline btn-modal-close pull-left" >Hủy</button>
                <button type="button" id="btn-modal-delete" post-id="" class="btn btn-outline">Xóa</button>
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