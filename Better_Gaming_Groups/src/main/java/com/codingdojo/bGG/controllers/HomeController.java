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
import com.codingdojo.bGG.models.User;
import com.codingdojo.bGG.services.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userServ;
	
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
		}
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
			return "showMember.jsp";
		}
		return "redirect:/";
	}
	
	// Edit Profile Page
	@GetMapping("/members/edit/{id}")
	public String editProfile(@PathVariable("id") Long id, Model model, HttpSession session, User user) {
		if(session.getAttribute("loggedInUser")!=null) {
			User profile = (User)session.getAttribute("loggedInUser");
			model.addAttribute("user",profile);
			return "editProfile.jsp";
		}
		return "redirect:/";
	}
	
	@PutMapping("/members/update/{id}")
	public String updateProfile(@Valid @PathVariable("id") @ModelAttribute("editProfile") User updateUser, BindingResult result) {
		if(result.hasErrors()) {
			return "editProfile.jsp";
		} else {
			userServ.updateUser(updateUser);
			return "redirect:/hub";
		}
	}
}
