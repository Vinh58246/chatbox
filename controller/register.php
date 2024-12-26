<?php
error_reporting(0);

header('Access-Control-Allow-Origin:*');
// header('Access-Control-Allow-Credentials', 'true');
header('Content-Type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Request-With');
session_start();
include "../model/user.php";

$requestMethod = $_SERVER['REQUEST_METHOD'];

if($requestMethod == 'POST'){

    // hàm json_decode để chuyển file json về lại mã code cổ điển
    // hàm file_get_contents để lấy nội dung được truyền vào qua phương thức post
    $inputData = json_decode(file_get_contents("php://input"),true);
    if(empty($inputData)){
        $register = register($_POST);
    }else{
        $register = register($inputData);
    }
    echo $register;


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