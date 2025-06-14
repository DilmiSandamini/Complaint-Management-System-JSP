package lk.ijse.gdse72.cmsaad.model;

import lk.ijse.gdse72.cmsaad.dto.UserDTO;
import lk.ijse.gdse72.cmsaad.util.DatabaseConfig;

import java.sql.Connection;

public class UserModel {
    public static String generateUserId(){
        return "USER_" + java.util.UUID.randomUUID().toString().substring(0, 9).toUpperCase();
    }

    public boolean saveUser(UserDTO userDTO){
        String sql = "INSERT INTO users (userId, firstName, lastName, mobilNumber, userName, email, password, department, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             var preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, userDTO.getUserId());
            preparedStatement.setString(2, userDTO.getFirstName());
            preparedStatement.setString(3, userDTO.getLastName());
            preparedStatement.setString(4, userDTO.getMobilNumber());
            preparedStatement.setString(5, userDTO.getUserName());
            preparedStatement.setString(6, userDTO.getEmail());
            preparedStatement.setString(7, userDTO.getPassword());
            preparedStatement.setString(8, userDTO.getDepartment());
            preparedStatement.setString(9, userDTO.getRole());


            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
