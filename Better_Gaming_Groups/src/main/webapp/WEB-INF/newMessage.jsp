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
<title>Leave a Message!</title>
</head>
<body>
	<div class="container d-flex justify-content-center align-items-center flex-column">
		<h1>Leave a Message for your Friend!</h1>
			<form:form action="/create/message" method="post" modelAttribute="newMessage" class="form-group">
				<form:label path="content">Message Content:</form:label>
				<form:errors path="content" class="text-danger"/>
				<form:input path="content" class="form-control"/>
				<form:input type="hidden" path="user" value="${user.id}" class="form-control"/>
				<form:input type="hidden" path="receiver" value="${receiver.id}" class="form-control"/>
				<input type="submit" class="btn btn-success my-2" value="Leave Your Message!">
			</form:form>
			<a href="/hub">Back to the Hub</a>
			<a href="/logout">Logout</a>
	</div>
</body>
</html>