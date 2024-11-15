-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2024 at 11:59 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbskincare1`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id_brand` int(11) NOT NULL,
  `kode_brand` varchar(11) NOT NULL,
  `nama_brand` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id_brand`, `kode_brand`, `nama_brand`) VALUES
(2, 'BR1', 'Fifi Skin Klinik');

-- --------------------------------------------------------

--
-- Table structure for table `hasil`
--

CREATE TABLE `hasil` (
  `id_hasil` int(11) NOT NULL,
  `kode_hasil` varchar(255) NOT NULL,
  `nama_produk` varchar(150) NOT NULL,
  `kode_tipekulit` varchar(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `nilai` float NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hasil`
--

INSERT INTO `hasil` (`id_hasil`, `kode_hasil`, `nama_produk`, `kode_tipekulit`, `id_kategori`, `nilai`, `status`) VALUES
(39, 'hasil-67023e4de5bf92.48836734', 'FI SKIN CONDITIONING GEL', 'a4', 5, 67.2829, ''),
(40, 'hasil-67023e4de5bf92.48836734', 'FI BPO TOTOL JERAWAT', 'a4', 5, 63.9496, ''),
(41, 'hasil-67023e4de5bf92.48836734', 'FI ACNE SPOT GEL', 'a4', 5, 63.9496, ''),
(42, 'hasil-67023e4de5bf92.48836734', 'FI STAY CLEAR ACNE NIGHT CREAM', 'a4', 5, 67.2829, ''),
(43, 'hasil-671d1370a43ec5.35718018', 'FACIAL WASH AA', 'a1', 1, 57.3529, ''),
(44, 'hasil-671d137bddb044.52337194', 'FI FACIAL WASH NORMAL TO DRY', 'a3', 1, 67.6471, ''),
(45, 'hasil-6720126a5b11f4.34570760', 'FI BIOME PROTECTION GEL SERUM', 'a3', 4, 85.5882, ''),
(46, 'hasil-6720126a5b11f4.34570760', 'PLATINUM BRIGHT CRYSTAL SERUM', 'a3', 4, 97.0588, ''),
(47, 'hasil-6731e0295898a1.69038821', 'FI TONER LIGHT ESSENCE', 'a3', 3, 72.577, ''),
(48, 'hasil-6731e0295898a1.69038821', 'FI FACE TONER ND', 'a3', 3, 73.5294, ''),
(49, 'hasil-6731e0295898a1.69038821', 'FI FACE TONER AHA', 'a3', 3, 69.4118, '');

-- --------------------------------------------------------

--
-- Table structure for table `hasil_rekomendasi`
--

