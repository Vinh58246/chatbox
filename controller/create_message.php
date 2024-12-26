<?php
header('Access-Control-Allow-Origin:*');
// header('Access-Control-Allow-Credentials', 'true');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Request-With');
session_start();
include "../model/message.php";

$requestMethod = $_SERVER['REQUEST_METHOD'];

if($requestMethod == "POST"){

    $inputData = json_decode(file_get_contents("php://input"),true);
    if(empty($inputData)){
        $handleMessage = handleMessage($_POST);
    }else{
        $handleMessage = handleMessage($inputData);
    }
    echo $handleMessage;

}
else{
    $data = [
        'status' => 405,
        'message' => $requestMethod. ' Method Not Allowed',
    ];
    header('HTTP/1.0 405 Method Not Allowed');
    echo json_encode($data);
}
?>