package com.example.notion.service;

import com.example.notion.model.Abstract;
import com.example.notion.model.User;
import com.example.notion.repository.AbstractRepository;
import com.example.notion.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service

public class AbstractService {
    private final AbstractRepository abstractRepository;
    private final UserRepository userRepository;

    public AbstractService(AbstractRepository noteRepository, UserRepository userRepository) {
        this.abstractRepository = noteRepository;
        this.userRepository = userRepository;
    }

    public List<Abstract> findAll() {
        return abstractRepository.findAll();
    }

    public void save(Abstract note, Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Пользователь не найден"));

        note.setUser(user);
        abstractRepository.save(note);
    }


    public Abstract findById(Long id) {
        return abstractRepository.findById(id).orElse(null);
    }

    public void deleteById(Long id) {
        abstractRepository.deleteById(id);
    }



//    public List<Abstract> findAllByUser(Optional<User> user) {
//        return abstractRepository.findByUser(user);
//    }



    public List<Abstract> getNotesOfUser(Long userId, String filter) {
        if (!userRepository.existsById(userId)) {
            throw new IllegalArgumentException("Пользователь с ID " + userId + " не найден.");
        }

        switch (filter) {
            case "completed":
                return abstractRepository.findByUserIdAndCompleted(userId, true);
            case "not_completed":
                return abstractRepository.findByUserIdAndCompleted(userId, false);
            default:
                return abstractRepository.findByUserId(userId);
        }
    }


    public void toggleCompleted(Long id) {
        Abstract note = abstractRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Заметка не найдена"));
        note.setCompleted(!note.isCompleted());
        abstractRepository.save(note);
    }

    public Abstract getById(Long noteId) {
        Optional<Abstract> noteOptional = abstractRepository.findById(noteId);
        if (noteOptional.isPresent()) {
            return noteOptional.get();
        } else {
            throw new IllegalArgumentException("Заметка не найдена");
        }
    }
}