CREATE TABLE `hasil_rekomendasi` (
  `id_hasil_rekomendasi` int(11) NOT NULL,
  `id_visitor` int(11) DEFAULT NULL,
  `id_kategori_produk` int(11) NOT NULL,
  `kode_tipekulit` varchar(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `skor_produk` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hasil_rekomendasi_akhir`
--

CREATE TABLE `hasil_rekomendasi_akhir` (
  `id` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `created_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hasil_rekomendasi_akhir`
--

INSERT INTO `hasil_rekomendasi_akhir` (`id`, `nama`, `email`, `id_produk`, `created_date`) VALUES
(1, 'Hezkiel', 'hez@gmail.com', 74, '2024-10-19'),
(2, 'aulia', 'aulia@gmail.com', 74, '2024-10-28'),
(3, 'coba', 'coba@gmail.com', 52, '2024-11-08'),
(4, 'sinta', 'sinta@gmail.com', 52, '2024-11-10');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_produk`
--

CREATE TABLE `kategori_produk` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori_produk` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_produk`
--

INSERT INTO `kategori_produk` (`id_kategori`, `nama_kategori_produk`) VALUES
(1, 'Sabun Muka'),
(2, 'Pembersih Muka'),
(3, 'Toner'),
(4, 'Serum'),
(5, 'Pelembab'),
(9, 'Tabir Surya');

-- --------------------------------------------------------

--
-- Table structure for table `kriteria`
--

CREATE TABLE `kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `kode_kriteria` varchar(10) NOT NULL,
  `kriteria` varchar(50) NOT NULL,
  `type` enum('Benefit','Cost') NOT NULL,
  `bobot` float NOT NULL,
  `ada_pilihan` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kriteria`
--

INSERT INTO `kriteria` (`id_kriteria`, `kode_kriteria`, `kriteria`, `type`, `bobot`, `ada_pilihan`) VALUES
(1, 'C1', 'Jenis Produk', 'Benefit', 20, 1),
(2, 'C2', 'Jenis Kulit', 'Benefit', 30, 1),
(3, 'C3', 'Volume', 'Benefit', 10, 1),
(4, 'C4', 'Rating', 'Benefit', 15, 1),
(6, 'C5', 'Harga', 'Cost', 25, 1);

-- --------------------------------------------------------

--
-- Table structure for table `kriteria_visitor`
--

CREATE TABLE `kriteria_visitor` (
  `id_kriteria_visitor` int(11) NOT NULL,
  `id_visitor` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `id_sub_kriteria` int(11) NOT NULL,
  `nilai_kriteria` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kriteria_visitor`
--

INSERT INTO `kriteria_visitor` (`id_kriteria_visitor`, `id_visitor`, `id_kriteria`, `id_sub_kriteria`, `nilai_kriteria`) VALUES
(1, 1, 1, 1, 85),
(2, 1, 2, 10, 60),
(3, 1, 3, 21, 45),
(4, 1, 4, 32, 85),
(5, 2, 1, 7, 30),
(6, 2, 2, 9, 80),
(7, 2, 3, 24, 60),
(8, 2, 4, 32, 85),
(9, 3, 1, 5, 45),
(10, 3, 2, 8, 100),
(11, 3, 3, 25, 65),
(12, 3, 4, 32, 85),
(13, 4, 1, 3, 65),
(14, 4, 2, 9, 80),
(15, 4, 3, 28, 80),
(16, 4, 4, 32, 85),
(17, 5, 1, 2, 70),
(18, 5, 2, 9, 80),
(19, 5, 3, 27, 75),
(20, 5, 4, 31, 50),
(21, 6, 1, 7, 30),
(22, 6, 2, 10, 60),
(23, 6, 3, 24, 60),
(24, 6, 4, 33, 100),
(25, 7, 1, 1, 85),
(26, 7, 2, 8, 100),
(27, 7, 3, 28, 80),
(28, 7, 4, 33, 100),
(29, 8, 1, 1, 85),
(30, 8, 2, 8, 100),
(31, 8, 3, 16, 20),
(32, 8, 4, 32, 85),
(33, 9, 1, 4, 50),
(34, 9, 2, 10, 60),
(35, 9, 3, 21, 45),
(36, 9, 4, 32, 85),
(37, 10, 1, 6, 35),
(38, 10, 2, 9, 80),
(39, 10, 3, 24, 60),
(40, 10, 4, 32, 85),
(41, 11, 1, 6, 35),
(42, 11, 2, 8, 100),
(43, 11, 3, 29, 95),
(44, 11, 4, 32, 85),
(45, 12, 1, 7, 30),
(46, 12, 2, 10, 60),
(47, 12, 3, 28, 80),
(48, 12, 4, 33, 100),
(49, 13, 1, 5, 45),
(50, 13, 2, 10, 60),
(51, 13, 3, 27, 75),
(52, 13, 4, 33, 100),
(53, 14, 1, 3, 65),
(54, 14, 2, 8, 100),
(55, 14, 3, 27, 75),
(56, 14, 4, 32, 85),
(57, 15, 1, 2, 70),
(58, 15, 2, 10, 60),
(59, 15, 3, 27, 75),
(60, 15, 4, 32, 85),
(61, 16, 1, 3, 65),
(62, 16, 2, 10, 60),
(63, 16, 3, 28, 80),
(64, 16, 4, 32, 85),
(65, 17, 1, 6, 35),
(66, 17, 2, 10, 60),
(67, 17, 3, 26, 70),
(68, 17, 4, 32, 85),
(69, 18, 1, 3, 65),
(70, 18, 2, 9, 80),
(71, 18, 3, 26, 70),
(72, 18, 4, 32, 85),
(73, 19, 1, 7, 30),
(74, 19, 2, 12, 20),
(75, 19, 3, 29, 95),
(76, 19, 4, 33, 100),
(77, 20, 1, 4, 50),
(78, 20, 2, 10, 60),
(79, 20, 3, 29, 95),
(80, 20, 4, 33, 100),
(81, 21, 1, 4, 50),
(82, 21, 2, 10, 60),
(83, 21, 3, 29, 95),
(84, 21, 4, 33, 100),
(85, 22, 1, 2, 70),
(86, 22, 2, 9, 80),
(87, 22, 3, 29, 95),
(88, 22, 4, 32, 85),
(89, 23, 1, 7, 30),
(90, 23, 2, 8, 100),
(91, 23, 3, 13, 5),
(92, 23, 4, 33, 100),
(93, 24, 1, 3, 70),
(94, 24, 2, 11, 60),
(95, 24, 3, 13, 25),
(96, 24, 4, 32, 85),
(97, 24, 6, 36, 60),
(98, 25, 1, 5, 65),
(99, 25, 2, 10, 70),
(100, 25, 3, 13, 25),
(101, 25, 4, 32, 85),
(102, 25, 6, 36, 60),
(103, 26, 1, 5, 65),
(104, 26, 2, 10, 70),
(105, 26, 3, 13, 25),
(106, 26, 4, 32, 85),
(107, 26, 6, 36, 60),
(108, 27, 1, 3, 70),
(109, 27, 2, 10, 70),
(110, 27, 3, 14, 60),
(111, 27, 4, 32, 85),
(112, 27, 6, 36, 60),
(113, 28, 1, 5, 65),
(114, 28, 2, 11, 60),
(115, 28, 3, 14, 60),
(116, 28, 4, 32, 85),
(117, 28, 6, 36, 60);

-- --------------------------------------------------------

--
-- Table structure for table `penilaian`
--

CREATE TABLE `penilaian` (
  `id_penilaian` int(11) NOT NULL,
  `kode_tipekulit` varchar(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_produk` int(10) NOT NULL,
  `id_kriteria` int(10) NOT NULL,
  `nilai` float NOT NULL,
  `nama` varchar(35) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `kode_tipekulit`, `id_kategori`, `id_produk`, `id_kriteria`, `nilai`, `nama`, `email`) VALUES
(174, 'a3', 3, 56, 1, 70, NULL, NULL),
(175, 'a3', 3, 56, 2, 60, NULL, NULL),
(176, 'a3', 3, 56, 3, 85, NULL, NULL),
(177, 'a3', 3, 56, 4, 60, NULL, NULL),
(178, 'a3', 3, 56, 1, 70, NULL, NULL),
(179, 'a3', 3, 56, 2, 70, NULL, NULL),
(180, 'a3', 3, 56, 3, 60, NULL, NULL),
(181, 'a3', 3, 56, 4, 85, NULL, NULL),
(182, 'a3', 3, 56, 6, 60, NULL, NULL),
(183, 'a3', 3, 65, 1, 70, NULL, NULL),
(184, 'a3', 3, 65, 2, 70, NULL, NULL),
(185, 'a3', 3, 65, 3, 60, NULL, NULL),
(186, 'a3', 3, 65, 4, 85, NULL, NULL),
(187, 'a3', 3, 65, 6, 100, NULL, NULL),
(193, 'a3', 4, 70, 1, 85, NULL, NULL),
(194, 'a3', 4, 70, 2, 70, NULL, NULL),
(195, 'a3', 4, 70, 3, 60, NULL, NULL),
(196, 'a3', 4, 70, 4, 20, NULL, NULL),
(197, 'a3', 4, 70, 6, 20, NULL, NULL),
(198, 'a3', 4, 93, 1, 85, NULL, NULL),
(199, 'a3', 4, 93, 2, 70, NULL, NULL),
(200, 'a3', 4, 93, 3, 60, NULL, NULL),
(201, 'a3', 4, 93, 4, 85, NULL, NULL),
(202, 'a3', 4, 93, 6, 20, NULL, NULL),
(208, 'a3', 5, 76, 1, 65, NULL, NULL),
(209, 'a3', 5, 76, 2, 70, NULL, NULL),
(210, 'a3', 5, 76, 3, 25, NULL, NULL),
(211, 'a3', 5, 76, 4, 85, NULL, NULL),
(212, 'a3', 5, 76, 6, 60, NULL, NULL),
(213, 'a3', 5, 85, 1, 65, NULL, NULL),
(214, 'a3', 5, 85, 2, 70, NULL, NULL),
(215, 'a3', 5, 85, 3, 25, NULL, NULL),
(216, 'a3', 5, 85, 4, 85, NULL, NULL),
(217, 'a3', 5, 85, 6, 100, NULL, NULL),
(218, 'a3', 5, 88, 1, 65, NULL, NULL),
(219, 'a3', 5, 88, 2, 70, NULL, NULL),
(220, 'a3', 5, 88, 3, 60, NULL, NULL),
(221, 'a3', 5, 88, 4, 85, NULL, NULL),
(222, 'a3', 5, 88, 6, 60, NULL, NULL),
(223, 'a3', 9, 53, 1, 50, NULL, NULL),
(224, 'a3', 9, 53, 2, 70, NULL, NULL),
(225, 'a3', 9, 53, 3, 25, NULL, NULL),
(226, 'a3', 9, 53, 4, 85, NULL, NULL),
(227, 'a3', 9, 53, 6, 60, NULL, NULL),
(228, 'a3', 1, 52, 1, 45, NULL, NULL),
(229, 'a3', 1, 52, 2, 70, NULL, NULL),
(230, 'a3', 1, 52, 3, 60, NULL, NULL),
(231, 'a3', 1, 52, 4, 85, NULL, NULL),
(232, 'a3', 1, 52, 6, 100, NULL, NULL),
(238, 'a4', 1, 79, 1, 45, NULL, NULL),
(239, 'a4', 1, 79, 2, 60, NULL, NULL),
(240, 'a4', 1, 79, 3, 80, NULL, NULL),
(241, 'a4', 1, 79, 4, 85, NULL, NULL),
(242, 'a4', 1, 79, 6, 60, NULL, NULL),
(243, 'a4', 1, 50, 1, 45, NULL, NULL),
(244, 'a4', 1, 50, 2, 60, NULL, NULL),
(245, 'a4', 1, 50, 3, 60, NULL, NULL),
(246, 'a4', 1, 50, 4, 85, NULL, NULL),
(247, 'a4', 1, 50, 6, 100, NULL, NULL),
(248, 'a4', 2, 80, 1, 45, NULL, NULL),
(249, 'a4', 2, 80, 2, 60, NULL, NULL),
(250, 'a4', 2, 80, 3, 80, NULL, NULL),
(251, 'a4', 2, 80, 4, 85, NULL, NULL),
(252, 'a4', 2, 80, 6, 60, NULL, NULL),
(258, 'a4', 3, 57, 1, 70, NULL, NULL),
(259, 'a4', 3, 57, 2, 60, NULL, NULL),
(260, 'a4', 3, 57, 3, 60, NULL, NULL),
(261, 'a4', 3, 57, 4, 85, NULL, NULL),
(262, 'a4', 3, 57, 6, 60, NULL, NULL),
(263, 'a4', 3, 66, 1, 70, NULL, NULL),
(264, 'a4', 3, 66, 2, 60, NULL, NULL),
(265, 'a4', 3, 66, 3, 80, NULL, NULL),
(266, 'a4', 3, 66, 4, 85, NULL, NULL),
(267, 'a4', 3, 66, 6, 100, NULL, NULL),
(268, 'a4', 3, 89, 1, 70, NULL, NULL),
(269, 'a4', 3, 89, 2, 60, NULL, NULL),
(270, 'a4', 3, 89, 3, 60, NULL, NULL),
(271, 'a4', 3, 89, 4, 85, NULL, NULL),
(272, 'a4', 3, 89, 6, 60, NULL, NULL),
(273, 'a4', 4, 72, 1, 85, NULL, NULL),
(274, 'a4', 4, 72, 2, 60, NULL, NULL),
(275, 'a4', 4, 72, 3, 25, NULL, NULL),
(276, 'a4', 4, 72, 4, 85, NULL, NULL),
(277, 'a4', 4, 72, 6, 20, NULL, NULL),
(278, 'a4', 5, 78, 1, 65, NULL, NULL),
(279, 'a4', 5, 78, 2, 60, NULL, NULL),
(280, 'a4', 5, 78, 3, 25, NULL, NULL),
(281, 'a4', 5, 78, 4, 85, NULL, NULL),
(282, 'a4', 5, 78, 6, 60, NULL, NULL),
(283, 'a4', 5, 83, 1, 65, NULL, NULL),
(284, 'a4', 5, 83, 2, 60, NULL, NULL),
(285, 'a4', 5, 83, 3, 25, NULL, NULL),
(286, 'a4', 5, 83, 4, 85, NULL, NULL),
(287, 'a4', 5, 83, 6, 100, NULL, NULL),
(288, 'a4', 5, 86, 1, 65, NULL, NULL),
(289, 'a4', 5, 86, 2, 60, NULL, NULL),
(290, 'a4', 5, 86, 3, 25, NULL, NULL),
(291, 'a4', 5, 86, 4, 85, NULL, NULL),
(292, 'a4', 5, 86, 6, 100, NULL, NULL),
(293, 'a4', 5, 92, 1, 65, NULL, NULL),
(294, 'a4', 5, 92, 2, 60, NULL, NULL),
(295, 'a4', 5, 92, 3, 25, NULL, NULL),
(296, 'a4', 5, 92, 4, 85, NULL, NULL),
(297, 'a4', 5, 92, 6, 60, NULL, NULL),
(298, 'a1', 1, 69, 1, 45, NULL, NULL),
(299, 'a1', 1, 69, 2, 70, NULL, NULL),
(300, 'a1', 1, 69, 3, 25, NULL, NULL),
(301, 'a1', 1, 69, 4, 50, NULL, NULL),
(302, 'a1', 1, 69, 6, 100, NULL, NULL),
(323, 'a3', 3, 74, 1, 70, NULL, NULL),
(324, 'a3', 3, 74, 2, 70, NULL, NULL),
(325, 'a3', 3, 74, 3, 25, NULL, NULL),
(326, 'a3', 3, 74, 4, 85, NULL, NULL),
(327, 'a3', 3, 74, 6, 100, NULL, NULL),
(343, 'a3', 5, 1, 1, 65, NULL, NULL),
(344, 'a3', 5, 1, 2, 70, NULL, NULL),
(345, 'a3', 5, 1, 3, 25, NULL, NULL),
(346, 'a3', 5, 1, 4, 85, NULL, NULL),
(347, 'a3', 5, 1, 6, 60, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penilaian_temp`
--

CREATE TABLE `penilaian_temp` (
  `id_penilaian` int(11) NOT NULL,
  `kode_tipekulit` varchar(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_produk` int(10) NOT NULL,
  `id_kriteria` int(10) NOT NULL,
  `nilai` float NOT NULL,
  `nama` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penilaian_temp`
--

INSERT INTO `penilaian_temp` (`id_penilaian`, `kode_tipekulit`, `id_kategori`, `id_produk`, `id_kriteria`, `nilai`, `nama`, `email`) VALUES
(6, 'a3', 3, 0, 1, 70, 'elein', 'elein@gmail.com'),
(7, 'a3', 3, 0, 2, 70, 'elein', 'elein@gmail.com'),
(8, 'a3', 3, 0, 3, 60, 'elein', 'elein@gmail.com'),
(9, 'a3', 3, 0, 4, 50, 'elein', 'elein@gmail.com'),
(10, 'a3', 3, 0, 6, 100, 'elein', 'elein@gmail.com'),
(11, 'a3', 3, 0, 1, 70, 'Lein', 'lein@gmail.com'),
(12, 'a3', 3, 0, 2, 70, 'Lein', 'lein@gmail.com'),
(13, 'a3', 3, 0, 3, 25, 'Lein', 'lein@gmail.com'),
(14, 'a3', 3, 0, 4, 50, 'Lein', 'lein@gmail.com'),
(15, 'a3', 3, 0, 6, 100, 'Lein', 'lein@gmail.com'),
(16, 'a3', 3, 0, 1, 70, 'tes', 'tes@gmail.com'),
(17, 'a3', 3, 0, 2, 70, 'tes', 'tes@gmail.com'),
(18, 'a3', 3, 0, 3, 25, 'tes', 'tes@gmail.com'),
(19, 'a3', 3, 0, 4, 20, 'tes', 'tes@gmail.com'),
(20, 'a3', 3, 0, 6, 100, 'tes', 'tes@gmail.com'),
(21, 'a3', 3, 0, 1, 70, 'Rey', 'rey@gmail.com'),
(22, 'a3', 3, 0, 2, 70, 'Rey', 'rey@gmail.com'),
(23, 'a3', 3, 0, 3, 60, 'Rey', 'rey@gmail.com'),
(24, 'a3', 3, 0, 4, 50, 'Rey', 'rey@gmail.com'),
(25, 'a3', 3, 0, 6, 100, 'Rey', 'rey@gmail.com'),
(26, 'a3', 3, 0, 1, 70, 'Lein', 'lein@gmail.com'),
(27, 'a3', 3, 0, 2, 70, 'Lein', 'lein@gmail.com'),
(28, 'a3', 3, 0, 3, 60, 'Lein', 'lein@gmail.com'),
(29, 'a3', 3, 0, 4, 50, 'Lein', 'lein@gmail.com'),
(30, 'a3', 3, 0, 6, 60, 'Lein', 'lein@gmail.com'),
(31, 'a3', 3, 0, 1, 70, 'bla', 'bla@gmail.com'),
(32, 'a3', 3, 0, 2, 70, 'bla', 'bla@gmail.com'),
(33, 'a3', 3, 0, 3, 80, 'bla', 'bla@gmail.com'),
(34, 'a3', 3, 0, 4, 50, 'bla', 'bla@gmail.com'),
(35, 'a3', 3, 0, 6, 60, 'bla', 'bla@gmail.com'),
(36, 'a3', 3, 0, 1, 70, 'Bayu', 'angel@gmail.com'),
(37, 'a3', 3, 0, 2, 70, 'Bayu', 'angel@gmail.com'),
(38, 'a3', 3, 0, 3, 60, 'Bayu', 'angel@gmail.com'),
(39, 'a3', 3, 0, 4, 85, 'Bayu', 'angel@gmail.com'),
(40, 'a3', 3, 0, 6, 60, 'Bayu', 'angel@gmail.com'),
(41, 'a3', 3, 0, 1, 70, 'Bayu', 'angel@gmail.com'),
(42, 'a3', 3, 0, 2, 70, 'Bayu', 'angel@gmail.com'),
(43, 'a3', 3, 0, 3, 60, 'Bayu', 'angel@gmail.com'),
(44, 'a3', 3, 0, 4, 50, 'Bayu', 'angel@gmail.com'),
(45, 'a3', 3, 0, 6, 60, 'Bayu', 'angel@gmail.com'),
(46, 'a3', 3, 0, 1, 70, 'Gilbert', 'gili@gmail.com'),
(47, 'a3', 3, 0, 2, 70, 'Gilbert', 'gili@gmail.com'),
(48, 'a3', 3, 0, 3, 25, 'Gilbert', 'gili@gmail.com'),
(49, 'a3', 3, 0, 4, 85, 'Gilbert', 'gili@gmail.com'),
(50, 'a3', 3, 0, 6, 100, 'Gilbert', 'gili@gmail.com'),
(51, 'a3', 3, 0, 1, 70, 'Gilbert', 'gili@gmail.com'),
(52, 'a3', 3, 0, 2, 70, 'Gilbert', 'gili@gmail.com'),
(53, 'a3', 3, 0, 3, 60, 'Gilbert', 'gili@gmail.com'),
(54, 'a3', 3, 0, 4, 85, 'Gilbert', 'gili@gmail.com'),
(55, 'a3', 3, 0, 6, 60, 'Gilbert', 'gili@gmail.com'),
(56, 'a3', 3, 0, 1, 70, 'Hezkiel', 'hez@gmail.com'),
(57, 'a3', 3, 0, 2, 70, 'Hezkiel', 'hez@gmail.com'),
(58, 'a3', 3, 0, 3, 80, 'Hezkiel', 'hez@gmail.com'),
(59, 'a3', 3, 0, 4, 85, 'Hezkiel', 'hez@gmail.com'),
(60, 'a3', 3, 0, 6, 20, 'Hezkiel', 'hez@gmail.com'),
(61, 'a3', 3, 0, 1, 70, 'aulia', 'aulia@gmail.com'),
(62, 'a3', 3, 0, 2, 70, 'aulia', 'aulia@gmail.com'),
(63, 'a3', 3, 0, 3, 25, 'aulia', 'aulia@gmail.com'),
(64, 'a3', 3, 0, 4, 20, 'aulia', 'aulia@gmail.com'),
(65, 'a3', 3, 0, 6, 100, 'aulia', 'aulia@gmail.com'),
(66, 'a3', 3, 0, 1, 70, 'aulia', 'aulia@gmail.com'),
(67, 'a3', 3, 0, 2, 70, 'aulia', 'aulia@gmail.com'),
(68, 'a3', 3, 0, 3, 25, 'aulia', 'aulia@gmail.com'),
(69, 'a3', 3, 0, 4, 20, 'aulia', 'aulia@gmail.com'),
(70, 'a3', 3, 0, 6, 100, 'aulia', 'aulia@gmail.com'),
(71, 'a3', 1, 0, 1, 45, 'nafilla', 'naff@gmail.com'),
(72, 'a3', 1, 0, 2, 70, 'nafilla', 'naff@gmail.com'),
(73, 'a3', 1, 0, 3, 25, 'nafilla', 'naff@gmail.com'),
(74, 'a3', 1, 0, 4, 20, 'nafilla', 'naff@gmail.com'),
(75, 'a3', 1, 0, 6, 100, 'nafilla', 'naff@gmail.com'),
(76, 'a3', 1, 0, 1, 45, 'nafilla', 'naff@gmail.com'),
(77, 'a3', 1, 0, 2, 70, 'nafilla', 'naff@gmail.com'),
(78, 'a3', 1, 0, 3, 25, 'nafilla', 'naff@gmail.com'),
(79, 'a3', 1, 0, 4, 20, 'nafilla', 'naff@gmail.com'),
(80, 'a3', 1, 0, 6, 100, 'nafilla', 'naff@gmail.com'),
(81, 'a3', 3, 0, 1, 70, 'aulia', 'aulia@gmail.com'),
(82, 'a3', 3, 0, 2, 70, 'aulia', 'aulia@gmail.com'),
(83, 'a3', 3, 0, 3, 25, 'aulia', 'aulia@gmail.com'),
(84, 'a3', 3, 0, 4, 50, 'aulia', 'aulia@gmail.com'),
(85, 'a3', 3, 0, 6, 60, 'aulia', 'aulia@gmail.com'),
(86, 'a3', 3, 0, 1, 70, 'aulia', 'aulia@gmail.com'),
(87, 'a3', 3, 0, 2, 70, 'aulia', 'aulia@gmail.com'),
(88, 'a3', 3, 0, 3, 80, 'aulia', 'aulia@gmail.com'),
(89, 'a3', 3, 0, 4, 85, 'aulia', 'aulia@gmail.com'),
(90, 'a3', 3, 0, 6, 60, 'aulia', 'aulia@gmail.com'),
(91, 'a4', 1, 0, 1, 45, 'wikel', 'wikel@gmail.com'),
(92, 'a4', 1, 0, 2, 60, 'wikel', 'wikel@gmail.com'),
(93, 'a4', 1, 0, 3, 25, 'wikel', 'wikel@gmail.com'),
(94, 'a4', 1, 0, 4, 50, 'wikel', 'wikel@gmail.com'),
(95, 'a4', 1, 0, 6, 100, 'wikel', 'wikel@gmail.com'),
(96, 'a3', 1, 0, 1, 45, 'coba', 'coba@gmail.com'),
(97, 'a3', 1, 0, 2, 70, 'coba', 'coba@gmail.com'),
(98, 'a3', 1, 0, 3, 25, 'coba', 'coba@gmail.com'),
(99, 'a3', 1, 0, 4, 20, 'coba', 'coba@gmail.com'),
(100, 'a3', 1, 0, 6, 100, 'coba', 'coba@gmail.com'),
(101, 'a3', 1, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(102, 'a3', 1, 0, 2, 70, 'sinta', 'sinta@gmail.com'),
(103, 'a3', 1, 0, 3, 60, 'sinta', 'sinta@gmail.com'),
(104, 'a3', 1, 0, 4, 85, 'sinta', 'sinta@gmail.com'),
(105, 'a3', 1, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(106, 'a4', 4, 0, 1, 85, 'sinta', 'sinta@gmail.com'),
(107, 'a4', 4, 0, 2, 60, 'sinta', 'sinta@gmail.com'),
(108, 'a4', 4, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(109, 'a4', 4, 0, 4, 85, 'sinta', 'sinta@gmail.com'),
(110, 'a4', 4, 0, 6, 20, 'sinta', 'sinta@gmail.com'),
(111, 'a4', 4, 0, 1, 85, 'sinta', 'sinta@gmail.com'),
(112, 'a4', 4, 0, 2, 65, 'sinta', 'sinta@gmail.com'),
(113, 'a4', 4, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(114, 'a4', 4, 0, 4, 85, 'sinta', 'sinta@gmail.com'),
(115, 'a4', 4, 0, 6, 20, 'sinta', 'sinta@gmail.com'),
(116, 'a4', 4, 0, 1, 85, 'sinta', 'sinta@gmail.com'),
(117, 'a4', 4, 0, 2, 60, 'sinta', 'sinta@gmail.com'),
(118, 'a4', 4, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(119, 'a4', 4, 0, 4, 85, 'sinta', 'sinta@gmail.com'),
(120, 'a4', 4, 0, 6, 60, 'sinta', 'sinta@gmail.com'),
(121, 'a3', 3, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(122, 'a3', 3, 0, 2, 75, 'sinta', 'sinta@gmail.com'),
(123, 'a3', 3, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(124, 'a3', 3, 0, 4, 20, 'sinta', 'sinta@gmail.com'),
(125, 'a3', 3, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(126, 'a2', 1, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(127, 'a2', 1, 0, 2, 75, 'sinta', 'sinta@gmail.com'),
(128, 'a2', 1, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(129, 'a2', 1, 0, 4, 20, 'sinta', 'sinta@gmail.com'),
(130, 'a2', 1, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(131, 'a3', 1, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(132, 'a3', 1, 0, 2, 70, 'sinta', 'sinta@gmail.com'),
(133, 'a3', 1, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(134, 'a3', 1, 0, 4, 20, 'sinta', 'sinta@gmail.com'),
(135, 'a3', 1, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(136, 'a3', 1, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(137, 'a3', 1, 0, 2, 70, 'sinta', 'sinta@gmail.com'),
(138, 'a3', 1, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(139, 'a3', 1, 0, 4, 20, 'sinta', 'sinta@gmail.com'),
(140, 'a3', 1, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(141, 'a4', 1, 0, 1, 45, 'sinta', 'sinta@gmail.com'),
(142, 'a4', 1, 0, 2, 60, 'sinta', 'sinta@gmail.com'),
(143, 'a4', 1, 0, 3, 25, 'sinta', 'sinta@gmail.com'),
(144, 'a4', 1, 0, 4, 20, 'sinta', 'sinta@gmail.com'),
(145, 'a4', 1, 0, 6, 100, 'sinta', 'sinta@gmail.com'),
(146, 'a3', 3, 0, 1, 70, 'pak widi', 'widi@gmail.com'),
(147, 'a3', 3, 0, 2, 70, 'pak widi', 'widi@gmail.com'),
(148, 'a3', 3, 0, 3, 60, 'pak widi', 'widi@gmail.com'),
(149, 'a3', 3, 0, 4, 50, 'pak widi', 'widi@gmail.com'),
(150, 'a3', 3, 0, 6, 100, 'pak widi', 'widi@gmail.com'),
(151, 'a3', 1, 0, 1, 45, 'pak widi', 'widi@gmail.com'),
(152, 'a3', 1, 0, 2, 70, 'pak widi', 'widi@gmail.com'),
(153, 'a3', 1, 0, 3, 25, 'pak widi', 'widi@gmail.com'),
(154, 'a3', 1, 0, 4, 50, 'pak widi', 'widi@gmail.com'),
(155, 'a3', 1, 0, 6, 20, 'pak widi', 'widi@gmail.com'),
(156, 'a3', 3, 0, 1, 45, 'coba', 'coba@gmail.com'),
(157, 'a3', 3, 0, 2, 70, 'coba', 'coba@gmail.com'),
(158, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(159, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(160, 'a3', 3, 0, 6, 100, 'coba', 'coba@gmail.com'),
(161, 'a3', 3, 0, 1, 45, 'coba', 'coba@gmail.com'),
(162, 'a3', 3, 0, 2, 70, 'coba', 'coba@gmail.com'),
(163, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(164, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(165, 'a3', 3, 0, 6, 100, 'coba', 'coba@gmail.com'),
(166, 'a3', 3, 0, 1, 45, 'coba', 'coba@gmail.com'),
(167, 'a3', 3, 0, 2, 70, 'coba', 'coba@gmail.com'),
(168, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(169, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(170, 'a3', 3, 0, 6, 60, 'coba', 'coba@gmail.com'),
(171, 'a3', 1, 0, 1, 70, 'coba', 'coba@gmail.com'),
(172, 'a3', 1, 0, 2, 70, 'coba', 'coba@gmail.com'),
(173, 'a3', 1, 0, 3, 25, 'coba', 'coba@gmail.com'),
(174, 'a3', 1, 0, 4, 20, 'coba', 'coba@gmail.com'),
(175, 'a3', 1, 0, 6, 100, 'coba', 'coba@gmail.com'),
(176, 'a3', 3, 0, 1, 85, 'coba', 'coba@gmail.com'),
(177, 'a3', 3, 0, 2, 75, 'coba', 'coba@gmail.com'),
(178, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(179, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(180, 'a3', 3, 0, 6, 100, 'coba', 'coba@gmail.com'),
(181, 'a3', 1, 0, 1, 45, 'coba', 'coba@gmail.com'),
(182, 'a3', 1, 0, 2, 70, 'coba', 'coba@gmail.com'),
(183, 'a3', 1, 0, 3, 25, 'coba', 'coba@gmail.com'),
(184, 'a3', 1, 0, 4, 20, 'coba', 'coba@gmail.com'),
(185, 'a3', 1, 0, 6, 100, 'coba', 'coba@gmail.com'),
(186, 'a3', 3, 0, 1, 70, 'coba', 'coba@gmail.com'),
(187, 'a3', 3, 0, 2, 70, 'coba', 'coba@gmail.com'),
(188, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(189, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(190, 'a3', 3, 0, 6, 60, 'coba', 'coba@gmail.com'),
(191, 'a3', 3, 0, 1, 70, 'coba', 'coba@gmail.com'),
(192, 'a3', 3, 0, 2, 70, 'coba', 'coba@gmail.com'),
(193, 'a3', 3, 0, 3, 25, 'coba', 'coba@gmail.com'),
(194, 'a3', 3, 0, 4, 20, 'coba', 'coba@gmail.com'),
(195, 'a3', 3, 0, 6, 100, 'coba', 'coba@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `kode_produk` varchar(11) NOT NULL,
  `nama_produk` varchar(150) NOT NULL,
  `harga` int(255) NOT NULL,
  `id_brand` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `tipe_kulit` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `kode_produk`, `nama_produk`, `harga`, `id_brand`, `id_kategori`, `tipe_kulit`, `created_at`, `update_at`) VALUES
(1, 'PR-01', 'FI MOISTFULL CREAM', 108200, 2, 5, 'a3', '2024-09-25 08:51:24', '2024-11-13 13:39:03'),
(49, 'PR-2', 'FI SUNSCREEN ASTA 5', 102100, 2, 9, 'a2', '2024-09-25 09:10:51', '2024-11-13 13:39:18'),
(50, 'PR-3', 'FI FACIAL WASH NTO', 73600, 2, 1, 'a4', '2024-09-25 09:34:46', '2024-11-13 13:42:04'),
(51, 'PR-4', 'FI SUNSCREEN WHITE SPF 50', 102100, 2, 9, 'a1', '2024-09-25 09:35:56', '2024-11-13 13:42:36'),
(52, 'PR-5', 'FI FACIAL WASH NORMAL TO DRY', 73600, 2, 1, 'a3', '2024-09-25 09:37:19', '2024-11-13 13:43:48'),
(53, 'PR-6', 'FI SUNSCREEN YELLOW SPF 50', 109900, 2, 9, 'a3', '2024-09-26 08:18:16', '2024-11-13 13:44:10'),
(54, 'PR-7', 'FI SUNSCREEN FBG', 71400, 2, 9, 'a5', '2024-09-26 08:19:01', '2024-11-13 13:45:04'),
(55, 'PR-8', 'FI ESSENTIAL SERUM', 150600, 2, 4, 'a1', '2024-09-26 08:19:37', '2024-11-13 13:45:51'),
(56, 'PR-9', 'FI TONER LIGHT ESSENCE', 98200, 2, 3, 'a3', '2024-09-26 08:20:56', '2024-11-13 13:46:36'),
(57, 'PR-10', 'FI STAY CLEAR ACNE PORE ESSENCE', 98200, 2, 3, 'a4', '2024-09-26 08:21:33', '2024-11-13 13:47:02'),
(58, 'PR-11', 'FI MINI LIFTING SERUM', 55800, 2, 4, 'a1', '2024-09-26 08:22:17', '2024-11-13 13:47:29'),
(59, 'PR-12', 'FI LIFTING SERUM', 250900, 2, 4, 'a1', '2024-09-26 08:22:48', '2024-11-13 13:48:05'),
(60, 'PR-13', 'SPOT LIGHTENING SERUM', 223000, 2, 4, 'a5', '2024-09-26 08:24:55', '2024-11-13 13:50:48'),
(61, 'PR-14', 'FI ACNE SERUM', 150600, 2, 4, 'a5', '2024-09-26 08:25:30', '2024-11-13 13:52:13'),
(62, 'PR-15', 'FI STAYCLEAR ACNE SUNSCREEN', 102100, 2, 9, 'a5', '2024-09-26 08:26:09', '2024-11-13 13:52:43'),
(63, 'PR-16', 'FI MOISTGLOW SUNSCREEN', 111900, 2, 9, 'a5', '2024-09-26 08:30:09', '2024-11-13 13:53:13'),
(64, 'PR-17', 'FI SUNSCREEN BEIGE SPF 50', 102100, 2, 9, 'a2', '2024-09-26 08:30:45', '2024-11-13 13:53:44'),
(65, 'PR-18', 'FI FACE TONER ND', 55200, 2, 3, 'a3', '2024-09-26 08:31:39', '2024-11-13 13:54:26'),
(66, 'PR-19', 'FI SKIN BALANCER TONER', 66900, 2, 3, 'a4', '2024-09-26 08:32:32', '2024-11-13 13:54:59'),
(67, 'PR-20', 'FACE TONER AA', 73600, 2, 3, 'a3', '2024-09-26 08:33:08', '2024-11-13 13:56:02'),
(68, 'PR-21', 'FI TX GLOW SERUM', 184000, 2, 4, 'a5', '2024-09-26 08:33:49', '2024-11-13 22:29:01'),
(69, 'PR-22', 'FACIAL WASH AA', 737600, 2, 1, 'a1', '2024-09-26 08:34:29', '2024-11-13 22:30:27'),
(70, 'PR-23', 'FI BIOME PROTECTION GEL SERUM', 362400, 2, 4, 'a3', '2024-09-26 08:35:01', '2024-11-13 22:31:06'),
(71, 'PR-24', 'GLOW AND BRIGHT SUNSCREEN SPRAY ', 139400, 2, 9, 'a1', '2024-09-26 08:35:38', '2024-11-13 22:31:42'),
(72, 'PR-25', 'FI GLOW UP SERUM', 532500, 2, 4, 'a4', '2024-09-26 08:36:21', '2024-11-13 22:32:24'),
(73, 'PR-26', 'FI DNA SALMON GOLD', 278800, 2, 4, 'a1', '2024-09-26 08:37:14', '2024-11-13 22:32:55'),
(74, 'PR-27', 'FI FACE TONER AHA', 55200, 2, 3, 'a3', '2024-09-26 08:42:08', '2024-11-13 22:33:40'),
(75, 'PR-28', 'FI TONER SOFT ESSENCE', 98200, 2, 3, 'a5', '2024-09-26 08:43:08', '2024-11-13 22:34:14'),
(76, 'PR-29', 'FI STAY WHITE NIGHT CREAM', 163500, 2, 5, 'a3', '2024-09-26 08:44:00', '2024-11-13 22:35:03'),
(77, 'PR-30', 'FI STAY WHITE NIGHT LOTION', 122700, 2, 5, 'a1', '2024-09-26 08:44:35', '2024-11-13 22:35:35'),
(78, 'PR-31', 'FI SKIN CONDITIONING GEL', 145000, 2, 5, 'a4', '2024-09-26 08:45:10', '2024-11-13 22:36:13'),
(79, 'PR-32', 'FI ACNE FIGHTER SCRUB', 139400, 2, 1, 'a4', '2024-09-26 08:45:46', '2024-11-13 22:37:18'),
(80, 'PR-33', 'FI MICELLAR WATER ', 83700, 2, 2, 'a4', '2024-09-26 08:46:26', '2024-11-13 22:39:10'),
(81, 'PR-34', 'FI ANTI IRITASI', 55800, 2, 5, 'a1', '2024-09-26 08:46:53', '2024-11-13 22:39:59'),
(82, 'PR-35', 'FI DAILY LOTION SPF 30', 122700, 2, 5, 'a1', '2024-09-26 08:47:23', '2024-11-13 22:40:49'),
(83, 'PR-36', 'FI BPO TOTOL JERAWAT', 39100, 2, 5, 'a4', '2024-09-26 08:48:04', '2024-11-13 22:41:31'),
(84, 'PR-37', 'FI SENSITIVE SKIN SERUM', 184000, 2, 4, 'a5', '2024-09-26 08:48:37', '2024-11-13 22:41:59'),
(85, 'PR-38', 'FI DARK SPOT GEL', 61400, 2, 5, 'a3', '2024-09-26 08:49:10', '2024-11-13 22:42:43'),
(86, 'PR-39', 'FI ACNE SPOT GEL', 70300, 2, 5, 'a4', '2024-09-26 08:49:40', '2024-11-13 22:43:19'),
(87, 'PR-40', 'FI PLATINUM EYE SERUM', 250900, 2, 4, 'a1', '2024-09-26 08:50:49', '2024-11-13 22:44:00'),
(88, 'PR-41', 'FI COLLAGEN', 104300, 2, 5, 'a3', '2024-09-26 08:51:19', '2024-11-13 22:38:22'),
(89, 'PR-42', 'FI ACNE COMPRESS', 83700, 2, 3, 'a4', '2024-09-26 08:51:53', '2024-11-13 22:44:58'),
(90, 'PR-43', 'FI RECOVERY SERUM', 505900, 2, 4, 'a1', '2024-09-26 08:52:27', '2024-11-13 22:45:28'),
(91, 'PR-44', 'FI BIOME PROTECTION GEL SERUM', 362400, 2, 4, 'a1', '2024-09-26 08:52:57', '2024-11-13 22:46:02'),
(92, 'PR-45', 'FI STAY CLEAR ACNE NIGHT CREAM', 126600, 2, 5, 'a4', '2024-09-26 08:53:30', '2024-11-13 22:46:44'),
(93, 'PR-46', 'PLATINUM BRIGHT CRYSTAL SERUM', 752700, 2, 4, 'a3', '2024-09-26 08:53:59', '2024-11-13 22:47:21'),
(94, 'PR-47', 'FI FACE TONER SS', 55200, 2, 3, 'a5', '2024-09-26 08:54:27', '2024-11-13 22:47:52'),
(95, 'PR-48', 'FI EXFOLIATING FACE SCRUB', 93800, 2, 2, 'a1', '2024-09-26 08:55:14', '2024-11-13 22:48:21'),
(96, 'PR-49', 'FI REJUVINATION SERUM', 213000, 2, 4, 'a2', '2024-09-26 08:55:48', '2024-11-13 22:48:50'),
(98, 'PR-50', 'Coba', 89000, 2, 4, 'a5', '2024-11-08 13:29:12', '2024-11-08 13:29:12');

-- --------------------------------------------------------

--
-- Table structure for table `sub_kriteria`
--

CREATE TABLE `sub_kriteria` (
  `id_sub_kriteria` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `sub_kriteria` varchar(50) NOT NULL,
  `nilai` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sub_kriteria`
--

INSERT INTO `sub_kriteria` (`id_sub_kriteria`, `id_kriteria`, `sub_kriteria`, `nilai`) VALUES
(1, 1, 'Sabun Muka', 45),
(2, 1, 'Pembersih Muka', 30),
(3, 1, 'Toner', 70),
(4, 1, 'Serum', 85),
(5, 1, 'Pelembab', 65),
(6, 1, 'Tabir Surya', 50),
(8, 2, 'Semua Jenis Kulit', 80),
(9, 2, 'Normal', 75),
(10, 2, 'Kering', 70),
(11, 2, 'Berminyak', 60),
(12, 2, 'Berjerawat', 65),
(13, 3, '5 ml - 20 ml', 25),
(14, 3, '30 ml - 60 ml', 60),
(15, 3, '100 ml', 80),
(30, 4, 'Belum Ada', 20),
(31, 4, 'Rating 1 - 3', 50),
(32, 4, 'Rating 4 - 5', 85),
(35, 6, 'Murah (50.000 – 75.000)', 100),
(36, 6, 'Mahal (80.000 – 150.000)', 60),
(37, 6, 'Sangat Mahal (>= 150.000)', 20);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(5) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(70) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `role` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `nama`, `email`, `role`) VALUES
(13, 'admin', '$2y$10$hJ2wO3pdWIjN3Ds14lwSB.1V6V3bsDS28qnKjkEilqeaPNfpq98CG', 'irwan', 'irwan@float.co.id', '1'),
(16, 'admins', '123', 'admin', 'admin@gmail.com', '1');

-- --------------------------------------------------------

--
-- Table structure for table `visitor`
--

CREATE TABLE `visitor` (
  `id_visitor` int(11) NOT NULL,
  `nama_visitor` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visitor`
--

INSERT INTO `visitor` (`id_visitor`, `nama_visitor`, `email`) VALUES
(74, 'sinta', 'sinta@gmail.com'),
(75, 'sinta', 'sinta@gmail.com'),
(76, 'sinta', 'sinta@gmail.com'),
(77, 'sinta', 'sinta@gmail.com'),
(78, 'sinta', 'sinta@gmail.com'),
(79, 'sinta', 'sinta@gmail.com'),
(80, 'sinta', 'sinta@gmail.com'),
(81, 'sinta', 'sinta@gmail.com'),
(82, 'sinta', 'sinta@gmail.com'),
(83, 'sinta', 'sinta@gmail.com'),
(84, 'sinta', 'sinta@gmail.com'),
(85, 'sinta', 'sinta@gmail.com'),
(86, 'sinta', 'sinta@gmail.com'),
(87, 'sinta', 'sinta@gmail.com'),
(88, 'sinta', 'sinta@gmail.com'),
(89, 'sinta', 'sinta@gmail.com'),
(90, 'sinta', 'sinta@gmail.com'),
(91, 'sinta', 'sinta@gmail.com'),
(92, 'sinta', 'sinta@gmail.com'),
(93, 'sinta', 'sinta@gmail.com'),
(94, 'coba2', 'coba2@gmail.com'),
(95, 'sinta', 'sinta@gmail.com'),
(96, 'sinta', 'sinta@gmail.com'),
(97, 'sinta', 'sinta@gmail.com'),
(98, 'sinta', 'sinta@gmail.com'),
(99, 'sinta', 'sinta@gmail.com'),
(100, 'sinta', 'sinta@gmail.com'),
(101, 'sinta', 'sinta@gmail.com'),
(102, 'sinta', 'sinta@gmail.com'),
(103, 'sinta', 'sinta@gmail.com'),
(104, 'sinta', 'sinta@gmail.com'),
(105, 'sinta', 'sinta@gmail.com'),
(106, 'sinta', 'sinta@gmail.com'),
(107, 'sinta', 'sinta@gmail.com'),
(108, 'sinta', 'sinta@gmail.com'),
(109, 'sinta', 'sinta@gmail.com'),
(110, 'sinta', 'sinta@gmail.com'),
(111, 'sinta', 'sinta@gmail.com'),
(112, 'sinta', 'sinta@gmail.com'),
(113, 'sinta', 'sinta@gmail.com'),
(114, 'sinta', 'sinta@gmail.com'),
(115, 'sinta', 'sinta@gmail.com'),
(116, 'sinta', 'sinta@gmail.com'),
(117, 'sinta', 'sinta@gmail.com'),
(118, 'sinta', 'sinta@gmail.com'),
(119, 'sinta', 'sinta@gmail.com'),
(120, 'pak widi', 'widi@gmail.com'),
(121, 'pak widi', 'widi@gmail.com'),
(122, 'pak widi', 'widi@gmail.com'),
(123, 'pak widi', 'widi@gmail.com'),
(124, 'pak widi', 'widi@gmail.com'),
(125, 'pak widi', 'widi@gmail.com'),
(126, 'pak widi', 'widi@gmail.com'),
(127, 'pak widi', 'widi@gmail.com'),
(128, 'pak widi', 'widi@gmail.com'),
(129, 'pak widi', 'widi@gmail.com'),
(130, 'coba', 'coba@gmail.com'),
(131, 'coba', 'coba@gmail.com'),
(132, 'coba', 'coba@gmail.com'),
(133, 'coba', 'coba@gmail.com'),
(134, 'coba', 'coba@gmail.com'),
(135, 'coba', 'coba@gmail.com'),
(136, 'coba', 'coba@gmail.com'),
(137, 'coba', 'coba@gmail.com'),
(138, 'coba', 'coba@gmail.com'),
(139, 'coba', 'coba@gmail.com'),
(140, 'coba', 'coba@gmail.com'),
(141, 'coba', 'coba@gmail.com'),
(142, 'coba', 'coba@gmail.com'),
(143, 'coba', 'coba@gmail.com'),
(144, 'coba', 'coba@gmail.com'),
(145, 'coba', 'coba@gmail.com'),
(146, 'coba', 'coba@gmail.com'),
(147, 'coba', 'coba@gmail.com'),
(148, 'coba', 'coba@gmail.com'),
(149, 'coba', 'coba@gmail.com'),
(150, 'coba', 'coba@gmail.com'),
(151, 'coba', 'coba@gmail.com'),
(152, 'coba', 'coba@gmail.com'),
(153, 'coba', 'coba@gmail.com'),
(154, 'coba', 'coba@gmail.com'),
(155, 'coba', 'coba@gmail.com'),
(156, 'coba', 'coba@gmail.com'),
(157, 'coba', 'coba@gmail.com'),
(158, 'coba', 'coba@gmail.com'),
(159, 'coba', 'coba@gmail.com'),
(160, 'coba', 'coba@gmail.com'),
(161, 'coba', 'coba@gmail.com'),
(162, 'coba', 'coba@gmail.com'),
(163, 'coba', 'coba@gmail.com'),
(164, 'coba', 'coba@gmail.com'),
(165, 'coba', 'coba@gmail.com'),
(166, 'coba', 'coba@gmail.com'),
(167, 'coba', 'coba@gmail.com'),
(168, 'coba', 'coba@gmail.com'),
(169, 'coba', 'coba@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id_brand`);

--
-- Indexes for table `hasil`
--
ALTER TABLE `hasil`
  ADD PRIMARY KEY (`id_hasil`);

--
-- Indexes for table `hasil_rekomendasi`
--
ALTER TABLE `hasil_rekomendasi`
  ADD PRIMARY KEY (`id_hasil_rekomendasi`),
  ADD KEY `id_visitor` (`id_visitor`);

--
-- Indexes for table `hasil_rekomendasi_akhir`
--
ALTER TABLE `hasil_rekomendasi_akhir`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_produk`
--
ALTER TABLE `kategori_produk`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indexes for table `kriteria_visitor`
--
ALTER TABLE `kriteria_visitor`
  ADD PRIMARY KEY (`id_kriteria_visitor`),
  ADD KEY `id_sub_kriteria` (`id_sub_kriteria`);

--
-- Indexes for table `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id_penilaian`),
  ADD KEY `id_kriteria` (`id_kriteria`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `penilaian_temp`
--
ALTER TABLE `penilaian_temp`
  ADD PRIMARY KEY (`id_penilaian`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `id_kategori` (`id_kategori`),
  ADD KEY `id_brand` (`id_brand`);

--
-- Indexes for table `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  ADD PRIMARY KEY (`id_sub_kriteria`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `visitor`
--
ALTER TABLE `visitor`
  ADD PRIMARY KEY (`id_visitor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id_brand` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hasil`
--
ALTER TABLE `hasil`
  MODIFY `id_hasil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `hasil_rekomendasi`
--
ALTER TABLE `hasil_rekomendasi`
  MODIFY `id_hasil_rekomendasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `hasil_rekomendasi_akhir`
--
ALTER TABLE `hasil_rekomendasi_akhir`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kategori_produk`
--
ALTER TABLE `kategori_produk`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `id_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kriteria_visitor`
--
ALTER TABLE `kriteria_visitor`
  MODIFY `id_kriteria_visitor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT for table `penilaian_temp`
--
ALTER TABLE `penilaian_temp`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  MODIFY `id_sub_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `visitor`
--
ALTER TABLE `visitor`
  MODIFY `id_visitor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hasil_rekomendasi`
--
ALTER TABLE `hasil_rekomendasi`
  ADD CONSTRAINT `hasil_rekomendasi_ibfk_1` FOREIGN KEY (`id_visitor`) REFERENCES `visitor` (`id_visitor`);

--
-- Constraints for table `penilaian`
--
ALTER TABLE `penilaian`
  ADD CONSTRAINT `penilaian_ibfk_1` FOREIGN KEY (`id_kriteria`) REFERENCES `sub_kriteria` (`id_sub_kriteria`),
  ADD CONSTRAINT `penilaian_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_produk` (`id_kategori`),
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id_brand`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
