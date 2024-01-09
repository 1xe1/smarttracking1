<?php
header('Access-Control-Allow-Origin: *');
include "./conn.php";

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get data from the request
    $imei_no = isset($_POST['imei_no']) ? $_POST['imei_no'] : '';
    $device_name = isset($_POST['device_name']) ? $_POST['device_name'] : '';

    // Insert new record into the tb_device table
    $sqlInsert = "INSERT INTO tb_device (imei_no, device_name) VALUES ('$imei_no', '$device_name')";
    $resultInsert = mysqli_query($conn, $sqlInsert);

    if ($resultInsert) {
        // Fetch all records from the tb_device table
        $sqlSelect = "SELECT * FROM tb_device";
        $resultSelect = mysqli_query($conn, $sqlSelect);

        // Check if the query was successful
        if ($resultSelect) {
            $output = array();

            // Fetch results
            while ($row = mysqli_fetch_assoc($resultSelect)) {
                $output[] = $row;
            }

            // Send response code and JSON data
            http_response_code(200);
            echo json_encode($output);
        } else {
            // Send error response code
            http_response_code(500);
            echo json_encode(array("message" => "Error fetching data from the database"));
        }
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
