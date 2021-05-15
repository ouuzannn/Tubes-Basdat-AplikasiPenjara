-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2021 at 01:51 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjara`
--

-- --------------------------------------------------------

--
-- Table structure for table `cabang_lapas`
--

CREATE TABLE `cabang_lapas` (
  `nama_lapas` varchar(50) NOT NULL,
  `nama_kepala` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `no_telp` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cabang_lapas`
--

INSERT INTO `cabang_lapas` (`nama_lapas`, `nama_kepala`, `alamat`, `no_telp`) VALUES
('Lapas Sukamiskin', 'Akmal Fauzan Suranta', 'Jl. A.H. Nasution No. 114', '083398765432');

-- --------------------------------------------------------

--
-- Table structure for table `kunjungan`
--

CREATE TABLE `kunjungan` (
  `no_ktp` char(12) CHARACTER SET latin1 NOT NULL,
  `nama_pengunjung` varchar(50) NOT NULL,
  `no_tahanan` char(5) CHARACTER SET latin1 DEFAULT NULL,
  `waktu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kunjungan`
--

INSERT INTO `kunjungan` (`no_ktp`, `nama_pengunjung`, `no_tahanan`, `waktu`) VALUES
('123456789009', 'Adji', '31001', '2021-05-12');

-- --------------------------------------------------------

--
-- Table structure for table `napi`
--

CREATE TABLE `napi` (
  `no_tahanan` char(5) NOT NULL,
  `nama_tahanan` varchar(50) DEFAULT NULL,
  `lama_penahanan` int(3) DEFAULT NULL,
  `kasus` varchar(20) DEFAULT NULL,
  `tahun_masuk` char(10) DEFAULT NULL,
  `tahun_keluar` char(10) DEFAULT NULL,
  `no_ruangan` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `napi`
--

INSERT INTO `napi` (`no_tahanan`, `nama_tahanan`, `lama_penahanan`, `kasus`, `tahun_masuk`, `tahun_keluar`, `no_ruangan`) VALUES
('11001', 'Muhammad Eka', 7, 'Perampokan', '2020', '2027', 'A001'),
('21001', 'Ika Agus', 5, 'Pembegalan', '2018', '2023', 'B001'),
('21002', 'Rizpo', 4, 'Penipuan', '2019', '2023', 'B001'),
('31001', 'Wahyu Putra', 2, 'Pencurian', '2021', '2022', 'C001');

-- --------------------------------------------------------

--
-- Table structure for table `no_hp_pegawai`
--

CREATE TABLE `no_hp_pegawai` (
  `ID_pegawai` char(5) DEFAULT NULL,
  `no_hp` char(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `no_hp_pegawai`
--

INSERT INTO `no_hp_pegawai` (`ID_pegawai`, `no_hp`) VALUES
('PK001', '089912345678'),
('PK002', '089956743210'),
('PS001', '084567832415'),
('PS002', '085587501243'),
('PS003', '089900754307'),
('PS004', '084532154637');

-- --------------------------------------------------------

--
-- Table structure for table `no_hp_pengunjung`
--

CREATE TABLE `no_hp_pengunjung` (
  `no_ktp` char(12) DEFAULT NULL,
  `no_hp` char(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `ID_pegawai` char(5) NOT NULL,
  `nama_pegawai` varchar(50) DEFAULT NULL,
  `nama_lapas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`ID_pegawai`, `nama_pegawai`, `nama_lapas`) VALUES
('PB001', 'Panji Dwi', 'Lapas Sukamiskin'),
('PK001', 'Ahmad syarif', 'Lapas Sukamiskin'),
('PK002', 'Fajar Bayu', 'Lapas Sukamiskin'),
('PS001', 'M. Bagus', 'Lapas Sukamiskin'),
('PS002', 'Arief Hidayat', 'Lapas Sukamiskin'),
('PS003', 'Raden Hadi', 'Lapas Sukamiskin'),
('PS004', 'Rizky Abdul', 'Lapas Sukamiskin');

-- --------------------------------------------------------

--
-- Table structure for table `pengunjung`
--

CREATE TABLE `pengunjung` (
  `no_ktp` char(12) NOT NULL,
  `nama_pengunjung` varchar(50) NOT NULL,
  `alamat_pengunjung` varchar(20) NOT NULL,
  `no_tahanan` char(5) NOT NULL,
  `waktu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengunjung`
--

INSERT INTO `pengunjung` (`no_ktp`, `nama_pengunjung`, `alamat_pengunjung`, `no_tahanan`, `waktu`) VALUES
('123456789009', 'Adji', 'Ketapang', '31001', NULL),
('137112021001', 'Diah Agustina', 'Bandar Lampung', 'KA001', '2015-03-21'),
('137112021002', 'Desi', 'Lampung Selatan', 'KB001', '2017-04-21');

-- --------------------------------------------------------

--
-- Table structure for table `petugas_kebersihan`
--

CREATE TABLE `petugas_kebersihan` (
  `ID_pegawai` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `petugas_kebersihan`
--

INSERT INTO `petugas_kebersihan` (`ID_pegawai`) VALUES
('PK001'),
('PK002');

-- --------------------------------------------------------

--
-- Table structure for table `ruang_lapas`
--

CREATE TABLE `ruang_lapas` (
  `no_ruangan` char(4) NOT NULL,
  `kapasitas` int(4) DEFAULT NULL,
  `kelas` char(6) DEFAULT NULL,
  `nama_lapas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruang_lapas`
--

INSERT INTO `ruang_lapas` (`no_ruangan`, `kapasitas`, `kelas`, `nama_lapas`) VALUES
('A001', 80, 'A', 'Lapas Sukamiskin'),
('B001', 100, 'B', 'Lapas Sukamiskin'),
('C001', 90, 'C', 'Lapas Sukamiskin'),
('C002', 50, 'C', 'Lapas Sukamiskin');

-- --------------------------------------------------------

--
-- Table structure for table `sipir`
--

CREATE TABLE `sipir` (
  `no_ruangan` char(4) DEFAULT NULL,
  `ID_pegawai` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sipir`
--

INSERT INTO `sipir` (`no_ruangan`, `ID_pegawai`) VALUES
('A001', 'PS001'),
('B001', 'PS002'),
('C001', 'PS003'),
('C002', 'PS004');

-- --------------------------------------------------------

--
-- Table structure for table `usulanremisi`
--

CREATE TABLE `usulanremisi` (
  `no_tahanan` char(5) CHARACTER SET latin1 NOT NULL,
  `Pengurangan_Masa` int(2) NOT NULL,
  `Tahun_Masuk` char(10) NOT NULL,
  `Tahun_Keluar` char(10) NOT NULL,
  `alasan` varchar(200) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang_lapas`
--
ALTER TABLE `cabang_lapas`
  ADD PRIMARY KEY (`nama_lapas`);

--
-- Indexes for table `kunjungan`
--
ALTER TABLE `kunjungan`
  ADD KEY `no_ktp` (`no_ktp`),
  ADD KEY `no_tahanan` (`no_tahanan`);

--
-- Indexes for table `napi`
--
ALTER TABLE `napi`
  ADD PRIMARY KEY (`no_tahanan`),
  ADD KEY `no_ruangan` (`no_ruangan`);

--
-- Indexes for table `no_hp_pegawai`
--
ALTER TABLE `no_hp_pegawai`
  ADD PRIMARY KEY (`no_hp`),
  ADD KEY `ID_pegawai` (`ID_pegawai`);

--
-- Indexes for table `no_hp_pengunjung`
--
ALTER TABLE `no_hp_pengunjung`
  ADD PRIMARY KEY (`no_hp`),
  ADD KEY `no_ktp` (`no_ktp`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`ID_pegawai`),
  ADD KEY `nama_lapas` (`nama_lapas`);

--
-- Indexes for table `pengunjung`
--
ALTER TABLE `pengunjung`
  ADD PRIMARY KEY (`no_ktp`),
  ADD KEY `no_tahanan` (`no_tahanan`);

--
-- Indexes for table `petugas_kebersihan`
--
ALTER TABLE `petugas_kebersihan`
  ADD PRIMARY KEY (`ID_pegawai`);

--
-- Indexes for table `ruang_lapas`
--
ALTER TABLE `ruang_lapas`
  ADD PRIMARY KEY (`no_ruangan`),
  ADD KEY `nama_lapas` (`nama_lapas`);

--
-- Indexes for table `sipir`
--
ALTER TABLE `sipir`
  ADD PRIMARY KEY (`ID_pegawai`),
  ADD KEY `no_ruangan` (`no_ruangan`);

--
-- Indexes for table `usulanremisi`
--
ALTER TABLE `usulanremisi`
  ADD KEY `no_tahanan` (`no_tahanan`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `no_hp_pegawai`
--
ALTER TABLE `no_hp_pegawai`
  ADD CONSTRAINT `no_hp_pegawai_ibfk_1` FOREIGN KEY (`ID_pegawai`) REFERENCES `pegawai` (`ID_pegawai`) ON DELETE CASCADE;

--
-- Constraints for table `no_hp_pengunjung`
--
ALTER TABLE `no_hp_pengunjung`
  ADD CONSTRAINT `no_hp_pengunjung_ibfk_1` FOREIGN KEY (`no_ktp`) REFERENCES `pengunjung` (`no_ktp`) ON UPDATE CASCADE;

--
-- Constraints for table `usulanremisi`
--
ALTER TABLE `usulanremisi`
  ADD CONSTRAINT `usulanremisi_ibfk_1` FOREIGN KEY (`no_tahanan`) REFERENCES `napi` (`no_tahanan`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
