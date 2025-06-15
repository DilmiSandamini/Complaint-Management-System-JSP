package lk.ijse.gdse72.cmsaad.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class UserDTO {
    private String userId;
    private String firstName;
    private String lastName;
    private String mobileNumber;
    private String username;
    private String email;
    private String password;
    private String role;
    private LocalDateTime createdAt;


    public boolean isAdmin(){return "ADMIN".equalsIgnoreCase(role);}

    public boolean isEmployee(){return "EMPLOYEE".equalsIgnoreCase(role);}
}
