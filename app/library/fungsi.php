<?php  
	class oop{
		
		// Fungsi untuk menyimpan data ke database
		// $table = nama tabel, $field = array berisi kolom dan nilai yang akan disimpan
		function simpan($table,array $field){
			$sql = "INSERT INTO $table SET ";
			foreach ($field as $key => $value) {
				$sql.= "$key = '$value',";  // Membentuk query insert
			}
			$sql = rtrim($sql, ',');  // Menghapus koma terakhir
			$jalan = mysql_query($sql);  // Eksekusi query
		}

		// Fungsi untuk menampilkan data dari database dengan kondisi tertentu
		// $table = nama tabel, $where = klausa WHERE, $cari = kondisi pencarian tambahan
		function tampil($table,$where,$cari){
			$sql = mysql_query("SELECT * FROM $table $where $cari");  // Query select
			while ($data = mysql_fetch_array($sql)) 
				@$jalan[] = $data;  // Menyimpan hasil ke array
				return @$jalan;  // Mengembalikan array data
		}

		// Fungsi untuk mengambil satu data yang akan diedit berdasarkan kondisi
		// $table = nama tabel, $where = kondisi WHERE
		function edit($table,$where){
			$sql = "SELECT * FROM $table WHERE $where";  // Query select dengan kondisi
			$jalan = mysql_fetch_array(mysql_query($sql));  // Ambil satu baris data
			return $jalan;  // Kembalikan data
		}

		// Fungsi untuk menghapus data dari tabel berdasarkan kondisi
		// $table = nama tabel, $where = kondisi WHERE
		function hapus($table,$where){
			$sql = mysql_query("DELETE FROM $table WHERE $where");  // Query delete
			return $sql;  // Kembalikan hasil eksekusi query
		}

		// Fungsi untuk mengupdate data di tabel berdasarkan kondisi
		// $table = nama tabel, $field = array kolom dan nilai baru, $where = kondisi WHERE
		function update($table,array $field,$where){
			$sql = "UPDATE $table SET ";
			foreach ($field as $key => $value) {
				$sql.="$key = '$value',";  // Membentuk query update
			}
			$sql=rtrim($sql,',');  // Menghapus koma terakhir
			$sql .=" WHERE $where";  // Tambahkan kondisi WHERE
			$jalan = mysql_query($sql);  // Eksekusi query
		}

		// Fungsi mengambil satu baris data dari tabel, biasanya untuk cek data pertama
		function caridata($table){
			$sql = mysql_fetch_array(mysql_query("SELECT * FROM $table"));
			return $sql;
		}

		// Fungsi menghitung jumlah record dalam tabel
		function cekdata($table){
			$sql = mysql_num_rows(mysql_query("SELECT * FROM $table"));
			return $sql;
		}		

		// Fungsi menampilkan pesan alert JavaScript
		function pesan($pesan){
			echo "<script>alert('$pesan');</script>";
		}

		// Fungsi menampilkan pesan alert dan redirect ke alamat tertentu
		function alert($pesan,$alamat){
			echo "<script>alert('$pesan');document.location.href='$alamat'</script>";
		}

		// Fungsi redirect langsung ke alamat tertentu tanpa alert
		function redirect($alamat){
			echo "<script>document.location.href='$alamat'</script>";
		}

		// Fungsi menampilkan baris tabel dengan pesan "Data Tidak Ada"
		// $col = jumlah kolom yang akan digabung
		function no_record($col){
			echo "<tr><td colspan='$col' align='center'>Data Tidak Ada !!!</td></tr>";
		}

		// Fungsi menampilkan angka uang dalam format Rupiah
		function rupiah($uang){
			echo "Rp. ".number_format($uang,0,',','.').",-";
		}

		// Fungsi menampilkan nama bulan lengkap berdasarkan input angka bulan ('01'-'12')
		function bulan($bulan){
			switch ($bulan) {
				case '01':$bln="Januari";break;
				case '02':$bln="Februari";break;
				case '03':$bln="Maret";break;
				case '04':$bln="April";break;
				case '05':$bln="Mei";break;
				case '06':$bln="Juni";break;
				case '07':$bln="Juli";break;
				case '08':$bln="Agustus";break;
				case '09':$bln="September";break;
				case '10':$bln="Oktober";break;
				case '11':$bln="November";break;
				case '12':$bln="Desember";break;
				default:$bln="";break;
			}
			echo $bln;
		}

		// Fungsi menampilkan nama bulan singkat (3 huruf) berdasarkan input angka bulan
		function bulan_substr($bulan){
			switch ($bulan) {
				case '01':$bln="JAN";break;
				case '02':$bln="FEB";break;
				case '03':$bln="MAR";break;
				case '04':$bln="APR";break;
				case '05':$bln="MEI";break;
				case '06':$bln="JUN";break;
				case '07':$bln="JUL";break;
				case '08':$bln="AGU";break;
				case '09':$bln="SEP";break;
				case '10':$bln="OKT";break;
				case '11':$bln="NOV";break;
				case '12':$bln="DES";break;
				default:$bln="";break;
			}
			echo $bln;
		}

		// Fungsi menampilkan tanggal dalam format "tanggal bulan tahun" dengan nama bulan lengkap
		// Input format tanggal: YYYY-MM-DD
		function format_tanggal($tanggal){
			$tahun = substr($tanggal, 0,4);
			$bulan = substr($tanggal, 5,2);
			$tanggal = substr($tanggal, 8,2);
			switch ($bulan) {
				case '01':$bln="Januari";break;
				case '02':$bln="Februari";break;
				case '03':$bln="Maret";break;
				case '04':$bln="April";break;
				case '05':$bln="Mei";break;
				case '06':$bln="Juni";break;
				case '07':$bln="Juli";break;
				case '08':$bln="Agustus";break;
				case '09':$bln="September";break;
				case '10':$bln="Oktober";break;
				case '11':$bln="November";break;
				case '12':$bln="Desember";break;
				default:$bln="";break;
			}
			echo $tanggal." ".$bln." ".$tahun;
		}

		// Fungsi menampilkan nama hari dalam Bahasa Indonesia
		// $today adalah angka 1 sampai 7 (Senin sampai Minggu)
		function hari($today){
			switch ($today) {
				case '1': @$hari="Senin"; break;
				case '2': @$hari="Selasa"; break;
				case '3': @$hari="Rabu"; break;
				case '4': @$hari="Kamis"; break;
				case '5': @$hari="Jumat"; break;
				case '6': @$hari="Sabtu"; break;
				case '7': @$hari="Minggu"; break;
				default: @$hari=""; break;
			}
			echo @$hari;
		}

		// Fungsi login user dari tabel petugas atau agen
		// $table = nama tabel (petugas/agen), $username dan $password untuk login, $alamat redirect setelah login
		function login($table,$username,$password,$alamat){
			@session_start();
			$sql = mysql_query("SELECT * FROM $table WHERE username = '$username' AND password = '$password'");
			$cek = mysql_num_rows($sql);
			$data = mysql_fetch_array($sql);
			if ($cek > 0) {
				if ($table == "petugas") {
					// Simpan data session petugas
					@$_SESSION['username_petugas'] = $data['username'];
					@$_SESSION['id_petugas'] = $data['id_petugas'];
					@$_SESSION['nama_petugas'] = $data['nama'];
					@$_SESSION['akses_petugas'] = $data['akses'];
					$this->alert("Login Berhasil, Selamat Datang ".$data['nama'],$alamat);
				}elseif($table == "agen"){
					// Simpan data session agen
					@$_SESSION['username_agen'] = $data['username'];
					@$_SESSION['biaya_admin'] = $data['biaya_admin'];
					@$_SESSION['id_agen'] = $data['id_agen'];
					@$_SESSION['nama_agen'] = $data['nama'];
					@$_SESSION['akses_agen'] = $data['akses'];
					$this->alert("Login Berhasil, Selamat Datang ".$data['nama'],$alamat);
				}
			}else{
				$this->pesan("username atau password salah");  // Pesan error login
			}
		}

		// Fungsi upload file gambar/foto ke folder tujuan
		// $tempat = folder tujuan upload
		function upload($tempat){
			@$alamatfile = $_FILES['foto']['tmp_name'];  // File sementara di server
			@$namafile = $_FILES['foto']['name'];  // Nama file asli
			move_uploaded_file($alamatfile,"$tempat/$namafile");  // Pindah file ke folder tujuan
			return $namafile;  // Kembalikan nama file
		}

	}
?>