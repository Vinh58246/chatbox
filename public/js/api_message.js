
const socket = new WebSocket('ws://localhost:8000');

        
function start(){
    getuser(renderuser);
    clickSend()
    nhankeyenter();


    setTimeout(() => {
        logout();
    }, 100);
    // setInterval(() => {
    //     getuser(renderuser);
    // }, 2000);

    socket.onopen = function(event) {
        console.log('Đã kết nối đến websocket');
    };

    socket.onmessage = function(event) {
        setTimeout(() => {
            console.log(event);
            getuser(renderuser);
        }, 100);
    };

    socket.onclose = function(event) {
        console.log('Đã ngắt kết nối websocket');
    };

    socket.onerror = function(error) {
        console.error('lỗi websocket:', error);
    };
}
start();

function stopFormSubmit(event){
    event.preventDefault();
}

function nhankeyenter(){
    // var img_send = document.getElementById('handleEnter');
    var inputElement = document.getElementById("handleEnter");

    // Thêm sự kiện "keydown" bằng addEventListener
    inputElement.addEventListener("keydown", function(event) {
        // Kiểm tra xem phím được nhấn có phải là phím Enter không (mã 13)
        if (event.keyCode === 13) {
            sendMessage();

        }
    });
}

function clickSend(){
    var getbtnsend = document.querySelector("#send");
    getbtnsend.onclick = function(){
        sendMessage();    
    }
}
function sendMessage(){
    var getimgip = document.querySelector('input[name="img_send"]');
    var getctip = document.querySelector('input[name="content_send"]').value;

    if(getimgip.files.length > 0){
        if(getimgip.files[0].size < 50000){
            const reader = new FileReader();
            var fileimg = getimgip.files[0];
            reader.readAsDataURL(fileimg);
            reader.onload = function(event) {
                const imageUrl = event.target.result;
                var formdata = {
                    content: getctip,
                    img_content: imageUrl,
                }
                
                sendCnt(formdata, function(e){
                    if(e.status == 201){
                        getuser(renderuser);
                    }
                });
            };
        }else{
            alert("vui lòng chọn hình ảnh < 50kb");
            return;
        }
    }
    else{
        var formdata = {
            content: encodeHTML(getctip),
            img_content: '',
        }
        sendCnt(formdata, function(e){
            if(e.status == 201){
                getuser(renderuser);
            }
        });
    };

    socket.send(getctip);
    document.querySelector('input[name="img_send"]').value = '';
    document.querySelector('input[name="content_send"]').value = '';
}

function sendCnt(data, callback){
    var option = {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: JSON.stringify(data),
    }
    // fetch('http://localhost:3000/controller/create_message.php', option)
    fetch('../../controller/create_message.php', option)
        .then(res => {
            return res.json();
        })
        .then(callback)
        .catch(er => console.log(er));
}

