<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Add new category | Admin</title>
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
        Data Tables
        <small>advanced tables</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Admin</a></li>
        <li><a href="#">Category</a></li>
        <li class="active">Add new category</li>
      </ol>
    </section>

	
	<!-- Main content -->
    <section class="content">
      <div class="row">
      
       <div class="col-md-12">
        <c:if test="${not empty result and result}">
	        <div class="alert alert-success alert-dismissible">
	        	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	        	<h4><i class="icon fa fa-check"></i> Thành công!</h4> Thêm thể loại <strong>${category.name}</strong> thành công.
	        </div>
         </c:if>
         <c:if test="${not empty result and result eq false}">
	        <div class="alert alert-warning alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-warning"></i> Thất bại!</h4> Thêm thể loại <strong>${category.name}</strong> thất bại.
              </div>
         </c:if>
        </div>
		
		<div class="col-md-12">
		
		<!-- general form elements disabled -->
          <div class="box box-primary">
              <form role="form" action="${pageContext.request.contextPath}/admin/edit-category/${category.id}" method="post">
            <div class="box-header with-border">
              <h3 class="box-title">Add new category</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              
                 <!-- text input -->
                <div class="form-group${((not empty errors) and (not empty errors.name)) ? ' has-warning':''}">
                  <label>Title</label>
                  <input type="text" name="category_name" value="${category.name}" class="input-lg form-control${((not empty errors) and (not empty errors.name)) ? ' form-control-warning':''}" placeholder="Enter title ..." required>
                  <c:if test="${(not empty errors) and (not empty errors.name)}">
              	  <small class="form-text text-warning">${errors.name}</small>
                  </c:if>
                </div>
                
                <div class="form-group${((not empty errors) and (not empty errors.slug)) ? ' has-warning':''}">
                  <label>Slug</label>
                  <input type="text" name="category_slug" value="${category.slug}" class="form-control${((not empty errors) and (not empty errors.slug)) ? ' form-control-warning':''}" placeholder="Enter slug ..." required >
                  <c:if test="${(not empty errors) and (not empty errors.slug)}">
                  <small class="form-text text-warning">${errors.slug}</small>
                  </c:if>
                </div>

                <!-- textarea -->
                <div class="form-group${((not empty errors) and (not empty errors.description)) ? ' has-warning':''}">
                  <label>Description</label>
                  <textarea name="category_description" class="form-control${((not empty errors) and (not empty errors.description)) ? ' form-control-warning':''}" rows="3" placeholder="Enter description ..." required>${category.description}</textarea>
                  <c:if test="${(not empty errors) and (not empty errors.description)}">
	              <small class="form-text text-warning">${errors.description}</small>
	              </c:if>
                </div>
                
                <!-- select -->
                <div class="form-group">
                  <label>Parent</label>
                  <select name="category_parent_id" class="form-control">
                    <option value="0">Gốc</option>
                    <c:forEach var="c" items="${category_list}">
                    <c:if test="${c.parentId eq 0}">
                    <option value="${c.id}" ${category.parentId eq c.id ? 'selected':''}>${c.name}</option>
                    </c:if>
                    </c:forEach>
                  </select>
                </div>

				<c:if test="${category.parentId eq 0}">
                <div class="form-group">
                  <label for="categoryImage">Image</label>
                  <textarea id="categoryImage" name="category_image" rows="1" class="form-control">${category.image}</textarea>
                  <button type="button" class="btn btn-primary">${category.image} More...</button>
                  <p class="help-block">Example block-level help text here.</p>
                </div>
				</c:if>


                <!-- radio -->
                <div class="form-group">
                  <label>Status</label>
                 
                  <div class="radio">
                    <label>
                      <input type="radio" name="category_status" value="1" ${category.status eq 1 ? 'checked':''}>
                      <span class="badge bg-green">Publish</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="category_status" value="0" ${category.status eq 0 ? 'checked':''}>
                      <span class="badge bg-yellow">Hidden</span>
                    </label>
                  </div>
                   <c:if test="${(not empty errors) and (not empty errors.status)}">
                  <small class="form-text text-warning">${errors.status}</small>
                  </c:if>
                </div>


            </div>
            <!-- /.box-body -->
			  <div class="box-footer text-center">
	            <button type="submit" class="btn btn-lg btn-primary"><i class="fa fa-floppy-o"></i> SAVE</button>
	          </div>
           </form>
          </div>
          <!-- /.box -->
		
		
		</div>
		
		
	  </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
    
	</div>
  <!-- /.content-wrapper -->
	

<jsp:include page="//WEB-INF/jsp/admin/includes/_footer.jsp"></jsp:include>
<script type="text/javascript">

</script>

</body>
</html>