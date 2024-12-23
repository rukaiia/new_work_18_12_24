package com.example.notion.repository;


import com.example.notion.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String userEmail);

    Optional<User> findByResetPasswordToken(String resetPasswordToken);



}
