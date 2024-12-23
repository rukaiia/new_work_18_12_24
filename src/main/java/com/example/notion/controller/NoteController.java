package com.example.notion.controller;

import com.example.notion.dto.UserDto;
import com.example.notion.model.Note;
import com.example.notion.model.User;
import com.example.notion.service.NoteService;
import com.example.notion.service.UserService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/notes")
public class NoteController {
    private final NoteService noteService;
    private final UserService userService;

    public NoteController(NoteService noteService, UserService userService) {
        this.noteService = noteService;
        this.userService = userService;
    }

    @GetMapping
    public String listNotes(
            @RequestParam(value = "filter", required = false, defaultValue = "all") String filter,
            Model model) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));

        List<Note> notes = noteService.getNotesOfUser(user.getId(), filter);

        model.addAttribute("user", user);
        model.addAttribute("notes", notes);
        model.addAttribute("filter", filter);

        return "notes/notes";
    }





    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("note", new Note());
        return "notes/create";
    }

    @PostMapping
    public String createNote(@ModelAttribute Note note) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));
        note.setCreatedDate(LocalDateTime.now());


        noteService.save(note, user.getId());

        return "redirect:/notes";
    }


    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Note note = noteService.findById(id);
        if (note != null) {
            model.addAttribute("note", note);
            return "notes/edit";
        }
        return "redirect:/notes";
    }

    @PostMapping("/{id}")
    public String updateNote(@PathVariable Long id, @ModelAttribute Note note) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));

        note.setId(id);
        note.setUser(user);
        note.setCreatedDate(LocalDateTime.now());


        noteService.save(note, user.getId());

        return "redirect:/notes";
    }
    @PostMapping("/{id}/toggleCompleted")
    public String toggleCompleted(@PathVariable Long id) {
        noteService.toggleCompleted(id);
        return "redirect:/notes";
    }


    @PostMapping("/{id}/delete")
    public String deleteNote(@PathVariable Long id) {
        noteService.deleteById(id);
        return "redirect:/notes";
    }
}
