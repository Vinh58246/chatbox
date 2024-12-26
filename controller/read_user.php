<?php
header('Access-Control-Allow-Origin:*');
// header('Access-Control-Allow-Credentials', 'true');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Request-With');
session_start();
include "../model/user.php";

$requestMethod = $_SERVER['REQUEST_METHOD'];

if($requestMethod == "GET"){

    if(isset($_GET['ok'])){
        $readUser = readUser($_GET['ok']);
        echo $readUser;
    }
    else{
        $data = [
            'status' => 401,
            'message' => 'Cookie Not Found',
        ];
        header('HTTP/1.0 401 Cookie Not Found');
        echo json_encode($data);
    }
    
}
else{
    // hiển thị lỗi khi không phải phương thức POST
    $data = [
        'status' => 405,
        'message' => $requestMethod. ' Method Not Allowed',
    ];
    header('HTTP/1.0 405 Method Not Allowed');
    echo json_encode($data);
}

?>