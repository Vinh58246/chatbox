function start(){
    loginuser();
}
start();

function stopFormSubmit(event){
    event.preventDefault();
}

function loginuser(){
    var dangnhap = document.querySelector("#dangnhap");

    dangnhap.onclick = function(){
        var email_login = document.querySelector('input[name="email_login"]').value;
        var password_login = document.querySelector('input[name="password_login"]').value;

        var formdata = {
            email: email_login,
            password: password_login,
        };

        xulydangnhap(formdata, function(e){
            if(e.status == 200){
                window.location.href = "../views/index.html";
                // console.log(e);
            }
        });
    }
}

function xulydangnhap(data, callback){
    var option = {
        method: "POST",
        credentials: "include",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: JSON.stringify(data),
    };
    fetch("../../controller/login.php", option)
    // fetch("http://localhost:3000/controller/login.php", option)
        .then(res => {
            return res.json();
        })
        .then(callback)
        .catch(er => console.log(er));

}