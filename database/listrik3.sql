-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Jun 2025 pada 08.02
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `listrik3`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pelanggan` (IN `p_id_pelanggan` VARCHAR(14), IN `p_nama` VARCHAR(50), IN `p_alamat` TEXT, IN `p_id_tarif` INT)   BEGIN
    UPDATE pelanggan 
    SET 
        nama = CASE WHEN p_nama IS NOT NULL THEN p_nama ELSE nama END,
        alamat = CASE WHEN p_alamat IS NOT NULL THEN p_alamat ELSE alamat END,
        id_tarif = CASE WHEN p_id_tarif IS NOT NULL THEN p_id_tarif ELSE id_tarif END
    WHERE id_pelanggan = p_id_pelanggan;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_total` (`jumlah_meter` INT, `tarif_perkwh` DECIMAL(10,2)) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE total DECIMAL(10,2);
    SET total = jumlah_meter * tarif_perkwh;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `agen`
--

CREATE TABLE `agen` (
  `id_agen` varchar(12) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(15) NOT NULL,
  `saldo` double NOT NULL,
  `biaya_admin` double NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `akses` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `agen`
--

INSERT INTO `agen` (`id_agen`, `nama`, `alamat`, `no_telepon`, `saldo`, `biaya_admin`, `username`, `password`, `akses`) VALUES
('A20180125001', 'Zidan', 'Bekasi', '088214360798', 0, 2000, 'agen', 'agen123', 'agen'),
('A20180129001', 'MiuJiu Store', 'Sumber Jaya', '087813612611', 0, 2500, 'miujiu', 'miujiu123', 'agen');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` varchar(14) NOT NULL,
  `no_meter` varchar(12) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `tenggang` varchar(2) NOT NULL,
  `id_tarif` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `no_meter`, `nama`, `alamat`, `tenggang`, `id_tarif`) VALUES
('20250607154737', '157250661537', 'Zidan Akmal', 'Panorama Blok B1 No 20', '07', 19),
('20250607154759', '157250661559', 'Kardiman', 'Panorama Blok B1 No 18', '07', 18),
('20250607154829', '157250661529', 'Gilang Ramadhan', 'Panorama Blok B2 No 5', '07', 19),
('20250607154858', '157250661558', 'Bengkel Putra Jaya', 'Panorama', '07', 21),
('20250607154918', '157250661518', 'Meira Mantopin Istiqomah', 'Panorama Blok F2 No 21', '07', 20),
('20250607154956', '157250661556', 'Kedai Mama Lintar', 'Panorama Blok I2 No 13', '07', 20),
('20250607161202', '157250661602', 'Pabrik Tahu ', 'Panorama Blok F8 No 7-8', '07', 22);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(15) NOT NULL,
  `id_pelanggan` varchar(14) NOT NULL,
  `tgl_bayar` date NOT NULL,
  `waktu_bayar` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bulan_bayar` varchar(2) NOT NULL,
  `tahun_bayar` year(4) NOT NULL,
  `jumlah_bayar` double NOT NULL,
  `biaya_admin` double NOT NULL,
  `total_akhir` double NOT NULL,
  `bayar` double NOT NULL,
  `kembali` double NOT NULL,
  `id_agen` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pelanggan`, `tgl_bayar`, `waktu_bayar`, `bulan_bayar`, `tahun_bayar`, `jumlah_bayar`, `biaya_admin`, `total_akhir`, `bayar`, `kembali`, `id_agen`) VALUES
('BYR202506080001', '20250607154737', '2025-06-08', '2025-06-08 04:15:55', '06', '2025', 361250, 2000, 363250, 400000, 36750, 'A20180125001'),
('BYR202506080002', '20250607154918', '2025-06-08', '2025-06-08 05:08:02', '06', '2025', 450840, 2000, 452840, 455000, 2160, 'A20180125001'),
('BYR202506080003', '20250607154829', '2025-06-08', '2025-06-08 05:14:49', '06', '2025', 231200, 2000, 233200, 235000, 1800, 'A20180125001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penggunaan`
--

CREATE TABLE `penggunaan` (
  `id_penggunaan` varchar(20) NOT NULL,
  `id_pelanggan` varchar(14) NOT NULL,
  `bulan` varchar(2) NOT NULL,
  `tahun` year(4) NOT NULL,
  `meter_awal` int(11) NOT NULL,
  `meter_akhir` int(11) NOT NULL,
  `tgl_cek` date NOT NULL,
  `id_petugas` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penggunaan`
--

INSERT INTO `penggunaan` (`id_penggunaan`, `id_pelanggan`, `bulan`, `tahun`, `meter_awal`, `meter_akhir`, `tgl_cek`, `id_petugas`) VALUES
('20250607154737062025', '20250607154737', '06', '2025', 0, 250, '2025-06-20', 'P20180129001'),
('20250607154737072025', '20250607154737', '07', '2025', 250, 0, '0000-00-00', ''),
('20250607154759062025', '20250607154759', '06', '2025', 0, 0, '0000-00-00', ''),
('20250607154829062025', '20250607154829', '06', '2025', 0, 160, '2025-06-24', 'P20180129001'),
('20250607154829072025', '20250607154829', '07', '2025', 160, 0, '0000-00-00', ''),
('20250607154858062025', '20250607154858', '06', '2025', 0, 0, '0000-00-00', ''),
('20250607154918062025', '20250607154918', '06', '2025', 0, 312, '2025-06-25', 'P20180129001'),
('20250607154918072025', '20250607154918', '07', '2025', 312, 0, '0000-00-00', ''),
('20250607154956062025', '20250607154956', '06', '2025', 0, 0, '0000-00-00', ''),
('20250607161202062025', '20250607161202', '06', '2025', 0, 0, '0000-00-00', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `id_petugas` varchar(12) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(15) NOT NULL,
  `jk` varchar(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `akses` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `petugas`
--

INSERT INTO `petugas` (`id_petugas`, `nama`, `alamat`, `no_telepon`, `jk`, `username`, `password`, `akses`) VALUES
('P20180125001', 'Muhammad Ramdan', 'Sukabirus', '083811941421', 'L', 'petugas', 'petugas123', 'petugas'),
('P20180129001', 'Zidan Akmal Al Baihaqi', 'Bekasi', '081236276172', 'L', 'zidan', 'aku123', 'petugas');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_pembayaran`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_pembayaran` (
`id_pembayaran` varchar(15)
,`id_pelanggan` varchar(14)
,`tgl_bayar` date
,`waktu_bayar` timestamp
,`bulan_bayar` varchar(2)
,`tahun_bayar` year(4)
,`jumlah_bayar` double
,`biaya_admin` double
,`total_akhir` double
,`bayar` double
,`kembali` double
,`id_agen` varchar(12)
,`nama_pelanggan` varchar(50)
,`nama_agen` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_penggunaan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_penggunaan` (
`id_penggunaan` varchar(20)
,`id_pelanggan` varchar(14)
,`bulan` varchar(2)
,`tahun` year(4)
,`meter_awal` int(11)
,`meter_akhir` int(11)
,`tgl_cek` date
,`id_petugas` varchar(12)
,`nama_pelanggan` varchar(50)
,`nama_petugas` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_tagihan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_tagihan` (
`id_tagihan` int(11)
,`id_pelanggan` varchar(14)
,`bulan` varchar(2)
,`tahun` year(4)
,`jumlah_meter` int(11)
,`tarif_perkwh` double
,`jumlah_bayar` double
,`status` varchar(15)
,`id_petugas` varchar(12)
,`nama_pelanggan` varchar(50)
,`id_tarif` int(11)
,`nama_petugas` varchar(50)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tagihan`
--

CREATE TABLE `tagihan` (
  `id_tagihan` int(11) NOT NULL,
  `id_pelanggan` varchar(14) NOT NULL,
  `bulan` varchar(2) NOT NULL,
  `tahun` year(4) NOT NULL,
  `jumlah_meter` int(11) NOT NULL,
  `tarif_perkwh` double NOT NULL,
  `jumlah_bayar` double NOT NULL,
  `status` varchar(15) NOT NULL,
  `id_petugas` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `tagihan`
--

INSERT INTO `tagihan` (`id_tagihan`, `id_pelanggan`, `bulan`, `tahun`, `jumlah_meter`, `tarif_perkwh`, `jumlah_bayar`, `status`, `id_petugas`) VALUES
(30, '20250607154737', '06', '2025', 250, 1445, 361250, 'Terbayar', 'P20180129001'),
(32, '20250607154918', '06', '2025', 312, 1445, 450840, 'Terbayar', 'P20180129001'),
(33, '20250607154829', '06', '2025', 160, 1445, 231200, 'Terbayar', 'P20180129001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tarif`
--

CREATE TABLE `tarif` (
  `id_tarif` int(11) NOT NULL,
  `kode_tarif` varchar(20) NOT NULL,
  `golongan` varchar(10) NOT NULL,
  `daya` varchar(10) NOT NULL,
  `tarif_perkwh` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `tarif`
--

INSERT INTO `tarif` (`id_tarif`, `kode_tarif`, `golongan`, `daya`, `tarif_perkwh`) VALUES
(3, 'R3/450VA', 'R3', '450VA', 0),
(17, 'R1/450VA', 'R1', '450VA', 415),
(18, 'R1/900VA', 'R1', '900VA', 1352),
(19, 'R1/1300VA', 'R1', '1300VA', 1445),
(20, 'R1/2200VA', 'R1', '2200VA', 1445),
(21, 'R2/3500VA', 'R2', '3500VA', 1700),
(22, 'R2/4400VA', 'R2', '4400VA', 1700),
(23, 'R2/5500VA', 'R2', '5500VA', 1700),
(24, 'R3/6600VA', 'R3', '6600VA', 1700),
(29, 'B2/6600VA', 'B2', '6600VA', 1445);

--
-- Trigger `tarif`
--
DELIMITER $$
CREATE TRIGGER `validate_tarif_before_insert` BEFORE INSERT ON `tarif` FOR EACH ROW BEGIN
    -- Validasi tarif tidak boleh negatif
    IF NEW.tarif_perkwh < 0 THEN
        SET NEW.tarif_perkwh = 0; -- Auto-koreksi ke 0 jika negatif
    END IF;
    
    -- Validasi daya tidak kosong
    IF NEW.daya IS NULL OR NEW.daya = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Daya tidak boleh kosong';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_pembayaran`
--
DROP TABLE IF EXISTS `qw_pembayaran`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_pembayaran`  AS SELECT `pembayaran`.`id_pembayaran` AS `id_pembayaran`, `pembayaran`.`id_pelanggan` AS `id_pelanggan`, `pembayaran`.`tgl_bayar` AS `tgl_bayar`, `pembayaran`.`waktu_bayar` AS `waktu_bayar`, `pembayaran`.`bulan_bayar` AS `bulan_bayar`, `pembayaran`.`tahun_bayar` AS `tahun_bayar`, `pembayaran`.`jumlah_bayar` AS `jumlah_bayar`, `pembayaran`.`biaya_admin` AS `biaya_admin`, `pembayaran`.`total_akhir` AS `total_akhir`, `pembayaran`.`bayar` AS `bayar`, `pembayaran`.`kembali` AS `kembali`, `pembayaran`.`id_agen` AS `id_agen`, `pelanggan`.`nama` AS `nama_pelanggan`, `agen`.`nama` AS `nama_agen` FROM ((`pembayaran` join `pelanggan` on(`pelanggan`.`id_pelanggan` = `pembayaran`.`id_pelanggan`)) join `agen` on(`agen`.`id_agen` = `pembayaran`.`id_agen`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_penggunaan`
--
DROP TABLE IF EXISTS `qw_penggunaan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_penggunaan`  AS SELECT `penggunaan`.`id_penggunaan` AS `id_penggunaan`, `penggunaan`.`id_pelanggan` AS `id_pelanggan`, `penggunaan`.`bulan` AS `bulan`, `penggunaan`.`tahun` AS `tahun`, `penggunaan`.`meter_awal` AS `meter_awal`, `penggunaan`.`meter_akhir` AS `meter_akhir`, `penggunaan`.`tgl_cek` AS `tgl_cek`, `penggunaan`.`id_petugas` AS `id_petugas`, `pelanggan`.`nama` AS `nama_pelanggan`, `petugas`.`nama` AS `nama_petugas` FROM ((`penggunaan` join `pelanggan` on(`penggunaan`.`id_pelanggan` = `pelanggan`.`id_pelanggan`)) join `petugas` on(`penggunaan`.`id_petugas` = `petugas`.`id_petugas`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_tagihan`
--
DROP TABLE IF EXISTS `qw_tagihan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_tagihan`  AS SELECT `tagihan`.`id_tagihan` AS `id_tagihan`, `tagihan`.`id_pelanggan` AS `id_pelanggan`, `tagihan`.`bulan` AS `bulan`, `tagihan`.`tahun` AS `tahun`, `tagihan`.`jumlah_meter` AS `jumlah_meter`, `tagihan`.`tarif_perkwh` AS `tarif_perkwh`, `tagihan`.`jumlah_bayar` AS `jumlah_bayar`, `tagihan`.`status` AS `status`, `tagihan`.`id_petugas` AS `id_petugas`, `pelanggan`.`nama` AS `nama_pelanggan`, `pelanggan`.`id_tarif` AS `id_tarif`, `petugas`.`nama` AS `nama_petugas` FROM ((`tagihan` join `pelanggan` on(`pelanggan`.`id_pelanggan` = `tagihan`.`id_pelanggan`)) join `petugas` on(`petugas`.`id_petugas` = `tagihan`.`id_petugas`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `agen`
--
ALTER TABLE `agen`
  ADD PRIMARY KEY (`id_agen`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indeks untuk tabel `penggunaan`
--
ALTER TABLE `penggunaan`
  ADD PRIMARY KEY (`id_penggunaan`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id_petugas`);

--
-- Indeks untuk tabel `tagihan`
--
ALTER TABLE `tagihan`
  ADD PRIMARY KEY (`id_tagihan`);

--
-- Indeks untuk tabel `tarif`
--
ALTER TABLE `tarif`
  ADD PRIMARY KEY (`id_tarif`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tagihan`
--
ALTER TABLE `tagihan`
  MODIFY `id_tagihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `tarif`
--
ALTER TABLE `tarif`
  MODIFY `id_tarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
