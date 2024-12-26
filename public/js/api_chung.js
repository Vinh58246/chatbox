        
function start(){
    renderBtn();
}
start();

function stopFormSubmit(event){
    event.preventDefault();
}

function renderBtn(){
    var btn_func = document.querySelector('#btn_func');

    btn_func.innerHTML = btnsAs();

}

function btnsAs(){
    var btnrender = `<a class="btn btn-light" href="register.html">Đăng Ký</a>
                    <a class="btn btn-light" href="login.html">Đăng Nhập</a>`;


    if(getCookie("ok") != null){
        btnrender = `<a class="btn btn-light" href="profile.html">Hồ Sơ</a>
                    <a class="btn btn-light" href="" id="logout">Đăng xuất</a>`;

    }
    return btnrender;
}

function getCookie(name) {
    var allCookies = document.cookie;
    var cookiesArray = allCookies.split('; ');
    var getvaluecookie = null
    cookiesArray.forEach(function(cookie) {
        var cookieParts = cookie.split('=');
        var cookieName = cookieParts[0].trim(); 
        var cookieValue = cookieParts[1]; 

        if(cookieName == name){
            getvaluecookie = cookieValue;
        }
    });
    return getvaluecookie;
}