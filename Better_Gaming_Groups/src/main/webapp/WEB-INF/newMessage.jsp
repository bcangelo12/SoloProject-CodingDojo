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
<style>
	body {background-image: url('/img/hub_bg.png'); background-size: cover; background-repeat: no-repeat;}
</style>
<title>Leave a Message!</title>
</head>
<body>
	<div class="d-flex justify-content-end">
		<a href="/hub" class="btn btn-primary my-2 mx-2">Back to the Hub</a>
		<a href="/logout" class="btn btn-danger my-2 me-2">Logout</a>
	</div>
	<div class="container d-flex justify-content-center align-items-center flex-column text-center text-light">
		<h1>Leave a Message for this Member!</h1>
			<form:form action="/create/message" method="post" modelAttribute="newMessage" class="form-group">
				<form:label path="content">Message Content:</form:label>
				<form:errors path="content" class="text-warning bg-secondary"/>
				<form:input path="content" class="form-control"/>
				<form:input type="hidden" path="user" value="${user.id}" class="form-control"/>
				<form:input type="hidden" path="receiver" value="${receiver.id}" class="form-control"/>
				<input type="submit" class="btn btn-success my-2" value="Leave Your Message!">
			</form:form>
	</div>
</body>
</html>