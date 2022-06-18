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
	public String showMember(@PathVariable("id") Long id, Model model, HttpSession session) {
		if(session.getAttribute("loggedInUser")!=null) {
			model.addAttribute("member",userServ.findById(id));
			session.setAttribute("currentPage", userServ.findById(id));
			model.addAttribute("messages", messageServ.getAllMessages());
			return "showMember.jsp";
		}
		return "redirect:/";
	}
	
	// Edit Profile Page
	@GetMapping("/members/edit/{id}")
	public String editProfile(@PathVariable("id") Long id, Model model, HttpSession session, User user) {
		if(session.getAttribute("loggedInUser")!=null) {
			User profile = (User)session.getAttribute("currentPage");
			model.addAttribute("editUser",profile);
			return "editProfile.jsp";
		}
		return "redirect:/";
	}
	
	// Update Profile Page
	@PutMapping("/members/update/{id}")
	public String updateProfile(@Valid @PathVariable("id") Long id, @ModelAttribute("editUser") User updateUser,  BindingResult result ) {
		if(result.hasErrors()) {
			return "editProfile.jsp";
		} else {
			//find user
			User foundUser = userServ.findById(id);
			//update fields using request body to found user
			foundUser.setScreenName(updateUser.getScreenName());
			foundUser.setWelcomeMsg(updateUser.getWelcomeMsg());
			foundUser.setPreferredGenre(updateUser.getPreferredGenre());
			foundUser.setFavGames(updateUser.getFavGames());
			foundUser.setAdditionalGenres(updateUser.getAdditionalGenres());
			foundUser.setAboutMe(updateUser.getAboutMe());
			foundUser.setPlatform(updateUser.getPlatform());
			// tricking validation with confirm setter, param not stored in database and will not be saved
			foundUser.setConfirm("secretpassword");
			userServ.updateUser(foundUser);
			return "redirect:/members/{id}";
		}
	}
	
	// New Message
	@GetMapping("/messages/new")
	public String newMessage(@ModelAttribute("message") User user, Message message, HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser")!=null) {
			User sender = (User)session.getAttribute("loggedInUser");
			model.addAttribute("user",sender);
			User receiver = (User)session.getAttribute("currentPage");
			model.addAttribute("receiver", receiver);
			model.addAttribute("newMessage", new Message());
			return "newMessage.jsp";
		}
		return "redirect:/";
	}
	
	// Create Message
	@PostMapping("/create/message")
	public String createMessage(@Valid @ModelAttribute("newMessage") Message newMessage, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "newMessage.jsp";
		} else {
			messageServ.createMessage(newMessage);
			return "redirect:/hub";
		}
	}
	
	// Edit Message
	@GetMapping("messages/edit/{id}")
	public String editMessage(@PathVariable("id") Long id, Model model, HttpSession session, Message message) {
		if(session.getAttribute("loggedInUser")!=null) {
			Message editMessage = messageServ.getMessage(id);
			User user = (User)session.getAttribute("loggedInUser");
			if(user.getId()==(editMessage.getUser().getId())) {
				model.addAttribute("editMessage",editMessage);
				return "editMessage.jsp";
			} else {
				return "redirect:/hub";
			}
		}
		return "redirect:/";
	}
	// Update Message
	@PutMapping("/messages/update/{id}")
	public String updateMessage(@Valid @ModelAttribute("editMessage") Message updateMessage, BindingResult result) {
		if(result.hasErrors()) {
			return "editMessage.jsp";
		} else {
			messageServ.updateMessage(updateMessage);
			return "redirect:/hub";
		}
	}
	// Delete Message
	@GetMapping("/messages/delete/{id}")
	public String deleteMessage(@PathVariable("id") Long id, HttpSession session, Message message) {
		if(session.getAttribute("loggedInUser")!=null) {
			Message checkMessage = messageServ.getMessage(id);
			User user = (User)session.getAttribute("loggedInUser");
			if(user.getId()==(checkMessage.getUser().getId())) {
				messageServ.deleteMessage(id);
				return "redirect:/hub";
			} else {
				return "redirect:/hub";
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
