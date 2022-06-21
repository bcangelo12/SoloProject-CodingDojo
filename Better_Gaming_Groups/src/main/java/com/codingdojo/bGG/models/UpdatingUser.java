package com.codingdojo.bGG.models;

import java.util.List;

import javax.persistence.Id;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class UpdatingUser {
	
	@Id
	private Long id;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@NotEmpty(message="A screen name is needed for people to find you!")
	@Size(min=1,message="A screen name must have at least 1 character.")
	private String screenName;
	
	@NotEmpty(message="A preferred gaming genre is needed!")
	private String preferredGenre;
	
	@Size(min=4,message="When editing your Profile Welcome Message, please include at least 4 characters!")
	@Size(max=100,message="Try to keep your Profile Welcome Message a bit shorter! (Less than 50 characters)")
	private String welcomeMsg;
	
	@Size(min=3,message="Please include one of your favorite games!")
	private String favGames;
	
	@Size(min=3,message="Please add additional favorite genres (if you have any)!")
	private String additionalGenres;
	
	@Size(min=3,message="Please tell everyone more about yourself, if you're comfortable!")
	private String aboutMe;
	
	@Size(min=2, message="Let people know your preferred platform!")
	private String platform;
	
	private List<Message> messages;

	public String getScreenName() {
		return screenName;
	}

	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}

	public String getPreferredGenre() {
		return preferredGenre;
	}

	public void setPreferredGenre(String preferredGenre) {
		this.preferredGenre = preferredGenre;
	}

	public String getWelcomeMsg() {
		return welcomeMsg;
	}

	public void setWelcomeMsg(String welcomeMsg) {
		this.welcomeMsg = welcomeMsg;
	}

	public String getFavGames() {
		return favGames;
	}

	public void setFavGames(String favGames) {
		this.favGames = favGames;
	}

	public String getAdditionalGenres() {
		return additionalGenres;
	}

	public void setAdditionalGenres(String additionalGenres) {
		this.additionalGenres = additionalGenres;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	
	
}
