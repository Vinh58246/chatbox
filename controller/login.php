<?php
error_reporting(0);

header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Credentials: true');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Request-With');
session_start();
include "../model/user.php";

$requestMethod = $_SERVER['REQUEST_METHOD'];

if($requestMethod == "POST"){

    $inputData = json_decode(file_get_contents("php://input"), true);
    $loginUser = loginUser($inputData);
    echo $loginUser;
    // echo $_SESSION['idCookie'];

}
else{
    $data = [
        "status" => 405,
        "message" => "$requestMethod. ' Method Not Allowed'",
    ];
    header('HTTP/1.0 405 Method Not Allowed');
    echo json_encode($data);
}
?>