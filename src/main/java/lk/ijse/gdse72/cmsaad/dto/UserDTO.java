package lk.ijse.gdse72.cmsaad.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class UserDTO {
    private String userId;
    private String firstName;
    private String lastName;
    private String mobilNumber;
    private String userName;
    private String email;
    private String password;
    private String department;
    private String role;

    public boolean isAdmin(){return "ADMIN".equalsIgnoreCase(role);}

    public boolean isEmployee(){return "EMPLOYEE".equalsIgnoreCase(role);}
}
