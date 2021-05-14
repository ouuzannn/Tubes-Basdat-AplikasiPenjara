-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2021 at 09:45 AM
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
-- Database: `penjaralapasrevfinal`
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
('Jakarta', 'ojan', 'jakarta selatan', '088888');

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
('2120', 'ozan', '2', '2021-05-15'),
('1251', '', '34', '2021-05-17');

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
('013', 'esa', 3, 'maling ayam', '2020', '2021', '03'),
('0133', 'dodi', 2, 'maling', '2020', '2021', '3');

-- --------------------------------------------------------

--
-- Table structure for table `no_hp_pegawai`
--

CREATE TABLE `no_hp_pegawai` (
  `ID_pegawai` char(5) DEFAULT NULL,
  `no_hp` char(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('000', 'Asep', 'Jakarta'),
('009a', 'agus', 'Jakarta'),
('022', 'aa', 'Jakarta'),
('09', 'cecep', 'Jakarta'),
('212', 'ucup', 'Jakarta'),
('2222', 'thor', 'Jakarta');

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
('1251', 'gdsa', 'dsgsa', '34', NULL),
('20004', 'ozan', 'jl belwis', '012', NULL),
('2120', 'ozan', 'jl in', '2', '2021-05-15'),
('223', 'oz', 'jl sia', '012', '2021-05-13');

-- --------------------------------------------------------

--
-- Table structure for table `petugas_kebersihan`
--

CREATE TABLE `petugas_kebersihan` (
  `ID_pegawai` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('1', 10, 'A', 'Jakarta'),
('2', 20, 'B', 'Jakarta'),
('3', 30, 'C', 'Jakarta'),
('4', 40, 'D', 'Jakarta');

-- --------------------------------------------------------

--
-- Table structure for table `sipir`
--

CREATE TABLE `sipir` (
  `no_ruangan` char(4) DEFAULT NULL,
  `ID_pegawai` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD PRIMARY KEY (`no_hp`);

--
-- Indexes for table `no_hp_pengunjung`
--
ALTER TABLE `no_hp_pengunjung`
  ADD PRIMARY KEY (`no_hp`);

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
-- Constraints for table `usulanremisi`
--
ALTER TABLE `usulanremisi`
  ADD CONSTRAINT `usulanremisi_ibfk_1` FOREIGN KEY (`no_tahanan`) REFERENCES `napi` (`no_tahanan`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;