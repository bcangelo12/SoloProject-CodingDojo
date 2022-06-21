<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Character Sheet</title>
<style>
	body {background-image: url('/img/hub_bg.png'); background-size: cover; background-repeat: no-repeat;}
</style>
</head>
<body>
	<div class="d-flex justify-content-end">
		<a href="/hub" class="btn btn-primary my-2 mx-2">Back to the Hub</a>
		<a href="/logout" class="btn btn-danger my-2 me-2">Logout</a>
	</div>
	<div class="d-flex container flex-column justify-content-center align-items-center col-6 text-light">
		<h1><c:out value="${member.screenName}"></c:out></h1>
		<c:choose>
		<c:when test="${member.welcomeMsg!=null}">
			<h3>${member.welcomeMsg}</h3>
		</c:when>
		<c:otherwise>
			<h3>Welcome to my page, I'm new here!</h3>
		</c:otherwise>
		</c:choose>
		<div class="d-flex justify-content-center text-center my-2">
			<div>
				<h3 class="mt-2 mx-5" style="text-decoration: underline;">My Preferred Genre</h3>
				<h3 class="mb-5">${member.preferredGenre}</h3>
				<c:choose>
				<c:when test="${member.additionalGenres!=null}">
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">Genres I also like</h3>
					<h3 class="mb-3">${member.additionalGenres}</h3>
				</c:when>
				<c:otherwise>
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">Genres I also like:</h3> 
					<h3 class="mb-3">I haven't decided yet!</h3>
				</c:otherwise>
				</c:choose>
			</div>
			<div>
				<c:choose>
				<c:when test="${member.favGames!=null}">
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">My Favorite Games</h3>
					<h3 class="mb-5">${member.favGames}</h3>
				</c:when>
				<c:otherwise>
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">My Favorite Games</h3>
					<h3 class="mb-5">I haven't decided yet!</h3>
				</c:otherwise>
				</c:choose>			
				<c:choose>
				<c:when test="${member.platform!=null}">
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">Platforms I'm on</h3>
					<h3 class="mb-3">${member.platform}</h3>
				</c:when>
				<c:otherwise>
					<h3 class="mt-2 mx-5" style="text-decoration: underline;">Platforms I'm on</h3>
					<h3 class="mb-3">Nothing specific!</h3>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		<c:choose>
		<c:when test="${member.aboutMe!=null}">
			<h3 style="text-decoration: underline;">About Me!</h3>
			<h4 class="mb-5 bg-secondary">${member.aboutMe}</h4>
		</c:when>
		<c:otherwise>
			<h3 style="text-decoration: underline;">About Me! Just give me some time, I'll be sure to change this!</h3>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${member.messages!=null}">
		<h3>Messages left by friendly people!</h3>
		<table class="table table-hover table-info table-bordered text-center align-items-center justify-content-center">
			<thead>
				<tr>
					<th>Message</th>
					<th>Left By:</th>
					<th>Actions:</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="message" items="${messages}">
				<c:if test="${member.id==message.receiver}">
				<tr>
					<td>${message.content}</td>
					<td class="w-25">${message.user.screenName}</td>
					<c:choose>
					<c:when test="${loggedInUser.id==message.user.id}">
					<td class="w-25">
						<a href="/messages/edit/${message.id}" class="btn btn-warning mx-2">Edit</a>
						<a href="/messages/delete/${message.id}" class="btn btn-danger">Delete</a>
					</td>
					</c:when>
					<c:otherwise>
					<td>Sorry, no Actions for you!</td>
					</c:otherwise>
					</c:choose>
				</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
		</c:when>
		<c:otherwise>
			<h3>No messages yet!</h3>
		</c:otherwise>
		</c:choose>
		<c:if test="${member.id!=loggedInUser.id}">
			<a href="/messages/new" class="btn btn-info my-2">Leave A Message!</a>
		</c:if>
		<c:if test="${member.id==loggedInUser.id}">
			<a href="/members/edit/${member.id}" class="btn btn-warning my-2">Edit Profile</a>
		</c:if>
	</div>
</body>
</html>