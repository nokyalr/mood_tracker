<?php
// Include koneksi database
include('db.php');

// Menampilkan error jika ada masalah
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Membaca data JSON dari request
$data = json_decode(file_get_contents("php://input"), true);

// Pastikan data yang diterima lengkap
if (!isset($data['username'], $data['password'])) {
    echo json_encode(["success" => false, "message" => "Incomplete data"]);
    exit;
}

// Mendapatkan data dari JSON
$username = $data['username'];
$password = password_hash($data['password'], PASSWORD_DEFAULT); // Hashing password

// Memeriksa koneksi ke database
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Menyiapkan query dengan prepared statement untuk menghindari SQL Injection
$query = "INSERT INTO users (username, password) 
          VALUES (?, ?)";

$stmt = mysqli_prepare($conn, $query);

// Mengikat parameter untuk prepared statement
mysqli_stmt_bind_param($stmt, "ss", $username, $password);

// Menjalankan query
if (mysqli_stmt_execute($stmt)) {
    echo json_encode(["success" => true, "message" => "User successfully registered"]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . mysqli_error($conn)]);
}

// Menutup statement dan koneksi
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
