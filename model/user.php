<?php
require "../database.php";

// kiểm tra lỗi khi nhập
function error422($messge){
    // hiển thị lỗi khi không có giá trị đầu vào
    $data = [
        'status' => 422,
        'message' => $messge,
    ];
    header('HTTP/1.0 422 '.$messge);
    // header('HTTP/1.0 422 Unprocessable Entity');
    return json_encode($data);
    exit();
}

function readUser($checkSession){

    if($_SESSION['idCookie']['ok'] == $checkSession){
        // $bien = $_SESSION['idCookie'];

        $sql = 'SELECT * FROM user INNER JOIN message ON user.id_user = message.id_user ORDER BY id_message DESC';
        $stmt = call_data($sql);
        
        if($stmt){
            if($stmt->rowCount() > 0){
                $mes = $stmt->fetchALL(PDO::FETCH_ASSOC);
                
                $sql2 = "SELECT * FROM emoji";
                $stmt = call_data($sql2);
                $emoji = $stmt->fetchALL(PDO::FETCH_ASSOC);


                $t=0;
                foreach ($mes as $m) {
                    $q = 0;
                    $icon = [];
                    $icon_khacbiet = [];
                    foreach ($emoji as $e) {
                        if($m['id_message'] == $e['id_message_icon']){

                            $nguoi_chon = [
                                'ho_ten' => $m['ho_ten'],
                                'email' => $m['email'],
                                'avatar_user' => $m['avatar_user'],
                                'id_user_icon' => $e['id_user_icon'],
                                'ho_ten_drop' => $e['ho_ten_drop'],
                                'icon' => $e['icon']
                            ];
                            $icon_khacbiet[] = $e['icon'];
                            $icon[] = $nguoi_chon;
                            $q++;
                        }

                    }
                    $m['cac_icon_duoc_chon'] = $icon;

                    $m['icon_khac_biet'] = layphantukhacnhau(sapxepsoluongcocunggiatri(laysoluongcunggiatri($icon_khacbiet)));
                    if(empty($icon)){
                        $m['cac_icon_duoc_chon'] = null;
                        $m['icon_khac_biet'] = null;
                    }
                    $m['so_luong_icon'] = $q;
                    $ui[] = $m;
                }


                $data = [
                    'status' => 200,
                    'message' => 'User List Fetched Successfully',
                    'guicookie' => $_SESSION['idCookie']['ok'],
                    'guicookieid' => $_SESSION['idCookie']['iduser'],
                    'data' => $ui
                ];
                header('HTTP/1.0 200 OK');
                return json_encode($data);
            }
            else{
                $data = [
                    'status' => 500,
                    'message' => 'Internal Server Error',
                ];
                header('HTTP/1.0 404 No Message Found');
                return json_encode($data);
            }
        }
        else{
            $data = [
                'status' => 500,
                'message' => 'Internal Server Error',
            ];
            header('HTTP/1.0 500 Internal Server Error');
            return json_encode($data);
        }
    }
    else{
        $data = [
            'status' => 401,
            'message' => 'User Not Found',
        ];
        header('HTTP/1.0 401 User Not Found');
        return json_encode($data);
    }
}

function register($arr){
    $hoten = strip_tags($arr['ho_ten']);
    $email = strip_tags($arr['email']);
    $phone = strip_tags($arr['phone']);
    $avatar_user = strip_tags($arr['avatar_user']);
    $sex = strip_tags($arr['sex']);
    $password = strip_tags($arr['password']);

    if(empty(trim($hoten))){
        return error422('Enter your hoten');
    }
    elseif(empty(trim($email))){
        return error422('Enter your email');
    }
    elseif(empty(trim($phone))){
        return error422('Enter your phone');
    }
    elseif(empty(trim($avatar_user))){
        return error422('Enter your avatar_user');
    }
    elseif(empty(trim($sex))){
        return error422('Enter your sex');
    }
    elseif(empty(trim($password))){
        return error422('Enter your password');
    }
    else{
        if(checkuser($email) == true){
            $data = [
                'status' => 200,
                'message' => checkuser($email),
            ];
            header('HTTP/1.0 200 checked');
            return json_encode($data);
        }
        else{
            $conn = connect();
            $sql = "INSERT INTO user SET ho_ten=:hoten, email=:email, phone=:phone, avatar_user=:avatar_user, sex=:sex, password=:password";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':hoten', $hoten, PDO::PARAM_STR);
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->bindParam(':phone', $phone, PDO::PARAM_INT);
            $stmt->bindParam(':avatar_user', $avatar_user, PDO::PARAM_STR);
            $stmt->bindParam(':sex', $sex, PDO::PARAM_STR);
            $stmt->bindParam(':password', $password, PDO::PARAM_STR);
            $stmt->execute();

            if ($stmt) {
                $data = [
                    'status' => 201,
                    'message' => 'Custommer Created Successfully',
                ];
                header('HTTP/1.0 201 Created');
                return json_encode($data);

            }
            else{
                $data = [
                    'status' => 500,
                    'message' => 'Internal Server Error',
                ];
                header('HTTP/1.0 500 Internal Server Error');
                return json_encode($data);
            }
        }
        
    }
}

