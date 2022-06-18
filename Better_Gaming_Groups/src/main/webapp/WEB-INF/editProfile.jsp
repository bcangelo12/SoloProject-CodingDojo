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
<title>Edit Your Character</title>
</head>
<body>
	<div class="d-flex justify-content-end">
		<a href="/hub" class="btn btn-primary my-2 mx-2">Back to the Hub</a>
		<a href="/logout" class="btn btn-danger my-2 me-2">Logout</a>
	</div>
	<div class="d-flex container justify-content-center align-items-center flex-column text-light">
		<h1>Edit Your Profile</h1>
			<form:form action="/members/update/${editUser.id}" method="put" modelAttribute="editUser" class="col-8">
				<div class=" form-group row my-3">
					<form:label path="screenName" class="col-sm-3 col-form-label text-center">Screen Name:</form:label>
					<div class="col-sm-9">
						<form:errors path="screenName" class="text-danger"/>
						<form:input path="screenName" class="form-control"/>
					</div>
				</div>
				<div class="form-group row">
					<form:label path="welcomeMsg" class="col-sm-3 col-form-label text-center">Welcome Message:</form:label>
					<div class="col-sm-9">
						<form:errors path="welcomeMsg" class="text-danger"/>
						<form:input path="welcomeMsg" class="form-control"/>
						
					</div>
				</div>
				<div class="form-group row my-3">
					<form:label path="preferredGenre" class="col-sm-3 col-form-label text-center">My Preferred Genre:</form:label>
					<div class="col-sm-9">
						<form:errors path="preferredGenre" class="text-danger"/>
						<form:input path="preferredGenre" class="form-control"/>
					</div>
				</div>
				<div class="form-group row my-3">
					<form:label path="favGames" class="col-sm-3 col-form-label text-center">My Favorite Games:</form:label>
					<div class="col-sm-9">
						<form:errors path="favGames" class="text-danger"/>
						<form:input path="favGames" class="form-control"/>
					</div>
				</div>
				<div class="form-group row my-3">
					<form:label path="additionalGenres" class="col-sm-3 col-form-label text-center">Other genres I like:</form:label>
					<div class="col-sm-9">
						<form:errors path="additionalGenres" class="text-danger"/>
						<form:input path="additionalGenres" class="form-control"/>
					</div>
				</div>
				<div class="form-group row my-3">
					<form:label path="platform" class="col-sm-3 col-form-label text-center">Platforms I play:</form:label>
					<div class="col-sm-9">
						<form:errors path="platform" class="text-danger"/>
						<form:input path="platform" class="form-control"/>
					</div>
				</div>
				<div class="form-group row my-3">
					<form:label path="aboutMe" class="col-sm-3 col-form-label text-center">About Me:</form:label>
					<div class="col-sm-9">
						<form:errors path="aboutMe" class="text-danger"/>
						<form:textarea path="aboutMe" class="form-control"/>
					</div>
				</div>
				<div class="text-center">
					<input type="submit" class="btn btn-success mx-2" value="Update Your Profile">
					<a href="/members/${loggedInUser.id}" class="btn btn-warning mx-2">Cancel</a>
				</div>
			</form:form>
	</div>
</body>
</html>