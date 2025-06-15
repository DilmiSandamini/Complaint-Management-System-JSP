package lk.ijse.gdse72.cmsaad.model;

import lk.ijse.gdse72.cmsaad.dto.UserDTO;
import lk.ijse.gdse72.cmsaad.util.DatabaseConfig;

import java.sql.*;

public class UserModel {
    public static String generateUserId(){
        return "USER_" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    public boolean saveUser(UserDTO userDTO){
        String sql = "INSERT INTO users (userId, firstName, lastName, mobileNumber, username, email, password, role, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             var preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, userDTO.getUserId());
            preparedStatement.setString(2, userDTO.getFirstName());
            preparedStatement.setString(3, userDTO.getLastName());
            preparedStatement.setString(4, userDTO.getMobileNumber());
            preparedStatement.setString(5, userDTO.getUsername());
            preparedStatement.setString(6, userDTO.getEmail());
            preparedStatement.setString(7, userDTO.getPassword());
            preparedStatement.setString(8, userDTO.getRole());


            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserDTO checkAuthenticate (String username, String password) {
        String sql = "SELECT * FROM users WHERE LOWER(username) = LOWER(?)";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbUsername = rs.getString("username");
                String dbPassword = rs.getString("password");

                if (dbPassword.equals(password)) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private UserDTO mapResultSetToUser(ResultSet rs) throws SQLException {
        UserDTO user = new UserDTO();

        user.setUserId(rs.getString("userId"));
        user.setFirstName(rs.getString("firstName"));
        user.setLastName(rs.getString("lastName"));
        user.setMobileNumber(rs.getString("mobileNumber"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(null);
        user.setRole(rs.getString("role"));
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }
        return user;
    }
}
