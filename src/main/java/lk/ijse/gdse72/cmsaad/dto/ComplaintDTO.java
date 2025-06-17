package lk.ijse.gdse72.cmsaad.dto;

import lombok.*;

import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class ComplaintDTO {
    private String complaintId;
    private String title;
    private String description;
    private String department;
    private String status;
    private String submittedBy;
    private String submittedByName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
