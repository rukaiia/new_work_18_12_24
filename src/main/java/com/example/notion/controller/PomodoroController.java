package com.example.notion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PomodoroController {

    private int workDuration = 25;
    private int breakDuration = 5;

    private int timeLeft = workDuration * 60;
    private boolean isPaused = true;

    @GetMapping("/pomodoro")
    public String showPomodoroPage(Model model) {
        int minutes = timeLeft / 60;
        int seconds = timeLeft % 60;

        model.addAttribute("workDuration", workDuration);
        model.addAttribute("breakDuration", breakDuration);
        model.addAttribute("minutes", minutes);
        model.addAttribute("seconds", seconds);
        model.addAttribute("isPaused", isPaused);

        return "notes/pomodoro";
    }

    @PostMapping("/pomodoro/settings")
    public String updatePomodoroSettings(
            @RequestParam("workDuration") int newWorkDuration,
            @RequestParam("breakDuration") int newBreakDuration) {
        workDuration = newWorkDuration;
        breakDuration = newBreakDuration;
        timeLeft = workDuration * 60;

        return "redirect:/pomodoro";
    }

    @PostMapping("/pomodoro/start")
    public String startTimer(Model model) {
        if (isPaused) {
            timeLeft = workDuration * 60;
            isPaused = false;
        }
        return "redirect:/pomodoro";
    }

    @PostMapping("/pomodoro/pause")
    public String pauseTimer(Model model) {
        isPaused = true;
        return "redirect:/pomodoro";
    }

    @PostMapping("/pomodoro/reset")
    public String resetTimer(Model model) {
        timeLeft = workDuration * 60;
        isPaused = true;
        return "redirect:/pomodoro";
    }
}