package com.codingdojo.bGG.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LoginUser {
	
	@NotEmpty(message="An email is required for registration!")
	@Email(message="Please enter a valid email address!")
	private String email;
	
	@NotEmpty(message="A password is required for registration!")
	@Size(min=8,max=128,message="The password must have at least 8 characters!")
	private String password;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
