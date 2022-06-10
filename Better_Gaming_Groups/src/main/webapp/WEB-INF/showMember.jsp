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
</head>
<body>
	<div class="d-flex container flex-column justify-content-center align-items-center col-6">
		<h1><c:out value="${member.screenName}"></c:out></h1>
		<c:choose>
		<c:when test="${member.welcomeMsg!=null}">
			<h3>${member.welcomeMsg}</h3>
		</c:when>
		<c:otherwise>
			<h3>Welcome to my page, I'm new here!</h3>
		</c:otherwise>
		</c:choose>
		<h3>My Preferred Genre: ${member.preferredGenre}</h3>
		<c:choose>
		<c:when test="${member.favGames!=null}">
			<h3>My Favorite Games: ${member.favGames}</h3>
		</c:when>
		<c:otherwise>
			<h3>My Favorite Games: I haven't decided yet!</h3>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${member.additionalGenres!=null}">
			<h3>Genres I also like: ${member.additionalGenres}</h3>
		</c:when>
		<c:otherwise>
			<h3>Genres I also like: I haven't decided yet!</h3>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${member.aboutMe!=null}">
			<h3>About Me! ${member.aboutMe}</h3>
		</c:when>
		<c:otherwise>
			<h3>About Me! Just give me some time, I'll be sure to change this!</h3>
		</c:otherwise>
		</c:choose>
		<h3>Friends I've Made:</h3>
		<%-- <c:choose>
		<c:when test="${member.!=null}">
		<ul>
			<c:forEach var="" items="${}">
				<li>${.member.screenName}</li>
			</c:forEach>
		</ul>
		</c:when>
		<c:otherwise>
			<h3>New Friends are Inbound!</h3>
		</c:otherwise>
		</c:choose> --%>
		<c:choose>
		<c:when test="${member.platform!=null}">
			<h3>Platforms I'm on: ${member.platform}</h3>
		</c:when>
		<c:otherwise>
			<h3>Platforms I'm on: Nothing specific!</h3>
		</c:otherwise>
		</c:choose>
		<c:if test="${member.id==loggedInUser.id}">
			<a href="/members/edit/${member.id}" class="btn btn-warning my-2">Edit Profile</a>
		</c:if>
		<a href="/hub">Back to the Hub</a>
		<a href="/logout">Logout</a>
	</div>
</body>
</html>