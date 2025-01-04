package com.example.notion.repository;

import com.example.notion.model.Abstract;
import com.example.notion.model.Note;
import com.example.notion.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AbstractRepository extends JpaRepository<Abstract, Long> {


    List<Abstract> findByUserId(Long userId);
    List<Abstract> findByUserIdAndCompleted(Long userId, boolean completed);
}
