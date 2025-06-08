<?php
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'listrik3'; // Nama database

$koneksi = mysql_connect($host, $username, $password);

// Cek koneksi
if (!$koneksi) {
    die('Koneksi gagal: ' . mysql_error());
}
// echo "Koneksi server berhasil<br>"; // Untuk debugging

$pilih_db = mysql_select_db($dbname, $koneksi);

if (!$pilih_db) {
    die('Tidak bisa memilih database: ' . mysql_error());
}
// echo "Database berhasil dipilih<br>"; // Untuk debugging
