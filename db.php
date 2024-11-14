<?php

$servername = "localhost";  // Nama host
$username = "sigwa";         // Username MySQL
$password = "123456";             // Password MySQL (kosongkan jika tidak ada password)
$dbname = "moodtracker";        // Nama database yang akan digunakan

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
} else {
    //echo "Koneksi berhasil ke database!";
}
?>
