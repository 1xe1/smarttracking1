<?php
header('Access-Control-Allow-Origin: *');
include "./conn.php";

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get data from the request
    $id_card = isset($_POST['id_card']) ? $_POST['id_card'] : '';
    $titlename = isset($_POST['titlename']) ? $_POST['titlename'] : '';
    $firstname = isset($_POST['firstname']) ? $_POST['firstname'] : '';
    $lastname = isset($_POST['lastname']) ? $_POST['lastname'] : '';
    $date_of_birth = isset($_POST['date_of_birth']) ? $_POST['date_of_birth'] : '';
    $heart_value = isset($_POST['heart_value']) ? $_POST['heart_value'] : '';
    $pulse_value = isset($_POST['pulse_value']) ? $_POST['pulse_value'] : '';

    // Insert new record into the health_db table
    $sqlInsert = "INSERT INTO health_db (id_card, titlename, firstname, lastname, date_of_birth, heart_value, pulse_value)
                  VALUES ('$id_card', '$titlename', '$firstname', '$lastname', '$date_of_birth', '$heart_value', '$pulse_value')";
    $resultInsert = mysqli_query($conn, $sqlInsert);

    if ($resultInsert) {
        // Send success response code
        http_response_code(200);
        echo json_encode(array("message" => "Data inserted successfully"));
    } else {
        // Send error response code
        http_response_code(500);
        echo json_encode(array("message" => "Error inserting data into the database"));
    }
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(array("message" => "Invalid Request Method"));
}

// Close the database connection
mysqli_close($conn);
?>
