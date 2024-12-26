<?php
require "../database.php";

function createEmoji($inputdata){
    $icon = $inputdata['icon'];
    $idmessage = $inputdata['id_message'];

    // $data = [
    //     'status' => 200,
    //     'message' => $icon,
    //     'message2' => $idmessage,
    // ];
    // header('HTTP/1.0 200 Emoji Create Successfully');
    // return json_encode($data);
    // exit();
    if(checkemoji($idmessage, $_SESSION['idCookie']['iduser']) == 1){
        $conn = connect();
        $sql = "UPDATE emoji SET icon=:icon WHERE id_message_icon=:id_message AND id_user_icon=:id_user";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':icon', $icon);
        $stmt->bindParam(':id_message', $idmessage);
        $stmt->bindParam(':id_user', $_SESSION['idCookie']['iduser']);
        $stmt->execute();
        if($stmt){
            $data = [
                'status' => 200,
                'message' => 'Emoji Create Successfully',
            ];
            header('HTTP/1.0 200 Emoji Create Successfully');
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
    $conn = connect();
    $sql = "INSERT INTO emoji SET icon=:icon, id_message_icon=:id_message, id_user_icon=:id_user, ho_ten_drop=:ho_ten_drop";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':icon', $icon, PDO::PARAM_STR);
    $stmt->bindParam(':id_message', $idmessage, PDO::PARAM_INT);
    $stmt->bindParam(':id_user', $_SESSION['idCookie']['iduser'], PDO::PARAM_INT);
    $stmt->bindParam(':ho_ten_drop', $_SESSION['idCookie']['hoten'], PDO::PARAM_STR);
    $stmt->execute();
    if($stmt){
        $data = [
            'status' => 200,
            'message' => 'Emoji Create Successfully',
        ];
        header('HTTP/1.0 200 Emoji Create Successfully');
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

function checkemoji($idmessage, $iduser){
    $conn = connect();
    $sql = "SELECT * FROM emoji WHERE id_message_icon=:id_message AND id_user_icon=:id_user";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':id_message', $idmessage, PDO::PARAM_INT);
    $stmt->bindParam(':id_user', $iduser, PDO::PARAM_INT);
    $stmt->execute();
    $check = $stmt->rowCount();
    return $check;
}
?>