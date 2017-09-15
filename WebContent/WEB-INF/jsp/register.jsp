<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
<title>PTit Shop | Đăng Nhập</title>
</head>
<body>
	<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

	<!-- CONTENT -->
	<div class="container content-shop">
		<div class="row">
			<div class="col-md-12 col-xs-12">
				<div class="col-md-6 col-xs-6 login-card">
					<div class="login-account">
						<h2>Đăng Kí Tài Khoản</h2>
						<div class="login-form">
							<form action="${pageContext.request.contextPath }/register"
								method="get">
								<div class="form-group">
									<label for="userName">Tài khoản</label> <input type="text"
										class="form-control" id="username" name="username"
										placeholder="Nhập vào tên đăng nhập..."><span
										id="user-result"></span>
								</div>
								<div class="form-group">

									<table>
										<tbody>
											<tr>
												<td><label for="fisrtName">Họ</label></td>
												<td><label for="lastName">Tên</label></td>
											</tr>
											<tr>
												<td><input type="text" class="form-control "
													name="firstname" placeholder="Nhập vào họ..."></td>
												<td><input type="text" class="form-control input-name"
													name="lastname" id="lastname" placeholder="Nhập vào tên..."><span
													id="name-result"></span></td>

											</tr>
										</tbody>
									</table>

								</div>
								<div class="form-group">
									<label for="password">Mật Khẩu</label> <input type="password"
										class="form-control" id="password" name="password"
										placeholder="Nhập vào mật khẩu"> <span
										id="password-result"></span>
								</div>

								<div class="form-group">
									<label for="passwordComfirm">Xác nhận mật khẩu</label> <input
										type="password" class="form-control" id="passwordComfirm"
										name="passwordComfirm" placeholder="Xác nhận mật khẩu"><span
										id="password-comfirm-result"></span>
								</div>
								<div class="button-submit">
									<input type="submit" id="btnSubmit" class="btn btn-primary"
										name="btnSubmit" value="Đăng Kí" disabled="disabled">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


	<!-- END CONTENT -->

	<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var x_timer, x_timer2, user_flag = false, password_flag = false, password_comfirm_flag = false, name_flag = false;
							$("#username").keyup(function(e) {
								clearTimeout(x_timer);
								var user_name = $(this).val();
								x_timer = setTimeout(function() {
									check_username_ajax(user_name);
								}, 100);
							});

							function check_username_ajax(user_name) {

								$("#user-result")
										.html(
												'<img src="/PTiTShop/themes/images/ajax-loader.gif" />');
								$
										.ajax({
											type : "GET",
											url : "${pageContext.request.contextPath}/ajax/check-user-name",
											data : {
												username : user_name
											},
											success : function(data) {
												if (data == "available") {
													user_flag = true;
													$("#user-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/available.png\"/>");
												} else {
													user_flag = false;
													$("#user-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
												}
												if (user_flag == true
														&& password_flag == true
														&& name_flag == true
														&& password_comfirm_flag == true) {
													$('#btnSubmit').removeAttr(
															'disabled');
												} else {
													$('#btnSubmit').attr(
															'disabled', true);
												}
											}
										});

							}
							/*****************Check last Name******************/

							$("#lastname").keyup(function(e) {
								clearTimeout(x_timer);
								var last_name = $(this).val();
								x_timer = setTimeout(function() {
									check_name_ajax(last_name);
								}, 100);
							});

							function check_name_ajax(last_name) {

								$("#name-result")
										.html(
												'<img src="/PTiTShop/themes/images/ajax-loader.gif" />');
								$
										.ajax({
											type : "GET",
											url : "${pageContext.request.contextPath}/ajax/check-name",
											data : {
												lastname : last_name
											},
											success : function(data) {
												if (data == "available") {
													name_flag = true;
													$("#name-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/available.png\"/>");
												} else {
													name_flag = false;
													$("#name-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
												}
												if (user_flag == true
														&& password_flag == true
														&& name_flag == true
														&& password_comfirm_flag == true) {
													$('#btnSubmit').removeAttr(
															'disabled');
												} else {
													$('#btnSubmit').attr(
															'disabled', true);
												}
											}
										});

							}

							/** ************* Check password  ************************ */

							$("#password").keyup(function(e) {
								clearTimeout(x_timer);
								clearTimeout(x_timer2);
								var pass_word = $(this).val();
								var password_comfirm = $('#passwordComfirm').val();
								x_timer = setTimeout(function() {
									check_password_ajax(pass_word);
								}, 100);
								x_timer2 = setTimeout(function() {
									check_password_comfirm_ajax(pass_word,
											password_comfirm);
								}, 100);
							});

							function check_password_ajax(pass_word) {

								$("#password-result")
										.html(
												'<img src="/PTiTShop/themes/images/ajax-loader.gif" />');
								$
										.ajax({
											type : "GET",
											url : "${pageContext.request.contextPath}/ajax/check-password",
											data : {
												password : pass_word
											},
											success : function(data) {
												if (data == "available") {
													password_flag = true;
													$("#password-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/available.png\"/>");
												} else {
													password_flag = false;
													$("#password-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
												}
												if (user_flag == true
														&& password_flag == true
														&& name_flag == true
														&& password_comfirm_flag == true) {
													$('#btnSubmit').removeAttr(
															'disabled');
												} else {
													$('#btnSubmit').attr(
															'disabled', true);
												}
											}
										});

							}

							/**
							 * ************* End Check password
							 * ************************
							 */
							/** ************* Check password comfirm ************************ */

							$("#passwordComfirm")
									.keyup(
											function(e) {
												clearTimeout(x_timer);
												var pass_word = $('#password')
														.val();
												var password_comfirm = $(
														'#passwordComfirm')
														.val();
												x_timer = setTimeout(
														function() {
															check_password_comfirm_ajax(
																	pass_word,
																	password_comfirm);
														}, 100);
											});

							function check_password_comfirm_ajax(pass_word,
									password_comfirm) {

								$("#password-comfirm-result")
										.html(
												'<img src="/PTiTShop/themes/images/ajax-loader.gif" />');
								$
										.ajax({
											type : "GET",
											url : "${pageContext.request.contextPath}/ajax/check-password-confirm",
											data : {
												password : pass_word,
												passwordComfirm : password_comfirm
											},
											success : function(data) {
												if (data == "available") {
													password_comfirm_flag = true;
													$(
															"#password-comfirm-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/available.png\"/>");
												} else {
													password_comfirm_flag = false;
													$(
															"#password-comfirm-result")
															.html(
																	"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
												}
												if (user_flag == true
														&& password_flag == true
														&& name_flag == true
														&& password_comfirm_flag == true) {
													$('#btnSubmit').removeAttr(
															'disabled');
												} else {
													$('#btnSubmit').attr(
															'disabled', true);
												}
											}
										});

							}

							/**
							 * ************* End Check password comfirm
							 * ************************
							 */
						});
	</script>
</body>
</html>