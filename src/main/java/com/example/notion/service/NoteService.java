package com.example.notion.service;

import com.example.notion.model.Note;
import com.example.notion.model.User;
import com.example.notion.repository.NoteRepository;
import com.example.notion.repository.UserRepository;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class NoteService {
    private final NoteRepository noteRepository;
    private final UserRepository userRepository;

    public NoteService(NoteRepository noteRepository, UserRepository userRepository) {
        this.noteRepository = noteRepository;
        this.userRepository = userRepository;
    }

    public List<Note> findAll() {
        return noteRepository.findAll();
    }

    public void save(Note note, Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Пользователь не найден"));

        note.setUser(user);
        noteRepository.save(note);
    }


    public Note findById(Long id) {
        return noteRepository.findById(id).orElse(null);
    }

    public void deleteById(Long id) {
        noteRepository.deleteById(id);
    }



    public List<Note> findAllByUser(Optional<User> user) {
        return noteRepository.findByUser(user);
    }



    public List<Note> getNotesOfUser(Long userId, String filter) {
        if (!userRepository.existsById(userId)) {
            throw new IllegalArgumentException("Пользователь с ID " + userId + " не найден.");
        }

        switch (filter) {
            case "completed":
                return noteRepository.findByUserIdAndCompleted(userId, true);
            case "not_completed":
                return noteRepository.findByUserIdAndCompleted(userId, false);
            default:
                return noteRepository.findByUserId(userId);
        }
    }


    public void toggleCompleted(Long id) {
        Note note = noteRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Заметка не найдена"));
        note.setCompleted(!note.isCompleted());
        noteRepository.save(note);
    }

    public Note getById(Long noteId) {
        Optional<Note> noteOptional = noteRepository.findById(noteId);
        if (noteOptional.isPresent()) {
            return noteOptional.get();
        } else {
            throw new IllegalArgumentException("Заметка не найдена");
        }
    }
}

