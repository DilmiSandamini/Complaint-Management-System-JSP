$(document).ready(function () {
    const namePattern = /^[A-Za-z ]{2,}$/;
    const usernamePattern = /^[A-Za-z0-9_ ]{3,20}$/;
    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d ]{6,}$/;
    const phonePattern = /^0\d{9}$/;
    const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/;

    function validateField(selector, pattern, errorMessage) {
        const $input = $(selector);
        const $error = $input.next(".error");

        if (!pattern.test($input.val())) {
            $input.addClass("invalid");
            $error.text(errorMessage);
            return false;
        } else {
            $input.removeClass("invalid");
            $error.text("");
            return true;
        }
    }

    $("#firstName").on("blur", function () {
        validateField(this, namePattern, "Enter a valid first name.");
    });

    $("#lastName").on("blur", function () {
        validateField(this, namePattern, "Enter a valid last name.");
    });

    $("#mobileNumber").on("blur", function () {
        validateField(this, phonePattern, "Enter a valid 10-digit number starting with 0.");
    });

    $("#username").on("blur", function () {
        validateField(this, usernamePattern, "Username must be 3-20 characters long.");
    });

    $("#email").on("blur", function () {
        validateField(this, emailPattern, "Enter a valid email address.");
    });

    $("#password").on("blur", function () {
        validateField(this, passwordPattern, "Password must be 6+ characters with at least 1 number.");
    });

    $("form").on("submit", function (e) {
        let isValid = true;

        if (!validateField("#firstName", namePattern, "Enter a valid first name.")) isValid = false;
        if (!validateField("#lastName", namePattern, "Enter a valid last name.")) isValid = false;
        if (!validateField("#mobileNumber", phonePattern, "Enter a valid 10-digit number starting with 0.")) isValid = false;
        if (!validateField("#username", usernamePattern, "Username must be 3-20 characters long.")) isValid = false;
        if (!validateField("#email", emailPattern, "Enter a valid email address.")) isValid = false;
        if (!validateField("#password", passwordPattern, "Password must be 6+ characters with at least 1 number.")) isValid = false;

        if (!isValid) {
            e.preventDefault();
            alert("Please correct the highlighted fields.");
        }
    });
});
