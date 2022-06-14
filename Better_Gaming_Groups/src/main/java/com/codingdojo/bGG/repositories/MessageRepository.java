package com.codingdojo.bGG.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.bGG.models.Message;

public interface MessageRepository extends CrudRepository<Message, Long> {
	List<Message> findAll();
}
