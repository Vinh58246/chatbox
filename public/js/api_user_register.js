function start(){
    creatuser();
}
start();
function stopFormSubmit(event){
    event.preventDefault();
}

function creatuser(){
    var dangky = document.querySelector('#dangky');

    dangky.onclick = function(){
        const reader = new FileReader();
        var hoten = document.querySelector('input[name="hoten"]').value;
        var email = document.querySelector('input[name="email"]').value;
        var phone = document.querySelector('input[name="phone"]').value;
        var avatar = document.querySelector('input[name="avatar"]').files[0];
        var sex = document.getElementsByName('sex');
        var password = document.querySelector('input[name="password"]').value;


        for (var i = 0; i < sex.length; i++) {
            if (sex[i].checked) {
                // Nếu input radio đã được chọn, lấy giá trị của nó
                var selectedGender = sex[i].value;
            }
        }

        if(avatar.size < 50000){
            reader.readAsDataURL(avatar);
            reader.onload = function(event) {
                const imageUrl = event.target.result;

                var formdata = {
                    ho_ten: hoten,
                    email: email,
                    phone: phone,
                    avatar_user: imageUrl,
                    sex: selectedGender,
                    password: password,
                }
                sendCreateUser(formdata, function(e){
                    if(e.status == 201){
                        window.location.href = "../views/login.html";
                        // console.log(e);
                    }
                    if(e.message == true){
                        alert("Email này đã tồn tại, vui lòng nhập email khác");
                    }
                });
            };
        }else{
            alert("vui lòng chọn hình ảnh < 50kb");
        }

        
    }
}

function sendCreateUser(data, callback){
    var option = {
        method: "POST", // or 'PUT'
        headers: {
              // "Content-Type": "application/json",
              // "Content-Type": "application/form-data",
              "Content-Type": "application/x-www-form-urlencoded",
        },
        body: JSON.stringify(data),
    };

    // fetch("http://localhost:3000/controller/register.php", option)
    fetch("../../controller/register.php", option)
            .then(res => {
                return res.json();
            })
            .then(callback)
            .catch(er => console.log(er));
}

