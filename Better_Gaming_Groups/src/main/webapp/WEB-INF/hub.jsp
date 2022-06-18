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
	<link href="/css/style.css" rel="stylesheet">
<style>
	body {background-image: url('/img/hub_bg.png'); background-size: cover; background-repeat: no-repeat;}
</style>
<title>Bulletin Board</title>
</head>
<body>
	<div class="d-flex justify-content-end">
		<a href="/logout" class="btn btn-danger my-2 me-2">Logout</a>
	</div>
	<div class="d-flex container flex-column">
		<div class="container justify-content-center align-items-center flex-column d-flex text-light text-center">
		<h1 style="text-decoration: underline;">Welcome to the Bulletin Board</h1> 
		<h2>Step up to the board, <c:out value="${loggedInUser.screenName}"></c:out>, don't be shy!</h2>
		<h3>Adventureres, Assassins, Speedsters, Demi-Gods alike; Anyone you can think of can be found here!</h3>
		<table class="table table-hover table-info opacity-75 table-responsive">
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
					<td><a class="text-danger" href="/members/${member.id}">${member.screenName}</a></td>
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