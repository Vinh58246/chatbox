<?php
require "config.php";

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
// connect();
// hàm gọi
function call_data($sql)
{
    $conn = connect();
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    return $stmt;
}
?>