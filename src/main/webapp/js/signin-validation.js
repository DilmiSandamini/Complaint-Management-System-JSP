$(document).ready(function () {
    const usernamePattern = /^[A-Za-z0-9_ ]{3,20}$/;
    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d ]{6,}$/;

    function validateField(selector, pattern, errorMessage) {
        const $input = $(selector);
        $input.next(".error").remove(); // remove old error

        if (!pattern.test($input.val())) {
            $input.addClass("is-invalid");
            $input.after('<div class="error text-danger mt-1">' + errorMessage + '</div>');
            return false;
        } else {
            $input.removeClass("is-invalid");
            return true;
        }
    }

    $("form").on("submit", function (e) {
        let isValid = true;

        if (!validateField("#username", usernamePattern, "Username must be 3-20 characters.")) isValid = false;
        if (!validateField("#password", passwordPattern, "Password must be at least 6 characters with letters and numbers.")) isValid = false;

        if (!isValid) {
            e.preventDefault();
        }
    });
});