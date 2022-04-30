package ru.vsu.csf.group7.entity;

import com.google.cloud.firestore.DocumentReference;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Comment {
    private String id;
    private DocumentReference channelRef, videoRef;
    private String content;
    private boolean isDeleted;
    private LocalDateTime writtenOn;
}
