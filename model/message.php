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

function handleMessage($inputData){
    $content = $inputData['content'];
    $img_content = strip_tags($inputData['img_content']);



    $iduser = $_SESSION['idCookie']['iduser'];
    $time = date('H:i:s');
    

    if(empty(trim($content)) && empty(trim($img_content))){
        return error422("Enter Your Content");
    }
    if(empty(trim($img_content))){
        $img_content = null;
    }
    $conn = connect();
    $sql = "INSERT INTO message SET content=:content, img_content=:img_content, id_user=:id_user, time_send=:time_send";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':content', $content, PDO::PARAM_STR);
    $stmt->bindParam(':img_content', $img_content, PDO::PARAM_STR);
    $stmt->bindParam(':id_user', $iduser, PDO::PARAM_INT);
    $stmt->bindParam(':time_send', $time, PDO::PARAM_STR);
    $stmt->execute();
    if($stmt){
        $data = [
            'status' => 201,
            'message' => 'Sent Successfully',
        ];
        header('HTTP/1.0 201 Sent');
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
?>