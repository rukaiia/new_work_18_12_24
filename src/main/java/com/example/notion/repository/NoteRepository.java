package com.example.notion.repository;



import com.example.notion.model.Note;
import com.example.notion.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface NoteRepository extends JpaRepository<Note, Long> {
    List<Note> findByUser(Optional<User> user);

    List<Note> findByUserEmail(String email);

    List<Note> findByUserId(Long userId);
    List<Note> findByUserIdAndCompleted(Long userId, boolean completed);


    List<Note> findByUserIdAndTitleContaining(Long userId, String title);  // Пример фильтрации по названию

    List<Note> findByUserIdAndCreatedDateAfter(Long userId, LocalDateTime createdDate);  // Пример фильтрации по дате}
}