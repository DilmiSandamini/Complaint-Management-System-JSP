package lk.ijse.gdse72.cmsaad.util;

public class ValidationUtil {
    public static boolean isValidfirstName(String firstName) {
        return firstName != null && !firstName.trim().isEmpty() && firstName.length() >= 3 && firstName.length() <= 50;
    }

    public static boolean isValidlastName(String lastName) {
        return lastName != null && !lastName.trim().isEmpty() && lastName.length() >= 3 && lastName.length() <= 50;
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.matches("\\d{6,10}");
    }

    public static boolean isValidMobileNumber(String mobileNumber) {
        return mobileNumber != null && mobileNumber.matches("07\\d{8}");
    }

    public static boolean isValidUsername(String username) {
        return username != null && !username.trim().isEmpty() && username.length() >= 3 && username.length() <= 20 &&
                username.matches("^[a-zA-Z0-9_]+$");
    }

    public static boolean isValidEmail(String email) {
        return email != null && !email.trim().isEmpty() &&
                email.matches("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$");
    }
}
