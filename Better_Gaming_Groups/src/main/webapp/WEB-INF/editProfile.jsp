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
<title>Edit Your Character</title>
</head>
<body>
	<div class="d-flex justify-content-end">
		<a href="/hub" class="btn btn-primary my-2 mx-2">Back to the Hub</a>
		<a href="/logout" class="btn btn-danger my-2 me-2">Logout</a>
	</div>
	<div class="d-flex container justify-content-center align-items-center flex-column">
		<h1>Edit Your Profile</h1>
			<form:form action="/members/update/${editUser.id}" method="put" modelAttribute="editUser" class="form-group col-6">
				<div class="row mb-3">
					<form:label path="screenName">Screen Name:</form:label>
					<div class="col-sm-10">
						<form:errors path="screenName" class="text-danger"/>
						<form:input path="screenName" class="form-control"/>
					</div>
				</div>
				<form:label path="screenName">Screen Name:</form:label>
				<form:errors path="screenName" class="text-danger"/>
				<form:input path="screenName" class="form-control"/>
				<form:label path="welcomeMsg">Welcome Message:</form:label>
				<form:errors path="welcomeMsg" class="text-danger"/>
				<form:input path="welcomeMsg" class="form-control"/>
				<form:label path="preferredGenre">My Preferred Genre:</form:label>
				<form:errors path="preferredGenre" class="text-danger"/>
				<form:input path="preferredGenre" class="form-control"/>
				<form:label path="favGames">My Favorite Games:</form:label>
				<form:errors path="favGames" class="text-danger"/>
				<form:input path="favGames" class="form-control"/>
				<form:label path="additionalGenres">Other genres I like:</form:label>
				<form:errors path="additionalGenres" class="text-danger"/>
				<form:input path="additionalGenres" class="form-control"/>
				<form:label path="aboutMe">About Me:</form:label>
				<form:errors path="aboutMe" class="text-danger"/>
				<form:textarea path="aboutMe" class="form-control"/>
				<form:label path="platform">Platforms I play:</form:label>
				<form:errors path="platform" class="text-danger"/>
				<form:input path="platform" class="form-control"/>
				<input type="submit" class="btn btn-success my-2" value="Update Your Profile">
				<a href="/members/${loggedInUser.id}" class="btn btn-warning">Cancel</a>
			</form:form>
	</div>
</body>
</html>