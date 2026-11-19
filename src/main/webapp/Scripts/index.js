let loginBtn = document.querySelector(".login-btn");
let registerBtn = document.querySelector(".register-btn");

loginBtn.addEventListener("click", function() {
    window.location.href = "login.jsp";
});

registerBtn.addEventListener("click", function() {
    window.location.href = "register.jsp";
});