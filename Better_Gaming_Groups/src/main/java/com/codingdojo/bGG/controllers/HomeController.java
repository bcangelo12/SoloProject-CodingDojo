package com.codingdojo.bGG.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.codingdojo.bGG.models.LoginUser;
import com.codingdojo.bGG.models.Message;
import com.codingdojo.bGG.models.UpdatingUser;
import com.codingdojo.bGG.models.User;
import com.codingdojo.bGG.services.MessageService;
import com.codingdojo.bGG.services.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private MessageService messageServ;
	
	// Login page
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin",new LoginUser());
		return "index.jsp";
	}
	
	// Login/Reg routes
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
		userServ.register(newUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin",new LoginUser());
			return "index.jsp";
		}
		session.setAttribute("loggedInUser", newUser);
		return "redirect:/hub";
	}
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		userServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser",new User());
			return "index.jsp";
		}
		User loggedInUser = userServ.findByEmail(newLogin.getEmail());
		session.setAttribute("loggedInUser", loggedInUser);
		return "redirect:/hub";
	}
	
	// Home page
	@GetMapping("/hub")
	public String hub(HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser") != null) {
			model.addAttribute("members",userServ.getAllUsers());
			return "hub.jsp";
		}
		return "redirect:/";
	}
	
	// Member page
	@GetMapping("/members/{id}")
	public String showMember(@PathVariable("id") Long id, Model model, HttpSession session, User user, UpdatingUser updatingUser) {
		if(session.getAttribute("loggedInUser")!=null) {
			User current = userServ.findById(id);
			updatingUser = new UpdatingUser();
			updatingUser.setId(current.getId());
			updatingUser.setScreenName(current.getScreenName());
			updatingUser.setPreferredGenre(current.getPreferredGenre());
			updatingUser.setWelcomeMsg(current.getWelcomeMsg());
			updatingUser.setFavGames(current.getFavGames());
			updatingUser.setAdditionalGenres(current.getAdditionalGenres());
			updatingUser.setPlatform(current.getPlatform());
			updatingUser.setAboutMe(current.getAboutMe());
			updatingUser.setMessages(current.getMessages());
			session.setAttribute("currentPage", updatingUser);
			model.addAttribute("member",updatingUser);
			model.addAttribute("messages", messageServ.getAllMessages());
			return "showMember.jsp";
		}
		return "redirect:/";
	}
	
	// Edit Profile Page
	@GetMapping("/members/edit/{id}")
	public String editProfile(@PathVariable("id") Long id, Model model, HttpSession session, UpdatingUser updatingUser) {
		if(session.getAttribute("loggedInUser")!=null) {
			UpdatingUser profile = (UpdatingUser)session.getAttribute("currentPage");
			model.addAttribute("editUser",profile);
			return "editProfile.jsp";
		}
		return "redirect:/";
	}
	
	// Update Profile Page
	@PutMapping("/members/update/{id}")
	public String updateProfile(@Valid @ModelAttribute("editUser") UpdatingUser updatingUser,  BindingResult result, @PathVariable("id") Long id, Model model, User user) {
		if(result.hasErrors()) {
			return "editProfile.jsp";
		} else {
			User almost = userServ.findById(id);
			almost.setScreenName(updatingUser.getScreenName());
			almost.setWelcomeMsg(updatingUser.getWelcomeMsg());
			almost.setPreferredGenre(updatingUser.getPreferredGenre());
			almost.setFavGames(updatingUser.getFavGames());
			almost.setAdditionalGenres(updatingUser.getAdditionalGenres());
			almost.setPlatform(updatingUser.getPlatform());
			almost.setAboutMe(updatingUser.getAboutMe());
			userServ.updateUser(almost);
			return "redirect:/members/{id}";
		}
	}
	
	// New Message
	@GetMapping("/messages/new")
	public String newMessage(@ModelAttribute("message") User user, UpdatingUser updatingUser, Message message, HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser")!=null) {
			User sender = (User)session.getAttribute("loggedInUser");
			model.addAttribute("user",sender);
			UpdatingUser receiver = (UpdatingUser)session.getAttribute("currentPage");
			model.addAttribute("receiver", receiver);
			model.addAttribute("newMessage", new Message());
			return "newMessage.jsp";
		}
		return "redirect:/";
	}
	
	// Create Message
	@PostMapping("/create/message")
	public String createMessage(@Valid @ModelAttribute("newMessage") Message newMessage, BindingResult result, Model model, UpdatingUser updatingUser, HttpSession session) {
		if(result.hasErrors()) {
			return "newMessage.jsp";
		} else {
			UpdatingUser current = (UpdatingUser)session.getAttribute("currentPage");
			messageServ.createMessage(newMessage);
			return "redirect:/members/" + current.getId();
		}
	}
	
	// Edit Message
	@GetMapping("messages/edit/{id}")
	public String editMessage(@PathVariable("id") Long id, Model model, HttpSession session, Message message, UpdatingUser updatingUser) {
		if(session.getAttribute("loggedInUser")!=null) {
			Message editMessage = messageServ.getMessage(id);
			User user = (User)session.getAttribute("loggedInUser");
			if(user.getId()==(editMessage.getUser().getId())) {
				model.addAttribute("editMessage",editMessage);
				return "editMessage.jsp";
			} else {
				UpdatingUser current = (UpdatingUser)session.getAttribute("currentPage");
				return "redirect:/members/" + current.getId();
			}
		}
		return "redirect:/";
	}
	// Update Message
	@PutMapping("/messages/update/{id}")
	public String updateMessage(@Valid @ModelAttribute("editMessage") Message updateMessage, BindingResult result, UpdatingUser updatingUser, HttpSession session) {
		if(result.hasErrors()) {
			return "editMessage.jsp";
		} else {
			UpdatingUser current = (UpdatingUser)session.getAttribute("currentPage");
			messageServ.updateMessage(updateMessage);
			return "redirect:/members/" + current.getId();
		}
	}
	// Delete Message
	@GetMapping("/messages/delete/{id}")
	public String deleteMessage(@PathVariable("id") Long id, HttpSession session, Message message, UpdatingUser updatingUser) {
		if(session.getAttribute("loggedInUser")!=null) {
			Message checkMessage = messageServ.getMessage(id);
			User user = (User)session.getAttribute("loggedInUser");
			if(user.getId()==(checkMessage.getUser().getId())) {
				UpdatingUser current = (UpdatingUser)session.getAttribute("currentPage");
				messageServ.deleteMessage(id);
				return "redirect:/members/" + current.getId();
			} else {
				UpdatingUser current = (UpdatingUser)session.getAttribute("currentPage");
				return "redirect:/members/" + current.getId();
			}
		}
		return "redirect:/";
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
