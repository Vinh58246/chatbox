<?php
const DB_HOST = "localhost" ;
const DB_NAME = "send_message";
const DB_USER = "root";
const DB_PASS = "";

function connect()
{
    $sv_data = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME;

    try {
        // Với mysql là tên của DBMS, localhost có ý nghĩa database được đặt trên cùng server, izlearn là tên của database. $username và $password là 2 biến chứa thông tin xác thực.
        $conn = new PDO($sv_data, DB_USER, DB_PASS, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"));
        
        // set the PDO error mode to exception
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        // echo "Connected Successfully";
        return $conn;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
}
// hàm gọi
function call_data($sql)
{
    $conn = connect();
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    return $stmt;
}

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


$sql1 = 'SELECT * FROM user INNER JOIN message ON user.id_user = message.id_user ORDER BY id_message DESC';
$stmt = call_data($sql1);
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


echo "<pre>";
// var_export($mes);
var_export($ui);
// var_export($ui);
// var_export($ic);
echo "</pre>";





?>