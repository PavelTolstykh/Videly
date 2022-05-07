package ru.vsu.csf.group7.entity;

import com.google.cloud.Timestamp;
import com.google.cloud.firestore.DocumentReference;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import ru.vsu.csf.group7.http.request.CreateChannelRequest;

import java.util.List;

@Data
@NoArgsConstructor
public class Channel {
    private String name;
    private DocumentReference userRef;
    private String avatarURL, headerURL, about;
//    private List<DocumentReference> videos;
    private boolean allowComments = true, allowRating = true;
    private boolean isDeleted = false;
    private Timestamp createdAt = Timestamp.now();

    public Channel(CreateChannelRequest request) {
        this.name = request.getName();
        this.avatarURL = request.getAvatarURL();
        this.about = request.getAbout();
        this.headerURL = request.getHeaderURL();
//        this.userRef = ((UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getRef();
    }
}
