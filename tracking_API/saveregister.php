<?php
header('Access-Control-Allow-Origin: *');
include "./conn.php";
$firstname = isset($_REQUEST['firstname']) ? $_REQUEST['firstname'] : '';
$lastname = isset($_REQUEST['lastname']) ? $_REQUEST['lastname'] : '';
$email = isset($_REQUEST['email']) ? $_REQUEST['email'] : '';
$password = isset($_REQUEST['password']) ? $_REQUEST['password'] : '';
$user_id = isset($_REQUEST['user_id']) ? $_REQUEST['user_id'] : '';
$no = 1;

//=== คำนวณหาเลขที่ ID ล่าสุด ===
$sql = "SELECT MAX(user_id) AS MAX_ID FROM register ";
$objQuery = mysqli_query($conn, $sql) or die(mysqli_error($conn));

while ($row1 = mysqli_fetch_array($objQuery)) {
    if ($row1["MAX_ID"] != "") {
        $no = $row1["MAX_ID"] + 1;
    }
}

$newno = "0000" . (string) $no;
$newno = substr($newno, -5);
$newuserid = $newno;

$sql = "INSERT INTO register(user_id, firstname, email, password, lastname) VALUES ('$newuserid', '$firstname', '$email',  '$password', '$lastname')";
mysqli_query($conn, $sql);
http_response_code(200);
?>
