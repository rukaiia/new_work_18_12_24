package com.example.notion.model;



import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Data
public class Note {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String content;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    private LocalDateTime createdDate;
    private boolean completed;
    public String getCreatedDateAsString() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return createdDate.format(formatter);
    }

}

