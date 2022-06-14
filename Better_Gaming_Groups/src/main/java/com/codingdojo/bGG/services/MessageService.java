package com.codingdojo.bGG.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.bGG.models.Message;
import com.codingdojo.bGG.repositories.MessageRepository;

@Service
public class MessageService {
	
	@Autowired
	private MessageRepository messageRepo;
	
	public List<Message> getAllMessages() {
		return messageRepo.findAll();
	}
	
	public Message getMessage(Long id) {
		Message message = messageRepo.findById(id).orElse(null);
		return message;
	}
	
	public Message createMessage(Message newMessage) {
		return messageRepo.save(newMessage);
	}
	
	public Message updateMessage(Message updateMessage) {
		return messageRepo.save(updateMessage);
	}
	
	public void deleteMessage(Long id) {
		messageRepo.deleteById(id);
	}
}