function loginUser($inputdata){
    $_SESSION['idCookie'] = [];
    setcookie("ok" ,"", time()- 60, '/', '', false, false);


    $email = strip_tags($inputdata['email']);
    $password = strip_tags($inputdata['password']);

    if(empty(trim($email))){
        return error422("Enter your email");
    }elseif(empty(trim($password))){
        return error422("Enter your password");
    }
    else{

        $conn = connect();
        $sql = "SELECT * FROM user WHERE email=:email AND password=:password LIMIT 1";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':password', $password, PDO::PARAM_STR);
        $stmt->execute();

        if($stmt->rowCount() != 0){
            $res = $stmt->fetch(PDO::FETCH_ASSOC);
            $sessionId = time();
            $_SESSION['idCookie']['ok'] = $sessionId;
            $_SESSION['idCookie']['iduser'] = $res['id_user'];
            $_SESSION['idCookie']['hoten'] = $res['ho_ten'];
            $data = [
                "status" => 200,
                "message" => "User Logged Successfully",
                "session" => $_SESSION['idCookie'],
            ];
            header('HTTP/1.0 200 Logged');
            // setcookie("ok" , $sessionId,0,);
            setcookie("ok", $sessionId, 0, '/', '', false, false);
            // setcookie("ok" ,"", time()- 60, '/', '', false, false);
            return json_encode($data);
        }
        else{
            $data = [
                "status" => 500,
                "message" => "Internal Server Error",
            ];
            header('HTTP/1.0 500 Internal Server Error');
            return json_encode($data);
        }
    }
}

function logoutUser(){
    setcookie("ok" ,"", time()- 60, '/', '', false, false);
    unset($_SESSION['idCookie']);
    $data = [
        'status' => 200,
        'message' => 'Logout Successfully',
    ];
    header('HTTP/1.0 200 OK');
    return json_encode($data);
}

function checkuser($email){
    $conn = connect();
        $sql = "SELECT * FROM user WHERE email=:email LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':email', $email, PDO::PARAM_STR);
    $stmt->execute();
    if($stmt->rowCount() != 0){
        $thongbao = true;
    }else{
        $thongbao = false;
    }
    return $thongbao;
}

// ---------------- các hàm sử lý logic message --------------------
function layphantukhacnhau($a){
    $q = [];
    $t = 1;
    for ($l=0; $l < count($a); $l++) { 
        $moc = "false";
        if(empty($q)){
            $q[$l]['so_luong'] = $a[$l]['so_luong'];
            $q[$l]['gia_tri'] = $a[$l]['gia_tri'];
        }
        else{
            for ($p=0; $p < count($q); $p++) { 
                if($q[$p]['gia_tri'] === $a[$l]['gia_tri']){
                    $moc = "true";
                }
            }
            if($moc == "false"){
                $q[$t]['so_luong'] = $a[$l]['so_luong'];
                $q[$t]['gia_tri'] = $a[$l]['gia_tri'];
                $t++;
            }
        }
        
    }
    return $q;
}

function laysoluongcunggiatri($a){
    $b = [];
    for ($l=0; $l < count($a); $l++) { 
        $m = 0;
        for ($i=0; $i < count($a); $i++) { 
            if($a[$l] == $a[$i]){
                $m++;
            }
        }
        $x = [
            'so_luong' => $m,
            'gia_tri' => $a[$l]
        ];
        $b[] =  $x;
    }
    return $b;
}

function sapxepsoluongcocunggiatri($n){
    for ($i=0; $i < count($n); $i++) { 
        for ($k=0; $k < count($n); $k++) { 
            if($n[$k]['so_luong'] < $n[$i]['so_luong']){
                $tam = $n[$k];
                $n[$k] = $n[$i];
                $n[$i] = $tam;
            }
        }
    }
    return $n;
}
?>