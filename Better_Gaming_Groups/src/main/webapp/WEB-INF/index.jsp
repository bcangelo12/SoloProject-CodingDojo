<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Login & Registration Portal</title>
</head>
<body>
	<div class="d-flex container">
		<div class="container justify-content-center align-items-center col-4">
			<h1>Register Your Account</h1>
			<form:form action="/register" methods="post" modelAttribute="newUser" class="form-group">
				<form:label path="firstName">First Name:</form:label>
				<form:errors path="firstName" class="text-danger"/>
				<form:input path="firstName" class="form-control"/>
				<form:label path="lastName">Last Name:</form:label>
				<form:errors path="lastName" class="text-danger"/>
				<form:input path="lastName" class="form-control"/>
				<form:label path="screenName">Screen Name:</form:label>
				<form:errors path="screenName" class="text-danger"/>
				<form:input path="screenName" class="form-control"/>
				<form:label path="email">Email:</form:label>
				<form:errors path="email" class="text-danger"/>
				<form:input path="email" class="form-control"/>
				<form:label path="preferredGenre">Preferred Genre:</form:label>
				<form:errors path="preferredGenre" class="text-danger"/>
				<form:input path="preferredGenre" class="form-control"/>
				<form:label path="password">Password:</form:label>
				<form:errors path="password" class="text-danger"/>
				<form:password path="password" class="form-control"/>
				<form:label path="confirm">Confirm:</form:label>
				<form:errors path="confirm" class="text-danger"/>
				<form:password path="confirm" class="form-control"/>
				<input type="submit" value="Register" class="btn btn-success my-2">
			</form:form>
		</div>
	<div class="container justify-content-center align-items-center col-4">
		<h1>Login</h1>
		<form:form action="/login" method="post" modelAttribute="newLogin" class="form-group">
			<form:label path="email">Email:</form:label>
			<form:errors path="email" class="text-danger"/>
			<form:input path="email" class="form-control"/>
			<form:label path="password">Password:</form:label>
			<form:errors path="password" class="text-danger"/>
			<form:password path="password" class="form-control"/>
			<input type="submit" value="Login" class="btn btn-primary my-2">
		</form:form>
	</div>
	</div>
</body>
</html>