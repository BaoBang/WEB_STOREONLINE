<%@ page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
  <title>${post.title} | PTiT Shop</title>
  
 <!--  FACEBOOK COMMENT -->
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.10&appId=1733140813646943";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

</head>
<body>

<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

<!-- CONTENT -->
<div class="container content-shop">
  <div class="row">
    <div class="col-md-12">
      <ol class="breadcrumb breadcrumb-shop">
        <li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Trang chủ</a></li>
        <li class="breadcrumb-item active">Tin tức</li>
      </ol>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="post-title">
        <h3>${post.title}</h3>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="post-detail">
        <div class="post-content">${post.content}</div>
      </div>

      <div class="post-comment">
          <h3>BÌNH LUẬN</h3>
          <div class="comment">
          
           <!--  FACEBOOK COMMENT -->
            <div class="fb-comments" data-href="http://localhost:8080/PTiTShop/post/${post.id}/${post.slug}" data-width="100%" data-numposts="5"></div>
            
          </div>
      </div>

    </div>
  </div>

</div>
<!-- END ./CONTENT -->

<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>
</body>
</html>