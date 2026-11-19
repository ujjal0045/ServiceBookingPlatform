const role = document.querySelector("#role");
const providerFields = document.querySelector("#providerFields");

role.addEventListener("change", function () {

    if (role.value === "provider") {
        providerFields.style.display = "block";
    } 
    else {
        providerFields.style.display = "none";
    }

});

window.addEventListener("load", function () {
    role.value = "";
    providerFields.style.display = "none";
});