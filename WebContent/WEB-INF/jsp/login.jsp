<%@ page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<div class="col-md-12">
				<div class="col-md-6 login-card">
					<div class="login-account">
						<h2>Đăng Nhập</h2>
						<!-- /login?error=true -->
						<c:if test="${param.error == 'true'}">
							<div class="alert alert-danger">Tài khoản hoặc mật khẩu
								không đúng.</div>
						</c:if>
						<!--End /login?error=true -->

						<div class="login-form">
							<form name="f" action="${pageContext.request.contextPath}/j_spring_security_check?${_csrf.parameterName}=${_csrf.token}" method="post">
								<div class="form-group">
									<label for="userName">Email</label> 
									<input type="text"
										class="form-control" id="username" name="username"
										aria-describedby="emailHelp" placeholder="Nhập vào email" >
									<small id="emailHelp" class="form-text text-muted">Chúng
										tôi sẽ không chia sẽ tài khoản email của bạn với bất cứ ai.</small>
								</div>
								<div class="form-group">
									<label for="password">Mật Khẩu</label> <input type="password"
										class="form-control" id="password" name="password"
										placeholder="Nhập vào mật khẩu">
								</div>
								<p>
									<label> <a href="${pageContext.request.contextPath }/register">Đăng kí tài khoản?</a>
									</label>
								</p>
								<div class="button-submit">
								<input type="submit" class="btn btn-primary" name="btnSumit"
									value="Đăng Nhập"> <%-- <input type="hidden"
									name="${_csrf.parameterName}" value="${_csrf.token}" /> --%></div>

							</form>
						</div>
					</div>
				</div>

			</div>

		</div>
	</div>


	<!-- END CONTENT -->

	<jsp:include page="//WEB-INF/jsp/includes/_footer.jsp"></jsp:include>
</body>
</html>