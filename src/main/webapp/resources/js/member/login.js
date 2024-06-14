function validateForm() {
            var email = document.getElementById('username').value;
            var password = document.getElementById('password').value;
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(email)) {
                document.getElementById('usernameError').style.display = 'block';
                return false;
            } else {
                document.getElementById('usernameError').style.display = 'none';
            }

            if (password.trim() === "") {
                document.getElementById('passwordError').style.display = 'block';
                return false;
            } else {
                document.getElementById('passwordError').style.display = 'none';
            }

            return true;
        }