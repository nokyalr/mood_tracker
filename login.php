<?php
// Memulai session
session_start();

// Menghubungkan ke database
include('db.php');  // Menghubungkan ke file connect.php yang sudah dibuat sebelumnya

// Mendapatkan data yang dikirim dari Flutter
$data = json_decode(file_get_contents('php://input'), true);
$username = $data['username'];
$password = $data['password'];

// Validasi input
if (empty($username) || empty($password)) {
    echo json_encode([
        'success' => false,
        'message' => 'Username atau password tidak boleh kosong',
    ]);
    exit();
}

// Query untuk memeriksa username dan password
$query = "SELECT * FROM users WHERE username = ? LIMIT 1"; // Menggunakan parameterized query untuk mencegah SQL injection
$stmt = $conn->prepare($query);
$stmt->bind_param('s', $username);  // 's' menunjukkan tipe data string untuk username
$stmt->execute();
$result = $stmt->get_result();

// Memeriksa apakah ada user dengan username yang dimasukkan
$user = $result->fetch_assoc();

if ($user && password_verify($password, $user['password'])) {
    // Jika login berhasil, simpan user_id ke session
    $_SESSION['user_id'] = $user['id'];

    // Kirimkan respons sukses dengan user_id
    echo json_encode([
        'success' => true,
        'message' => 'Login berhasil',
        'user_id' => $user['id'],
    ]);
} else {
    // Jika login gagal
    echo json_encode([
        'success' => false,
        'message' => 'Username atau password salah',
    ]);
}

// Menutup koneksi
$stmt->close();
$conn->close();
?>
