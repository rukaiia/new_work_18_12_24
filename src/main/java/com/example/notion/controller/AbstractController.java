package com.example.notion.controller;

import com.example.notion.model.Abstract;
import com.example.notion.model.User;
import com.example.notion.service.AbstractService;
import com.example.notion.service.UserService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
@Controller
@RequestMapping("/abstracts")
public class AbstractController {
    private final AbstractService abstractService;
    private final UserService userService;

    public AbstractController(AbstractService noteService, UserService userService) {
        this.abstractService = noteService;
        this.userService = userService;
    }

    @GetMapping
    public String listAbstracts(
            @RequestParam(value = "filter", required = false, defaultValue = "all") String filter,
            Model model) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));

        List<Abstract> notes = abstractService.getNotesOfUser(user.getId(), filter);

        model.addAttribute("user", user);
        model.addAttribute("notes", notes);
        model.addAttribute("filter", filter);

        return "notes/abstracts";
    }





    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("note", new Abstract());
        return "notes/create";
    }

    @PostMapping
    public String createNote(@ModelAttribute Abstract note) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));
        note.setCreatedDate(LocalDateTime.now());


        abstractService.save(note, user.getId());

        return "redirect:/abstracts";
    }


    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Abstract note = abstractService.findById(id);
        if (note != null) {
            model.addAttribute("note", note);
            return "notes/edit";
        }
        return "redirect:/abstracts";
    }

    @PostMapping("/{id}")
    public String updateNote(@PathVariable Long id, @ModelAttribute Abstract note) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));

        note.setId(id);
        note.setUser(user);
        note.setCreatedDate(LocalDateTime.now());


        abstractService.save(note, user.getId());

        return "redirect:/abstracts";
    }
    @PostMapping("/{id}/toggleCompleted")
    public String toggleCompleted(@PathVariable Long id) {
        abstractService.toggleCompleted(id);
        return "redirect:/abstracts";
    }


    @PostMapping("/{id}/delete")
    public String deleteNote(@PathVariable Long id) {
        abstractService.deleteById(id);
        return "redirect:/abstracts";
    }
    @GetMapping("/{id}/content")
    public String getPostById(@PathVariable Long id, Model model) {
        Abstract post = abstractService.getById(id);

        if (post == null) {
            return "error/404";
        }
        model.addAttribute("post", post);

        return "notes/abstractDetails";
    }
}
