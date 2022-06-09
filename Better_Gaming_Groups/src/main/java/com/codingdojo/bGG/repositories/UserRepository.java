package com.codingdojo.bGG.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.bGG.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	List<User> findAll();
}
