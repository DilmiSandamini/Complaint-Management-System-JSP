package lk.ijse.gdse72.cmsaad.model;


import lk.ijse.gdse72.cmsaad.dto.ComplaintDTO;
import lk.ijse.gdse72.cmsaad.util.DatabaseConfig;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class ComplaintModel {
    public static String generateComplaintId() {
        return "CMP_" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    }

    public boolean createComplaint(ComplaintDTO complaint) {
        String sql = "INSERT INTO complaints (complaintId, title, description, department, " +
                "status, submitted_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaint.getComplaintId());
            pstmt.setString(2, complaint.getTitle());
            pstmt.setString(3, complaint.getDescription());
            pstmt.setString(4, complaint.getDepartment());
            pstmt.setString(5, complaint.getStatus());
            pstmt.setString(6, complaint.getSubmittedBy());
            pstmt.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error creating complaint", e);
        }
    }

    public List<ComplaintDTO> getComplaintsByUser(String userId) throws SQLException {
        List<ComplaintDTO> complaints = new ArrayList<>();
        String sql = "SELECT c.*, u.username as submitted_by_name " +
                "FROM complaints c " +
                "LEFT JOIN users u ON c.submitted_by = u.userId " +
                "WHERE c.submitted_by = ? " +
                "ORDER BY c.created_at DESC";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    complaints.add(mapResultSetToComplaint(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching complaints by user", e);
        }
        return complaints;
    }

    private ComplaintDTO mapResultSetToComplaint(ResultSet rs) throws SQLException {
        ComplaintDTO complaint = new ComplaintDTO();
        complaint.setComplaintId(rs.getString("complaintId"));
        complaint.setTitle(rs.getString("title"));
        complaint.setDescription(rs.getString("description"));
        complaint.setDepartment(rs.getString("department"));
        complaint.setStatus(rs.getString("status"));
        complaint.setSubmittedBy(rs.getString("submitted_by"));
        complaint.setSubmittedByName(rs.getString("submitted_by_name"));
        complaint.setAdminRemarks(rs.getString("admin_remarks"));


        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            complaint.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            complaint.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return complaint;
    }

    public ComplaintDTO getComplaintById(String complaintId) {
        String sql = "SELECT c.*, " +
                "CONCAT(u.firstName, ' ', u.lastName) AS submitted_by_name " +
                "FROM complaints c " +
                "LEFT JOIN users u ON c.submitted_by = u.userId " +
                "WHERE c.complaintId = ?";


        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToComplaint(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching complaint by ID", e);
        }
        return null;
    }

    public boolean deleteComplaint(String complaintId) {
        String sql = "DELETE FROM complaints WHERE complaintId = ?";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint", e);
        }
    }

    public boolean deleteComplaintByEmployee(String complaintId, String userId) {
        String sql = "DELETE FROM complaints WHERE complaintId = ? AND submitted_by = ? AND status = 'PENDING'";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);
            pstmt.setString(2, userId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint by employee", e);
        }
    }

    public boolean updateComplaint(ComplaintDTO complaint) {
        String sql = "UPDATE complaints SET title = ?, description = ?, department = ?, " +
                "updated_at = ? WHERE complaintId = ?";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaint.getTitle());
            pstmt.setString(2, complaint.getDescription());
            pstmt.setString(3, complaint.getDepartment());
            pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setString(5, complaint.getComplaintId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Updating complaint error", e);
        }
    }

    public List<ComplaintDTO> getAllComplaints() {
        List<ComplaintDTO> complaints = new ArrayList<>();

        String sql = "SELECT c.*, u.username as submitted_by_name " +
                "FROM complaints c " +
                "LEFT JOIN users u ON c.submitted_by = u.userId " +
                "ORDER BY c.created_at DESC";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                complaints.add(mapResultSetToComplaint(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all complaints", e);
        }
        return complaints;
    }

    public boolean updateComplaintStatus(String complaintId, String status,String adminRemarks) {
        String sql = "UPDATE complaints SET status = ?, admin_remarks = ?, updated_at = ? WHERE complaintId = ?";

        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setString(2, adminRemarks);
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setString(4, complaintId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {

            System.err.println("Error updating complaint status: " + e.getMessage());
            throw new RuntimeException("Error updating complaint status", e);
        }
    }
}


