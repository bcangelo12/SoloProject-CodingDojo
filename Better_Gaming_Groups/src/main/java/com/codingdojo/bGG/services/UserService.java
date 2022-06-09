package com.codingdojo.bGG.services;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.bGG.models.LoginUser;
import com.codingdojo.bGG.models.User;
import com.codingdojo.bGG.repositories.UserRepository;


@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepo;
	
	public List<User> getAllUsers() {
		return userRepo.findAll();
	}
	
	public User findById(Long id) {
		return userRepo.findById(id).orElse(null);
	}
	
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	public User updateUser(User updateUser) {
		return userRepo.save(updateUser);
	}
	
	public void deleteUser(Long id) {
		userRepo.deleteById(id);
	}
	
	
	// Login/Reg methods
	public User register(User newUser, BindingResult result) {
		if(userRepo.findByEmail(newUser.getEmail())!=null) {
			result.rejectValue("email", "Unique", "Email is already in use, please try another!");
		}
		if(!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm", "Mismatch", "Confirmation password must match password!");
		}
		if(result.hasErrors()) {
			return null;
		} else {
			String hashedPass = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashedPass);
			return userRepo.save(newUser);
		}
	}
	
	public User login(LoginUser newLogin, BindingResult result) {
		User potentialUser = userRepo.findByEmail(newLogin.getEmail());
		if(potentialUser==null) {
			result.rejectValue("email", "Unique", "Invalid Email or Password");
			return null;
		}
		if(!BCrypt.checkpw(newLogin.getPassword(), potentialUser.getPassword())) {
			result.rejectValue("password", "Mismatch", "Invalid Email or Password!");
		}
		if(result.hasErrors()) {
			return null;
		} else {
			return potentialUser;
		}
	}
}
