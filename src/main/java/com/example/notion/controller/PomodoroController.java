package com.example.notion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PomodoroController {

    // Значения по умолчанию для таймера
    private int workDuration = 25; // минуты
    private int breakDuration = 5; // минуты

    private int timeLeft = workDuration * 60; // начальное время таймера в секундах
    private boolean isPaused = true;

    // Отображение страницы таймера
    @GetMapping("/pomodoro")
    public String showPomodoroPage(Model model) {
        // Конвертируем время в минуты и секунды
        int minutes = timeLeft / 60;
        int seconds = timeLeft % 60;

        // Добавление данных в модель
        model.addAttribute("workDuration", workDuration);
        model.addAttribute("breakDuration", breakDuration);
        model.addAttribute("minutes", minutes);
        model.addAttribute("seconds", seconds);
        model.addAttribute("isPaused", isPaused);

        return "notes/pomodoro";
    }

    // Обработка сохранения настроек таймера
    @PostMapping("/pomodoro/settings")
    public String updatePomodoroSettings(
            @RequestParam("workDuration") int newWorkDuration,
            @RequestParam("breakDuration") int newBreakDuration) {
        workDuration = newWorkDuration;
        breakDuration = newBreakDuration;
        timeLeft = workDuration * 60; // сбросить время таймера

        return "redirect:/pomodoro"; // Перенаправление на страницу таймера
    }

    // Обработка старта таймера
    @PostMapping("/pomodoro/start")
    public String startTimer(Model model) {
        if (isPaused) {
            timeLeft = workDuration * 60; // Сбросить время на новое значение работы
            isPaused = false;
        }
        return "redirect:/pomodoro"; // Перенаправление на страницу с обновленным таймером
    }

    // Обработка паузы таймера
    @PostMapping("/pomodoro/pause")
    public String pauseTimer(Model model) {
        isPaused = true; // Останавливаем таймер
        return "redirect:/pomodoro"; // Перенаправление на страницу с обновленным состоянием
    }

    // Обработка сброса таймера
    @PostMapping("/pomodoro/reset")
    public String resetTimer(Model model) {
        timeLeft = workDuration * 60; // Сбросить таймер
        isPaused = true; // Пауза
        return "redirect:/pomodoro"; // Перенаправление на страницу с обновленным таймером
    }
}