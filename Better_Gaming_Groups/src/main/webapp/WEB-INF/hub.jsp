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
<title>The Hub</title>
</head>
<body>
	<div class="d-flex container flex-column">
		<div class="d-flex flex-column justify-content-end"><a href="/logout">Logout</a></div>
		<div class="container justify-content-center align-items-center flex-column d-flex">
		<h1>The Hub</h1>
		<h2>Welcome in <c:out value="${loggedInUser.screenName}"></c:out>!</h2>
		<h3>Find some amazing gamers to connect with!</h3>
		<table class="table table-hover table-dark">
			<thead>
				<tr>
					<th>Screen Name</th>
					<th>Preferred Genre</th>
					<th>About Them</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
				<tr>
					<td><a href="/members/${member.id}">${member.screenName}</a></td>
					<td>${member.preferredGenre}</td>
					<td>${member.aboutMe}</td>
				</tr>
				</c:forEach>	
			</tbody>
		</table>
		<a href="/members/${loggedInUser.id}" class="btn btn-primary my-2">Your Profile</a>
		</div>		
	</div>
</body>
</html>