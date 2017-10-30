<%@ page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="//WEB-INF/jsp/includes/_head.jsp"></jsp:include>
<title>PTiTShop | Cá Nhân</title>
</head>
<body>
	<jsp:include page="//WEB-INF/jsp/includes/_header.jsp"></jsp:include>

	<!--CONTENT-->

	<div class="container mt-5 pt-5">
		<div class="row">
			<div class="col-md-12">
				<div class="row card-deck">
					<div class="col-md-4 card profile-img">

						<img src="${user.avatar }" alt="" class="img-fluid pf-img">

					</div>
					<div class="col-md-8 card profile-emp"></div>
				</div>
			</div>
		</div>
		<div class="row row-profile-info">
			<div class="col-md-12">
				<div class="profile row card-deck">
					<div class="col-md-4 pf-tab card">
						<ul class="nav nav-tabs">
							<li class="nav-item change-tab"><a href="#profile-info"
								class="nav-link active" data-toggle="tab" role="tab">Thông Tin cá
									Nhân</a></li>
							<li class="nav-item change-tab"><a href="#profile-password"
								class="nav-link" data-toggle="tab" role="tab">Thay đổi mật
									khẩu</a></li>
						</ul>
					</div>
					<div class="col-md-8 pf-info card">
						<div class="tab-content">
							<div class="tab-pane active" id="profile-info" role="tabpanel">

								<div class="proifle-header">
									<h4>
										<i class="fa fa-address-card-o" aria-hidden="true"></i> Thông
										tin cá nhân <span class="float-md-right"><button
												type="button"  class="btn btn-link btnUpdate"
												>Chỉnh
												sửa</button></span>
									</h4>
								</div>

								<div class="form-profile-info">
									<form role="form" method="POST"
										action="${pageContext.request.contextPath }/profile">
										<div class="form-group">
											<label for="username"><span
												class="glyphicon glyphicon glyphicon-envelope"></span>Tên
												đăng nhập</span></label> <input class="form-control required" minlength="6"
												id="username" name="username" type="text" class="text"
												value="${user.userName }" disabled="disabled"> <input
												name="username" value="${user.userName }" type="hidden" />
										</div>
										<div class="form-group">
											<table>
												<tbody>
													<tr>
														<td><label for="fisrtName">Họ</label></td>
														<td><label for="lastName">Tên</label></td>
													</tr>
													<tr>
														<td><input type="text" class="form-control edit"
															name="firstname" id="firstname"
															placeholder="Nhập vào họ..." value="${user.firstName }"
															disabled="disabled"></td>
														<td><input type="text"
															class="form-control input-name edit" name="lastname"
															id="lastname" placeholder="Nhập vào tên..."
															value="${user.lastName }" disabled="disabled"><span
															id="name-result"></span></td>

													</tr>
												</tbody>
											</table>

										</div>
										<div class="form-group">
											<label>Giới tính:</label> <label class="radio-inline"
												for="gender"> <input id="male" name="gender"
												type="radio" value="1" class="edit" disabled="disabled"
												<c:if test="${user.accountProfile.gender}">checked='checked'</c:if>>
												Nam
											</label> <label class="radio-inline"> <input name="gender"
												id="female" type="radio" value="0" class="edit"
												disabled="disabled"
												<c:if test="${user.accountProfile.gender eq false}" >checked='checked'</c:if>>Nữ
											</label>
										</div>
										<div class="form-group">
											<label for="phone"><span
												class="glyphicon glyphicon-phone"></span>Điện thoại</label> <input
												class=" text digits edit" maxlength="12" id="phone"
												name="phone" type="text" placeholder="Điện thoại"
												value="${user.accountProfile.phone }" disabled="disabled" />
										</div>
										<div class="form-group">
											<label for="address"><span
												class="glyphicon glyphicon glyphicon-envelope "></span> Địa
												chỉ</span></label> <input class="form-control required email edit"
												minlength="6" id="address" name="address" type="text"
												class="text" value="${user.accountProfile.address }"
												disabled="disabled">
										</div>
										<div class="form-group">
											<label for="email"><span
												class="glyphicon glyphicon glyphicon-envelope"></span> Email</span></label>
											<input class="form-control required email text edit"
												minlength="6" id="email" name="email" type="email"
												value="${user.accountProfile.email }" disabled="disabled">
										</div>
										<div class="form-group">
											<label for="biography"><span
												class="glyphicon glyphicon glyphicon-envelope"></span>Giới
												thiệu</span></label>
											<textarea class="form-control required email text edit"
												id="biography" name="biography" row="10" disabled="disabled">${user.accountProfile.biography }</textarea>
										</div>
										<div class="btn-update">
											<button type="submit" name="submit-info" id="update-info"
												style="background-color: #5CB85C;"
												class="btn btn-default btn-success edit" disabled="disabled"
												value="Cập nhật">
												<span class="glyphicon glyphicon-off"></span> Cập nhật
											</button>
										</div>
										<div id="result" style="color: red; text-align: center"></div>
									</form>
								</div>
							</div>
							<div class="tab-pane" id="profile-password" role="tabpanel">
								<div class="proifle-header">
									<h4>
										<i class="fa fa-lock" aria-hidden="true"></i> Thay đổi mật
										khẩu <span class="float-md-right"><button type="button"
												 class="btn btn-link btnUpdate"
												>Chỉnh
												sửa</button></span>
									</h4>
								</div>
								<div class="form-profile-info">
									<form role="form2" method="POST"
										action="${pageContext.request.contextPath }/profile">
										<input type="hidden" id="username-pass" name="username"
											value="${user.userName }">
										<div class="form-group">
											<label class="control-label" for="old-pass"><span
												class="glyphicon glyphicon-user"> </span>Mật khẩu cũ</span> </label> <input
												class="form-control required edit-pass" id="old-pass"
												name="old-pass" type="password" class="text" value=""
												disabled="disabled"> <span id="old-password-result"></span>
										</div>
										<div class="form-group">
											<label class="control-label" for="new-pass"><span
												class="glyphicon glyphicon-user"> </span>Mật khẩu mới</span> </label> <input
												class="form-control required  edit-pass" minlength="6"
												id="new-pass" name="new-pass" type="password" class="text"
												value="" disabled="disabled"> <span
												id="new-password-result"></span>
										</div>
										<div class="form-group">
											<label class="control-label" for="password-comfirm"><span
												class="glyphicon glyphicon-user"> </span>Xác nhận mật khẩu
												mới</span> </label> <input class="form-control required edit-pass"
												minlength="6" id="comfirm-pass" name="password-comfirm"
												type="password" class="text" value="" disabled="disabled">
											<span id="password-comfirm-result"></span>
										</div>

										<div class="btn-update">
											<button type="submit" name="submit-pass" id="update-pass"
												style="background-color: #5CB85C;"
												class="btn btn-default btn-success" value="Cập nhật"
												disabled>
												<span class="glyphicon glyphicon-off"></span> Cập nhật
											</button>
										</div>
										<div id="result" style="color: red; text-align: center"></div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--END CONTENT-->

	<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document).ready(function(){

				$('.btnUpdate').on('click', function(){
					$('.edit-pass').removeAttr('disabled');
					$('.edit').removeAttr('disabled');
					$(this).css('display','none');
				});
				$('.change-tab').on('click',function(){
					$('.edit-pass').attr('disabled', true);
					$('.edit').attr('disabled', true);
					$('.btnUpdate').css('display','block');
				});
		});
		/** ************* Check old password  ************************ */
		var x_timer, x_timer2, old_password_flag = false, password_comfirm_flag = false, new_password_flag = false;
		$("#old-pass").keyup(function(e) {
			clearTimeout(x_timer);
			var old_pass = $(this).val();
			var user_name = $('#username-pass').val();
			x_timer = setTimeout(function() {
				check_old_password_ajax(user_name, old_pass);
			}, 100);
		});
		function check_old_password_ajax(user_name, old_pass) {

			$("#old-password-result").html(
					'<img src="/PTiTShop/themes/images/ajax-loader.gif" />');
			$
					.ajax({
						type : "GET",
						url : "${pageContext.request.contextPath}/ajax/check-old-password",
						data : {
							username : user_name,
							password : old_pass
						},
						success : function(data) {
							if (data == "available") {
								old_password_flag = true;
								$("#old-password-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/available.png\"/>");
							} else {
								old_password_flag = false;
								$("#old-password-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
							}
							if (old_password_flag == true
									&& new_password_flag == true
									&& password_comfirm_flag == true) {
								$('#update-pass').removeAttr('disabled');
							} else {
								$('#update-pass').attr('disabled', true);
							}
						}
					});

		}

		/**
		 * ************* End Check old password
		 * ************************
		 */
		/** ************* Check new password  ************************ */
		$("#new-pass").keyup(function(e) {
			clearTimeout(x_timer);
			clearTimeout(x_timer2);
			var pass_word = $(this).val();
			var pass_word_comfirm = $('#comfirm-pass').val();
			x_timer = setTimeout(function() {
				check_password_ajax(pass_word);
			}, 100);
			x_timer2 = setTimeout(function() {
				check_password_comfirm_ajax(pass_word, pass_word_comfirm);
			}, 100);
		});

		function check_password_ajax(pass_word) {

			$("#new-password-result").html(
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
								new_password_flag = true;
								$("#new-password-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/available.png\"/>");
							} else {
								new_password_flag = false;
								$("#new-password-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
							}
							if (old_password_flag == true
									&& new_password_flag == true
									&& password_comfirm_flag == true) {
								$('#update-pass').removeAttr('disabled');
							} else {
								$('#update-pass').attr('disabled', true);
							}
						}
					});

		}

		/**
		 * ************* End Check new password
		 * ************************
		 */
		/** ************* Check password comfirm ************************ */

		$("#comfirm-pass").keyup(function(e) {
			clearTimeout(x_timer);
			var pass_word = $('#new-pass').val();
			var password_comfirm = $(this).val();
			x_timer = setTimeout(function() {
				check_password_comfirm_ajax(pass_word, password_comfirm);
			}, 100);
		});

		function check_password_comfirm_ajax(pass_word, password_comfirm) {

			$("#password-comfirm-result").html(
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
								$("#password-comfirm-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/available.png\"/>");
							} else {
								password_comfirm_flag = false;
								$("#password-comfirm-result")
										.html(
												"<img src=\"/PTiTShop/themes/images/not-available.png\"/>");
							}
							if (old_password_flag == true
									&& new_password_flag == true
									&& password_comfirm_flag == true) {
								$('#update-pass').removeAttr('disabled');
							} else {
								$('#update-pass').attr('disabled', true);
							}
						}
					});

		}

		/**
		 * ************* End Check password comfirm
		 * ************************
		 */
	</script>
</body>
</html>