function logout(){
    var getIdLogout = document.querySelector("#logout");
    getIdLogout.onclick = function(){
        var option = {
            method: 'DELETE',
            headers: {
                "Content-Type": "application/json",
            }
        };
        // fetch('http://localhost:3000/controller/logout_user.php', option)
        fetch('../../controller/logout_user.php', option)
        .then(res => {
            return res.json();
        })
        .then(e => {
            console.log("bạn đã logout");
        })
        .catch(er => console.log(er));
    }
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

function getuser(callback){
    // fetch('http://localhost:3000/controller/read_user.php?ok=' + getCookie('ok'))
    fetch('../../controller/read_user.php?ok=' + getCookie('ok'))
        .then(res => {
            return res.json();
        })
        .then(callback)
        .catch(er => {
            var thongbao = document.querySelector("#thongbao");

            thongbao.innerHTML = '<h1 class="text-center">Vui lòng đăng nhập để có thể xem tin nhắn</h1>';
        });
    
}

function renderEmoji(e, ei){
    if(ei.cac_icon_duoc_chon != null && ei.cac_icon_duoc_chon != ""){
        for (let i = 0; i < ei.cac_icon_duoc_chon.length; i++) {
            if(e.guicookieid == ei.cac_icon_duoc_chon[i].id_user_icon){
            var htmlsicon_user = `<span>${ei.cac_icon_duoc_chon[i].icon}</span>`;
            }
        }
    }
    
    if(htmlsicon_user == null || htmlsicon_user == ""){
        htmlsicon_user = '<i class="fal fa-heart text-white"></i>';
    }

    if(ei.icon_khac_biet != null && ei.icon_khac_biet != ""){
        var htmlsicon = "";
        for (let i = 0; i < ei.icon_khac_biet.length; i++) {
            htmlsicon += `<span class="">${ei.icon_khac_biet[i].gia_tri}</span>`;
        }
    }

    if(htmlsicon == null || htmlsicon == ""){
        htmlsicon = "";
    }

    if(ei.cac_icon_duoc_chon != null || ei.cac_icon_duoc_chon == ""){
        var tableprofile = "";
        for (let i = 0; i < ei.cac_icon_duoc_chon.length; i++) {
            tableprofile += `<tr>
                                <th scope="row">${ei.cac_icon_duoc_chon[i].icon}</th>
                                <td>${ei.cac_icon_duoc_chon[i].ho_ten_drop}</td>
                            </tr>`;
        }
    }

    var luahtmlicon = `<div class="col-6 wrapper">
                            <input type="checkbox" />
                            <div class="btn">
                                `+htmlsicon_user+`
                            </div>
                            <div class="tooltip border">
                                <form class="rating" onsubmit="stopFormSubmit(event)">
                                    <input type="radio" name="emoji_drop" id="idlike-${ei.id_message}">
                                    <label class="cllike" value="${ei.id_message}" for="idlike-${ei.id_message}" onclick="chonemoji(this)">👍</label>
                                    <input type="radio" name="emoji_drop" id="idhappy-${ei.id_message}">
                                    <label class="clhappy" value="${ei.id_message}" for="idhappy-${ei.id_message}" onclick="chonemoji(this)">😆</label>
                                    <input type="radio" name="emoji_drop" id="idsad-${ei.id_message}">
                                    <label class="clsad" value="${ei.id_message}" for="idsad-${ei.id_message}" onclick="chonemoji(this)">😭</label>
                                    <input type="radio" name="emoji_drop" id="idangry-${ei.id_message}">
                                    <label class="clangry" value="${ei.id_message}" for="idangry-${ei.id_message}" onclick="chonemoji(this)">😡</label>
                                    <input type="radio" name="emoji_drop" id="idfavourite-${ei.id_message}">
                                    <label class="clfavourite" value="${ei.id_message}" for="idfavourite-${ei.id_message}" onclick="chonemoji(this)">😍</label>
                                    <input type="radio" name="emoji_drop" id="idwow-${ei.id_message}">
                                    <label class="clwow" value="${ei.id_message}" for="idwow-${ei.id_message}" onclick="chonemoji(this)">😮</label>
                                </form>
                            </div>
                            <svg></svg>
                        </div>`;

    var hienthithaicon = `
                            <div class="col-6 pe-2 ps-2 d-inline-flex bg-light rounded-5 border d-inline-block w-auto" data-bs-toggle="modal" data-bs-target="#staticBackdrop${ei.id_message}" style="cursor: pointer;">
                                <div>
                                    `+htmlsicon+`
                                </div>
                                <span class='ms-1'>${ei.so_luong_icon}</span>
                            </div>


                            <div class="modal fade" id="staticBackdrop${ei.id_message}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Thông tin emoji (${ei.so_luong_icon})</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                <th scope="col">emoji</th>
                                                <th scope="col">họ tên</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                `+tableprofile+`
                                            </tbody>
                                        </table>
                                    </div>
                                    </div>
                                </div>
                            </div>
                            `;
    var renderframe_icon = luahtmlicon + hienthithaicon;

    if(ei.so_luong_icon == 0){
        renderframe_icon = luahtmlicon;
    }
    return renderframe_icon;
}


function renderuser(e){
    var khung_chat = document.querySelector('#frame_chat');
    var htmls = e.data.map(function(ei){
        var bienimgcontent = "";
        var biencontent = "";
        if(ei.img_content != "" && ei.img_content != null){
            bienimgcontent = `<img src="${ei.img_content}" alt="" class="img_content mb-3">`;
        }
        if(ei.content != ""){
            biencontent = `<div class="thang_li mb-3"><p class="thang_p">${ei.content}</p></div>`;
        }
        
        return  (e.guicookieid == ei.id_user) ?  
                `
                <div class="frame_content" style="background-color: #e1f7de;">
                    <div class="frame_in_content pe-5" style="justify-content: end;">
                        <img src="${ei.avatar_user}" alt="" class="img_avatar">
                        <div class="ms-3 me-3">
                            <div class="mb-3">
                                <h5>${ei.ho_ten}</h5>
                            </div>
                            <div class="content_message">
                                <div style="position: relative;">
                                    ` + biencontent + `
                                    `+ bienimgcontent +`
                                    <div class="editstop row">

                                        `+renderEmoji(e, ei)+`

                                    </div>
                                </div>
                                <span class="text-secondary">${ei.time_send}</span>
                            </div>
                        </div>
                    </div>
                </div>
                `
                : 
                `
                <div class="frame_content">
                    <div class="frame_in_content">
                        <img src="${ei.avatar_user}" alt="" class="img_avatar">
                        <div class="ms-3 me-3">
                            <div class="mb-3">
                                <h5>${ei.ho_ten}</h5>
                            </div>
                            <div class="content_message">
                                <div style="position: relative;">
                                    ` + biencontent + `
                                    `+ bienimgcontent +`
                                    <div class="editstop row">

                                        `+renderEmoji(e, ei)+`

                                    </div>
                                </div>
                                <span class="text-secondary">${ei.time_send}</span>
                            </div>
                        </div>
                    </div>
                </div>
                `;
    });
    
    khung_chat.innerHTML = htmls.join('');
}

function chonemoji(e){
    setTimeout(() => {
        getuser(renderuser);

    }, 100);
     var iconc = e.innerHTML;
     var id_messagec = e.getAttribute("value");
    var res = {
        icon: iconc,
        id_message: id_messagec,
    };
    var option = {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: JSON.stringify(res),
    };
    // fetch("http://localhost:3000/controller/create_emoji.php", option)
    fetch("../../controller/create_emoji.php", option)
        .then(res => function(){
            return res.json();
        })
        .then(em => function(){
            console.log(em);
        })
        .catch(er => console.log(er)); 
    socket.send(id_messagec);
}

function encodeHTML(html) {
    return html.replace(/[/<>\\:;*?"'|]/gim, function(i) {
        if(i.charCodeAt(0) == 60){
            return '&lt;'; // <
        }
        if(i.charCodeAt(0) == 62){
            return '&gt;'; // >
        }
        if(i.charCodeAt(0) == 34){
            return '&quot;'; // "
        }
        if(i.charCodeAt(0) == 47 || i.charCodeAt(0) == 92 || i.charCodeAt(0) == 58 || i.charCodeAt(0) == 59 || i.charCodeAt(0) == 42 || i.charCodeAt(0) == 63 || i.charCodeAt(0) == 39 || i.charCodeAt(0) == 124){
            // 47 = /, 92 = \, 58 = :, 59 = ;, 42 = *, 63 = ?, 39 = ', 124 = |
            return '&#' + i.charCodeAt(0) + ';';
        }
    });
}

