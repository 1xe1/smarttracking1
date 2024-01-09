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

    // Validate and sanitize input data
    // ...

    // Check if the record with the specified id_card already exists
    $sqlCheckExisting = "SELECT * FROM health_db WHERE id_card = '$id_card'";
    $resultCheckExisting = mysqli_query($conn, $sqlCheckExisting);

    if (mysqli_num_rows($resultCheckExisting) > 0) {
        // If the record exists, update it
        $sqlUpdate = "UPDATE health_db 
                      SET titlename = '$titlename', 
                          firstname = '$firstname', 
                          lastname = '$lastname', 
                          date_of_birth = '$date_of_birth', 
                          heart_value = '$heart_value', 
                          pulse_value = '$pulse_value' 
                      WHERE id_card = '$id_card'";
        $resultUpdate = mysqli_query($conn, $sqlUpdate);

        if ($resultUpdate) {
            // Send success response code
            http_response_code(200);
            echo json_encode(array("message" => "Data updated successfully"));
        } else {
            // Send error response code
            http_response_code(500);
            echo json_encode(array("message" => "Error updating data in the database: " . mysqli_error($conn)));
        }
    } else {
        // If the record doesn't exist, send a response indicating that it cannot be updated
        http_response_code(404);
        echo json_encode(array("message" => "Record not found. Cannot update"));
    }
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(array("message" => "Invalid Request Method"));
}

// Close the database connection
mysqli_close($conn);
?>