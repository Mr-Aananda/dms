-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 27, 2024 at 03:51 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `khurak`
--

-- --------------------------------------------------------

--
-- Table structure for table `advanced_salaries`
--

CREATE TABLE `advanced_salaries` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `salary_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Advance paid when salary is given',
  `employee_id` bigint UNSIGNED NOT NULL COMMENT 'Employee from users',
  `cash_id` bigint UNSIGNED DEFAULT NULL,
  `bank_account_id` bigint UNSIGNED DEFAULT NULL,
  `date` date NOT NULL COMMENT 'advanced given date',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'positive balance means receive advanced from employee, negative balance means advanced paid to employee',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `description` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `name`, `user_id`, `description`, `active`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'TRB Bank PLC', 1, NULL, 1, NULL, '2024-08-15 03:36:15', '2024-08-15 03:36:15');

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` bigint UNSIGNED NOT NULL,
  `bank_id` bigint UNSIGNED NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `bank_id`, `account_name`, `account_number`, `branch`, `balance`, `user_id`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Khurak Food', '0987654321', 'Mymensingh', 0.00, 1, NULL, NULL, '2024-08-15 03:37:08', '2024-08-17 07:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'For availability value should be true',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `location`, `active`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Maskanda Branch', 'n/a', 1, 'n/a', NULL, '2024-03-21 03:54:10', '2024-03-21 03:54:10');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `user_id`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Khurak', 1, NULL, NULL, '2024-03-31 13:13:52', '2024-03-31 13:13:52'),
(2, 'Pre-Khurak', 1, NULL, NULL, '2024-04-04 12:52:21', '2024-04-04 12:52:21'),
(3, 'R.V', 1, NULL, NULL, '2024-06-08 16:00:51', '2024-06-08 16:00:51');

-- --------------------------------------------------------

--
-- Table structure for table `cashes`
--

CREATE TABLE `cashes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'For availability value should be true',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cashes`
--

INSERT INTO `cashes` (`id`, `name`, `balance`, `branch_id`, `user_id`, `active`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'main cash', 20154.00, 1, 1, 1, NULL, NULL, '2024-04-04 18:54:47', '2024-10-26 11:31:40');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'For availability value should be true',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `user_id`, `active`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, 'energy food', 1, 1, NULL, NULL, '2024-04-03 14:02:58', '2024-04-03 14:02:58'),
(2, 1, 'nuts', 1, 1, NULL, NULL, '2024-04-03 14:03:13', '2024-04-03 14:03:13'),
(3, NULL, 'Masala', 1, 1, NULL, NULL, '2024-04-03 14:03:29', '2024-04-03 14:03:29'),
(4, NULL, 'Baking Item', 1, 1, NULL, NULL, '2024-04-04 11:48:39', '2024-04-04 11:48:39'),
(5, NULL, 'Cooking Oil', 1, 1, NULL, NULL, '2024-04-04 13:43:28', '2024-04-04 13:43:28'),
(6, 1, 'Dry foods', 1, 1, NULL, NULL, '2024-05-02 09:02:18', '2024-05-02 09:02:18'),
(7, NULL, 'Cosmetics', 1, 1, NULL, NULL, '2024-06-08 15:59:55', '2024-06-08 15:59:55'),
(8, NULL, 'Chocolate And Others', 1, 1, NULL, NULL, '2024-06-10 19:45:28', '2024-06-10 19:45:28');

-- --------------------------------------------------------

--
-- Table structure for table `closing_balances`
--

CREATE TABLE `closing_balances` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `closing_balances`
--

INSERT INTO `closing_balances` (`id`, `user_id`, `date`, `amount`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-04-04', 12510.00, '2024-04-04 14:56:52', '2024-04-04 14:56:52'),
(2, 1, '2024-06-01', 17700.00, '2024-06-01 20:18:52', '2024-06-01 20:18:52');

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

CREATE TABLE `damages` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `damage_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE `details` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `detailable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detailable_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT '0.00',
  `quantity_in_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `purchase_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sale_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wholesale_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `return_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount_type` enum('flat','percentage') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(17, '2024-03-31', 52, 'App\\Models\\Sale', 3, 40000.00, '[\"1\",null,null]', 70280.00, 98244.00, 0.00, 0.00, 0.00, 'flat', '2024-04-04 19:02:53', '2024-04-04 19:02:53'),
(18, '2024-03-31', 52, 'App\\Models\\Purchase', 4, 40000.00, '[\"1\",null,null]', 70280.00, 98244.00, 0.00, 0.00, 0.00, 'flat', '2024-04-04 19:03:18', '2024-04-04 19:03:18'),
(19, '2024-04-04', 1, 'App\\Models\\Purchase', 5, 1000.00, '[null,\"1\",null]', 1200.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-04-04 19:19:12', '2024-04-04 19:19:12'),
(20, '2024-04-04', 2, 'App\\Models\\Purchase', 5, 1000.00, '[null,\"1\",null]', 1300.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-04-04 19:19:12', '2024-04-04 19:19:12'),
(21, '2024-04-04', 1, 'App\\Models\\Sale', 4, 1000.00, '[null,\"1\",null]', 1200.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-04-04 19:20:38', '2024-04-04 19:20:38'),
(22, '2024-04-04', 2, 'App\\Models\\Sale', 4, 1000.00, '[null,\"1\",null]', 1300.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-04-04 19:20:38', '2024-04-04 19:20:38'),
(23, '2024-04-04', 53, 'App\\Models\\Purchase', 6, 1000.00, '[null,\"1\",null]', 5500.00, 7285.00, 0.00, 0.00, 0.00, 'flat', '2024-04-04 19:23:27', '2024-04-04 19:23:27'),
(25, '2024-04-04', 1, 'App\\Models\\Purchase', 7, 2000.00, '[null,\"2\",null]', 1050.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(26, '2024-04-04', 2, 'App\\Models\\Purchase', 7, 2000.00, '[null,\"2\",null]', 1250.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(27, '2024-04-04', 3, 'App\\Models\\Purchase', 7, 1000.00, '[null,\"1\",null]', 2800.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(28, '2024-04-04', 4, 'App\\Models\\Purchase', 7, 5000.00, '[null,\"5\",null]', 170.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(29, '2024-04-04', 5, 'App\\Models\\Purchase', 7, 5000.00, '[null,\"5\",null]', 560.00, 750.00, 900.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(30, '2024-04-04', 6, 'App\\Models\\Purchase', 7, 2000.00, '[null,\"2\",null]', 1150.00, 1750.00, 2300.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(31, '2024-04-04', 7, 'App\\Models\\Purchase', 7, 1000.00, '[null,\"1\",null]', 2100.00, 2900.00, 3500.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(32, '2024-04-04', 8, 'App\\Models\\Purchase', 7, 1000.00, '[null,\"1\",null]', 2650.00, 2950.00, 3200.00, 0.00, 0.00, 'flat', '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(33, '2024-04-04', 53, 'App\\Models\\Sale', 5, 1000.00, '[null,\"1\",null]', 5500.00, 7285.00, 0.00, 0.00, 0.00, 'flat', '2024-04-04 19:29:18', '2024-04-04 19:29:18'),
(34, '2024-04-04', 59, 'App\\Models\\Sale', 6, 6.00, '[null,null,\"6\"]', 140.00, 190.00, 220.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(35, '2024-04-04', 58, 'App\\Models\\Sale', 6, 6.00, '[null,null,\"6\"]', 280.00, 380.00, 440.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(36, '2024-04-04', 55, 'App\\Models\\Sale', 6, 10.00, '[null,null,\"10\"]', 52.50, 63.00, 0.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(37, '2024-04-04', 54, 'App\\Models\\Sale', 6, 11.00, '[null,null,\"11\"]', 105.00, 125.00, 140.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(38, '2024-04-04', 57, 'App\\Models\\Sale', 6, 16.00, '[null,null,\"16\"]', 62.50, 75.00, 85.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(39, '2024-04-04', 56, 'App\\Models\\Sale', 6, 7.00, '[null,null,\"7\"]', 125.00, 150.00, 170.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(40, '2024-04-04', 60, 'App\\Models\\Sale', 6, 15.00, '[null,null,\"15\"]', 17.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(53, '2024-04-05', 71, 'App\\Models\\Purchase', 8, 5.00, '[null,null,\"5\"]', 0.00, 190.00, 210.00, 0.00, 0.00, 'flat', '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(54, '2024-04-05', 69, 'App\\Models\\Purchase', 8, 6.00, '[null,null,\"6\"]', 0.00, 130.00, 150.00, 0.00, 0.00, 'flat', '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(55, '2024-04-05', 70, 'App\\Models\\Purchase', 8, 5.00, '[null,null,\"5\"]', 0.00, 85.00, 100.00, 0.00, 0.00, 'flat', '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(56, '2024-04-05', 68, 'App\\Models\\Purchase', 8, 15.00, '[null,null,\"15\"]', 0.00, 85.00, 90.00, 0.00, 0.00, 'flat', '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(57, '2024-04-05', 22, 'App\\Models\\Purchase', 8, 9.00, '[null,null,\"9\"]', 0.00, 80.00, 0.00, 0.00, 0.00, 'flat', '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(74, '2024-04-05', 64, 'App\\Models\\Sale', 8, 20.00, '[null,null,\"20\"]', 57.50, 88.00, 115.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(75, '2024-04-05', 63, 'App\\Models\\Sale', 8, 10.00, '[null,null,\"10\"]', 115.00, 170.00, 230.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(76, '2024-04-05', 67, 'App\\Models\\Sale', 8, 20.00, '[null,null,\"20\"]', 132.50, 148.00, 160.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(77, '2024-04-05', 66, 'App\\Models\\Sale', 8, 14.00, '[null,null,\"14\"]', 105.00, 140.00, 175.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(78, '2024-04-05', 65, 'App\\Models\\Sale', 8, 3.00, '[null,null,\"3\"]', 210.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(79, '2024-04-05', 60, 'App\\Models\\Sale', 8, 35.00, '[null,null,\"35\"]', 17.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(80, '2024-04-05', 58, 'App\\Models\\Sale', 8, 1.00, '[null,null,\"1\"]', 280.00, 380.00, 440.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(81, '2024-04-05', 56, 'App\\Models\\Sale', 8, 5.00, '[null,null,\"5\"]', 125.00, 150.00, 170.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(82, '2024-04-05', 54, 'App\\Models\\Sale', 8, 4.00, '[null,null,\"4\"]', 105.00, 125.00, 140.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(83, '2024-04-05', 71, 'App\\Models\\Sale', 8, 5.00, '[null,null,\"5\"]', 0.00, 190.00, 210.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(84, '2024-04-05', 69, 'App\\Models\\Sale', 8, 6.00, '[null,null,\"6\"]', 0.00, 130.00, 150.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(85, '2024-04-05', 70, 'App\\Models\\Sale', 8, 5.00, '[null,null,\"5\"]', 0.00, 85.00, 100.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(86, '2024-04-05', 68, 'App\\Models\\Sale', 8, 15.00, '[null,null,\"15\"]', 0.00, 85.00, 90.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(87, '2024-04-05', 22, 'App\\Models\\Sale', 8, 9.00, '[null,null,\"9\"]', 0.00, 80.00, 0.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(88, '2024-04-05', 62, 'App\\Models\\Sale', 8, 30.00, '[null,null,\"30\"]', 28.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(89, '2024-04-05', 61, 'App\\Models\\Sale', 8, 35.00, '[null,null,\"35\"]', 56.00, 75.00, 90.00, 0.00, 0.00, 'flat', '2024-04-05 19:53:09', '2024-04-05 19:53:09'),
(91, '2024-04-16', 133, 'App\\Models\\Purchase', 10, 1500.00, '[null,\"1.5\",null]', 240.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-04-16 12:02:15', '2024-04-16 12:02:15'),
(92, '2024-04-16', 1, 'App\\Models\\Purchase', 11, 2500.00, '[null,\"2.5\",null]', 1070.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(93, '2024-04-16', 2, 'App\\Models\\Purchase', 11, 2500.00, '[null,\"2.5\",null]', 1250.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(94, '2024-04-16', 3, 'App\\Models\\Purchase', 11, 1000.00, '[null,\"1\",null]', 2800.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(95, '2024-04-16', 7, 'App\\Models\\Purchase', 11, 1000.00, '[null,\"1\",null]', 2050.00, 2900.00, 3500.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(96, '2024-04-16', 135, 'App\\Models\\Purchase', 11, 2500.00, '[null,\"2.5\",null]', 1920.00, 2100.00, 2250.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(97, '2024-04-16', 118, 'App\\Models\\Purchase', 11, 2500.00, '[null,\"2.5\",null]', 80.00, 520.00, 0.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(98, '2024-04-16', 140, 'App\\Models\\Purchase', 11, 3000.00, '[null,\"3\",null]', 50.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(99, '2024-04-16', 142, 'App\\Models\\Purchase', 11, 1100.00, '[null,\"1.1\",null]', 70.00, 400.00, 550.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(100, '2024-04-16', 144, 'App\\Models\\Purchase', 11, 900.00, '[null,\".9\",null]', 140.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(101, '2024-04-16', 4, 'App\\Models\\Purchase', 11, 2500.00, '[null,\"2.5\",null]', 170.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(102, '2024-04-16', 100, 'App\\Models\\Purchase', 11, 3000.00, '[null,\"3\",null]', 400.00, 800.00, 0.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(103, '2024-04-16', 149, 'App\\Models\\Purchase', 11, 1000.00, '[null,\"1\",null]', 800.00, 1100.00, 1300.00, 0.00, 0.00, 'flat', '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(106, '2024-04-16', 151, 'App\\Models\\Purchase', 12, 12000.00, '[null,\"12\",null]', 0.00, 80.00, 120.00, 0.00, 0.00, 'flat', '2024-04-16 12:25:14', '2024-04-16 12:25:14'),
(107, '2024-04-16', 152, 'App\\Models\\Purchase', 12, 12000.00, '[null,\"12\",null]', 0.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-04-16 12:25:14', '2024-04-16 12:25:14'),
(108, '2024-04-16', 151, 'App\\Models\\Sale', 9, 12000.00, '[null,\"12\",null]', 0.00, 80.00, 120.00, 0.00, 0.00, 'flat', '2024-04-16 12:26:11', '2024-04-16 12:26:11'),
(109, '2024-04-16', 152, 'App\\Models\\Sale', 9, 12000.00, '[null,\"12\",null]', 0.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-04-16 12:26:11', '2024-04-16 12:26:11'),
(133, '2024-04-17', 54, 'App\\Models\\Sale', 10, 15.00, '[null,null,\"15\"]', 115.50, 130.00, 140.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(134, '2024-04-17', 55, 'App\\Models\\Sale', 10, 17.00, '[null,null,\"17\"]', 52.50, 63.00, 0.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(135, '2024-04-17', 56, 'App\\Models\\Sale', 10, 14.00, '[null,null,\"14\"]', 137.50, 162.00, 170.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(136, '2024-04-17', 57, 'App\\Models\\Sale', 10, 18.00, '[null,null,\"18\"]', 68.75, 80.00, 90.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(137, '2024-04-17', 58, 'App\\Models\\Sale', 10, 7.00, '[null,null,\"7\"]', 280.00, 380.00, 440.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(138, '2024-04-17', 59, 'App\\Models\\Sale', 10, 6.00, '[null,null,\"6\"]', 140.00, 190.00, 220.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(139, '2024-04-17', 66, 'App\\Models\\Sale', 10, 9.00, '[null,null,\"9\"]', 115.50, 155.00, 175.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(140, '2024-04-17', 153, 'App\\Models\\Sale', 10, 18.00, '[null,null,\"18\"]', 54.60, 75.00, 90.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(141, '2024-04-17', 136, 'App\\Models\\Sale', 10, 14.00, '[null,null,\"14\"]', 211.20, 232.00, 250.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(142, '2024-04-17', 137, 'App\\Models\\Sale', 10, 17.00, '[null,null,\"17\"]', 105.60, 116.00, 125.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(143, '2024-04-17', 120, 'App\\Models\\Sale', 10, 14.00, '[null,null,\"14\"]', 18.70, 52.00, 0.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(144, '2024-04-17', 121, 'App\\Models\\Sale', 10, 18.00, '[null,null,\"18\"]', 9.82, 26.00, 0.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(145, '2024-04-17', 141, 'App\\Models\\Sale', 10, 29.00, '[null,null,\"29\"]', 5.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(146, '2024-04-17', 143, 'App\\Models\\Sale', 10, 10.00, '[null,null,\"10\"]', 7.70, 40.00, 55.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(147, '2024-04-17', 145, 'App\\Models\\Sale', 10, 8.00, '[null,null,\"8\"]', 14.00, 75.00, 100.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(148, '2024-04-17', 60, 'App\\Models\\Sale', 10, 23.00, '[null,null,\"23\"]', 18.10, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(149, '2024-04-17', 102, 'App\\Models\\Sale', 10, 2.00, '[null,null,\"2\"]', 90.00, 160.00, 0.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(150, '2024-04-17', 103, 'App\\Models\\Sale', 10, 15.00, '[null,null,\"15\"]', 49.50, 88.00, 0.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(151, '2024-04-17', 154, 'App\\Models\\Sale', 10, 19.00, '[null,null,\"19\"]', 22.50, 40.00, 55.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(152, '2024-04-17', 150, 'App\\Models\\Sale', 10, 6.00, '[null,null,\"6\"]', 80.00, 110.00, 130.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(153, '2024-04-17', 155, 'App\\Models\\Sale', 10, 8.00, '[null,null,\"8\"]', 40.00, 55.00, 65.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(154, '2024-04-17', 156, 'App\\Models\\Sale', 10, 7.00, '[null,null,\"7\"]', 48.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(155, '2024-04-17', 134, 'App\\Models\\Sale', 10, 1.00, '[null,null,\"1\"]', 24.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-04-18 19:56:51', '2024-04-18 19:56:51'),
(159, '2024-04-20', 157, 'App\\Models\\Purchase', 13, 24.00, '[null,null,\"24\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-04-20 21:01:34', '2024-04-20 21:01:34'),
(160, '2024-04-20', 32, 'App\\Models\\Purchase', 13, 2000.00, '[null,\"2\",null]', 540.00, 800.00, 1040.00, 0.00, 0.00, 'flat', '2024-04-20 21:01:34', '2024-04-20 21:01:34'),
(161, '2024-04-20', 158, 'App\\Models\\Purchase', 13, 1000.00, '[null,\"1\",null]', 220.00, 700.00, 900.00, 0.00, 0.00, 'flat', '2024-04-20 21:01:34', '2024-04-20 21:01:34'),
(162, '2024-04-21', 157, 'App\\Models\\Sale', 11, 24.00, '[null,null,\"24\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-04-21 19:43:17', '2024-04-21 19:43:17'),
(164, '2024-04-23', 32, 'App\\Models\\Sale', 12, 1700.00, '[null,\"1.7\",null]', 540.00, 800.00, 1040.00, 0.00, 0.00, 'flat', '2024-04-23 11:49:01', '2024-04-23 11:49:01'),
(165, '2024-04-23', 32, 'App\\Models\\Sale', 13, 300.00, '[null,\".3\",null]', 540.00, 0.00, 1040.00, 0.00, 0.00, 'flat', '2024-04-23 11:52:00', '2024-04-23 11:52:00'),
(166, '2024-04-23', 159, 'App\\Models\\Sale', 14, 10.00, '[null,null,\"10\"]', 22.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-04-23 17:34:41', '2024-04-23 17:34:41'),
(183, '2024-04-23', 164, 'App\\Models\\Purchase', 14, 1000.00, '[null,\"1\",null]', 320.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(184, '2024-04-23', 160, 'App\\Models\\Purchase', 14, 700.00, '[null,\".7\",null]', 320.00, 700.00, 1000.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(185, '2024-04-23', 162, 'App\\Models\\Purchase', 14, 700.00, '[null,\".7\",null]', 200.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(186, '2024-04-23', 8, 'App\\Models\\Purchase', 14, 1000.00, '[null,\"1\",null]', 3400.00, 6000.00, 8000.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(187, '2024-04-23', 165, 'App\\Models\\Purchase', 14, 1000.00, '[null,\"1\",null]', 1550.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(188, '2024-04-23', 114, 'App\\Models\\Purchase', 14, 2000.00, '[null,\"2\",null]', 440.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(189, '2024-04-23', 89, 'App\\Models\\Purchase', 14, 2000.00, '[null,\"2\",null]', 640.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(190, '2024-04-23', 98, 'App\\Models\\Purchase', 14, 2000.00, '[null,\"2\",null]', 120.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-04-23 19:45:55', '2024-04-23 19:45:55'),
(191, '2024-04-25', 158, 'App\\Models\\Purchase', 15, 1000.00, '[null,\"1\",null]', 240.00, 700.00, 1000.00, 0.00, 0.00, 'flat', '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(192, '2024-04-25', 167, 'App\\Models\\Purchase', 15, 5000.00, '[null,\"5\",null]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(193, '2024-04-25', 166, 'App\\Models\\Purchase', 15, 5000.00, '[null,\"5\",null]', 90.00, 300.00, 500.00, 0.00, 0.00, 'flat', '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(194, '2024-04-25', 171, 'App\\Models\\Purchase', 16, 1.00, '[null,null,\"1\"]', 0.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-04-25 20:22:08', '2024-04-25 20:22:08'),
(195, '2024-04-25', 170, 'App\\Models\\Purchase', 16, 2.00, '[null,null,\"2\"]', 0.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-04-25 20:22:08', '2024-04-25 20:22:08'),
(196, '2024-04-25', 175, 'App\\Models\\Sale', 15, 12.00, '[null,null,\"12\"]', 32.00, 65.00, 95.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(197, '2024-04-25', 161, 'App\\Models\\Sale', 15, 7.00, '[null,null,\"7\"]', 32.00, 70.00, 100.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(198, '2024-04-25', 169, 'App\\Models\\Sale', 15, 13.00, '[null,null,\"13\"]', 32.00, 75.00, 110.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(199, '2024-04-25', 174, 'App\\Models\\Sale', 15, 10.00, '[null,null,\"10\"]', 128.00, 220.00, 300.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(200, '2024-04-25', 168, 'App\\Models\\Sale', 15, 12.00, '[null,null,\"12\"]', 9.00, 30.00, 50.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(201, '2024-04-25', 173, 'App\\Models\\Sale', 15, 9.00, '[null,null,\"9\"]', 36.00, 90.00, 120.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(202, '2024-04-25', 172, 'App\\Models\\Sale', 15, 136.00, '[null,null,\"136\"]', 15.11, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(203, '2024-04-25', 163, 'App\\Models\\Sale', 15, 7.00, '[null,null,\"7\"]', 20.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(204, '2024-04-25', 170, 'App\\Models\\Sale', 15, 2.00, '[null,null,\"2\"]', 0.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(205, '2024-04-25', 171, 'App\\Models\\Sale', 15, 1.00, '[null,null,\"1\"]', 0.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(206, '2024-04-25', 158, 'App\\Models\\Sale', 16, 1000.00, '[null,\"1\",null]', 240.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-04-25 21:13:17', '2024-04-25 21:13:17'),
(207, '2024-04-29', 176, 'App\\Models\\Purchase', 17, 3000.00, '[null,\"3\",null]', 960.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(208, '2024-04-29', 89, 'App\\Models\\Purchase', 17, 3000.00, '[null,\"3\",null]', 620.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(209, '2024-04-29', 26, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 3800.00, 2100.00, 0.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(210, '2024-04-29', 38, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 110.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(211, '2024-04-29', 35, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 100.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(212, '2024-04-29', 179, 'App\\Models\\Purchase', 17, 500.00, '[null,\".5\",null]', 2600.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(213, '2024-04-29', 86, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 320.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(214, '2024-04-29', 180, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 140.00, 300.00, 400.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(215, '2024-04-29', 19, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 200.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(216, '2024-04-29', 17, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 200.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(217, '2024-04-29', 15, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 200.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(218, '2024-04-29', 178, 'App\\Models\\Purchase', 17, 2000.00, '[null,\"2\",null]', 400.00, 1650.00, 2200.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(219, '2024-04-29', 100, 'App\\Models\\Purchase', 17, 5000.00, '[null,\"5\",null]', 450.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(220, '2024-04-29', 140, 'App\\Models\\Purchase', 17, 5000.00, '[null,\"5\",null]', 60.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(221, '2024-04-29', 128, 'App\\Models\\Purchase', 17, 500.00, '[null,\".5\",null]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(222, '2024-04-29', 6, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 1200.00, 1750.00, 2300.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(223, '2024-04-29', 107, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 1400.00, 2800.00, 3500.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(224, '2024-04-29', 95, 'App\\Models\\Purchase', 17, 2000.00, '[null,\"2\",null]', 820.00, 1300.00, 1600.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(225, '2024-04-29', 110, 'App\\Models\\Purchase', 17, 25000.00, '[null,\"25\",null]', 140.00, 600.00, 0.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(226, '2024-04-29', 162, 'App\\Models\\Purchase', 17, 1000.00, '[null,\"1\",null]', 180.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(259, '2024-05-02', 183, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 940.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(260, '2024-05-02', 4, 'App\\Models\\Purchase', 18, 5000.00, '[null,\"5\",null]', 190.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(261, '2024-05-02', 184, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 950.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(262, '2024-05-02', 100, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 400.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(263, '2024-05-02', 1, 'App\\Models\\Purchase', 18, 10000.00, '[null,\"10\",null]', 1060.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(264, '2024-05-02', 2, 'App\\Models\\Purchase', 18, 10000.00, '[null,\"10\",null]', 1260.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(265, '2024-05-02', 3, 'App\\Models\\Purchase', 18, 3000.00, '[null,\"3\",null]', 2750.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(266, '2024-05-02', 185, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 940.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(267, '2024-05-02', 186, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 1090.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(268, '2024-05-02', 187, 'App\\Models\\Purchase', 18, 5000.00, '[null,\"5\",null]', 270.00, 340.00, 400.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(269, '2024-05-02', 188, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 640.00, 950.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(270, '2024-05-02', 160, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 340.00, 700.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(271, '2024-05-02', 149, 'App\\Models\\Purchase', 18, 3000.00, '[null,\"3\",null]', 720.00, 1100.00, 1300.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(272, '2024-05-02', 189, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 940.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(273, '2024-05-02', 190, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 880.00, 1200.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(274, '2024-05-02', 167, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 350.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(275, '2024-05-02', 32, 'App\\Models\\Purchase', 18, 4000.00, '[null,\"4\",null]', 660.00, 850.00, 1040.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(276, '2024-05-02', 191, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 940.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(277, '2024-05-02', 192, 'App\\Models\\Purchase', 18, 1000.00, '[null,\"1\",null]', 940.00, 1300.00, 0.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(278, '2024-05-02', 193, 'App\\Models\\Purchase', 18, 2000.00, '[null,\"2\",null]', 350.00, 350.00, 450.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(279, '2024-05-02', 194, 'App\\Models\\Purchase', 18, 3000.00, '[null,\"3\",null]', 250.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-05-02 12:03:33', '2024-05-02 12:03:33'),
(303, '2024-05-02', 4, 'App\\Models\\Sale', 29, 5000.00, '[null,\"5\",null]', 190.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(304, '2024-05-02', 187, 'App\\Models\\Sale', 29, 2000.00, '[null,\"2\",null]', 270.00, 340.00, 400.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(305, '2024-05-02', 2, 'App\\Models\\Sale', 29, 9000.00, '[null,\"9\",null]', 1260.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(306, '2024-05-02', 1, 'App\\Models\\Sale', 29, 9000.00, '[null,\"9\",null]', 1060.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(307, '2024-05-02', 32, 'App\\Models\\Sale', 29, 2000.00, '[null,\"2\",null]', 660.00, 850.00, 1040.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(308, '2024-05-02', 3, 'App\\Models\\Sale', 29, 2800.00, '[null,\"2.8\",null]', 2750.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(309, '2024-05-02', 149, 'App\\Models\\Sale', 29, 2000.00, '[null,\"2\",null]', 720.00, 1100.00, 1300.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(310, '2024-05-02', 193, 'App\\Models\\Sale', 29, 1000.00, '[null,\"1\",null]', 350.00, 350.00, 450.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(311, '2024-05-02', 194, 'App\\Models\\Sale', 29, 1000.00, '[null,\"1\",null]', 250.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(312, '2024-05-02', 160, 'App\\Models\\Sale', 29, 1000.00, '[null,\"1\",null]', 340.00, 500.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(313, '2024-05-02', 195, 'App\\Models\\Sale', 29, 51.00, '[null,null,\"51\"]', 156.00, 270.00, 350.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(314, '2024-05-02', 197, 'App\\Models\\Sale', 29, 10.00, '[null,null,\"10\"]', 125.00, 220.00, 270.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(315, '2024-05-02', 196, 'App\\Models\\Sale', 29, 40.00, '[null,null,\"40\"]', 193.00, 270.00, 330.00, 0.00, 0.00, 'flat', '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(316, '2024-05-03', 198, 'App\\Models\\Purchase', 19, 5000.00, '[null,\"5\",null]', 920.00, 1000.00, 1350.00, 0.00, 0.00, 'flat', '2024-05-03 16:49:28', '2024-05-03 16:49:28'),
(317, '2024-05-03', 199, 'App\\Models\\Purchase', 19, 5000.00, '[null,\"5\",null]', 420.00, 500.00, 650.00, 0.00, 0.00, 'flat', '2024-05-03 16:49:28', '2024-05-03 16:49:28'),
(320, '2024-05-03', 198, 'App\\Models\\Sale', 30, 5000.00, '[null,\"5\",null]', 920.00, 1000.00, 1350.00, 0.00, 0.00, 'flat', '2024-05-03 18:59:27', '2024-05-03 18:59:27'),
(321, '2024-05-03', 199, 'App\\Models\\Sale', 30, 5000.00, '[null,\"5\",null]', 420.00, 500.00, 650.00, 0.00, 0.00, 'flat', '2024-05-03 18:59:27', '2024-05-03 18:59:27'),
(322, '2024-05-03', 98, 'App\\Models\\Sale', 30, 1300.00, '[null,\"1.300\",null]', 120.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-05-03 18:59:27', '2024-05-03 18:59:27'),
(323, '2024-05-04', 181, 'App\\Models\\Purchase', 20, 2.00, '[null,null,\"2\"]', 0.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(324, '2024-05-04', 64, 'App\\Models\\Purchase', 20, 2.00, '[null,null,\"2\"]', 0.00, 88.00, 115.00, 0.00, 0.00, 'flat', '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(325, '2024-05-04', 202, 'App\\Models\\Purchase', 20, 10.00, '[null,null,\"10\"]', 0.00, 70.00, 100.00, 0.00, 0.00, 'flat', '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(326, '2024-05-04', 67, 'App\\Models\\Sale', 31, 6.00, '[null,null,\"6\"]', 170.00, 220.00, 270.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(327, '2024-05-04', 9, 'App\\Models\\Sale', 31, 16.00, '[null,null,\"16\"]', 340.00, 430.00, 500.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(328, '2024-05-04', 71, 'App\\Models\\Sale', 31, 6.00, '[null,null,\"6\"]', 155.00, 190.00, 230.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(329, '2024-05-04', 201, 'App\\Models\\Sale', 31, 12.00, '[null,null,\"12\"]', 32.00, 48.00, 65.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(330, '2024-05-04', 200, 'App\\Models\\Sale', 31, 6.00, '[null,null,\"6\"]', 88.00, 120.00, 150.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(331, '2024-05-04', 181, 'App\\Models\\Sale', 31, 2.00, '[null,null,\"2\"]', 0.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(332, '2024-05-04', 64, 'App\\Models\\Sale', 31, 2.00, '[null,null,\"2\"]', 0.00, 88.00, 115.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:59', '2024-05-04 14:32:59'),
(333, '2024-05-04', 202, 'App\\Models\\Sale', 31, 10.00, '[null,null,\"10\"]', 0.00, 70.00, 100.00, 0.00, 0.00, 'flat', '2024-05-04 14:32:59', '2024-05-04 14:32:59'),
(334, '2024-05-04', 114, 'App\\Models\\Sale', 32, 1100.00, '[null,\"1.1\",null]', 440.00, 0.00, 950.00, 0.00, 0.00, 'flat', '2024-05-04 14:38:10', '2024-05-04 14:38:10'),
(348, '2024-05-05', 166, 'App\\Models\\Purchase', 21, 25000.00, '[null,\"25\",null]', 78.00, 300.00, 500.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(349, '2024-05-05', 167, 'App\\Models\\Purchase', 21, 30000.00, '[null,\"30\",null]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(350, '2024-05-05', 38, 'App\\Models\\Purchase', 21, 60000.00, '[null,\"60\",null]', 105.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(351, '2024-05-05', 114, 'App\\Models\\Purchase', 21, 20000.00, '[null,\"20\",null]', 480.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(352, '2024-05-05', 179, 'App\\Models\\Purchase', 21, 2000.00, '[null,\"2\",null]', 2800.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(353, '2024-05-05', 17, 'App\\Models\\Purchase', 21, 12000.00, '[null,\"12\",null]', 185.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(354, '2024-05-05', 19, 'App\\Models\\Purchase', 21, 12000.00, '[null,\"12\",null]', 185.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(355, '2024-05-05', 92, 'App\\Models\\Purchase', 21, 2000.00, '[null,\"2\",null]', 1440.00, 900.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(356, '2024-05-05', 128, 'App\\Models\\Purchase', 21, 2000.00, '[null,\"2\",null]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(357, '2024-05-05', 204, 'App\\Models\\Purchase', 21, 12000.00, '[null,\"12\",null]', 255.00, 290.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(358, '2024-05-05', 205, 'App\\Models\\Purchase', 21, 12.00, '[null,null,\"12\"]', 155.00, 190.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(359, '2024-05-05', 206, 'App\\Models\\Purchase', 21, 500.00, '[null,\".5\",null]', 600.00, 900.00, 1200.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(360, '2024-05-05', 207, 'App\\Models\\Purchase', 21, 500.00, '[null,\".5\",null]', 980.00, 1400.00, 2000.00, 0.00, 0.00, 'flat', '2024-05-06 13:55:40', '2024-05-06 13:55:40'),
(361, '2024-05-06', 166, 'App\\Models\\Sale', 33, 25000.00, '[null,\"25\",null]', 78.00, 140.00, 500.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(362, '2024-05-06', 38, 'App\\Models\\Sale', 33, 60000.00, '[null,\"60\",null]', 105.00, 200.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(363, '2024-05-06', 167, 'App\\Models\\Sale', 33, 30000.00, '[null,\"30\",null]', 320.00, 550.00, 1100.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(364, '2024-05-06', 114, 'App\\Models\\Sale', 33, 20000.00, '[null,\"20\",null]', 480.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(365, '2024-05-06', 179, 'App\\Models\\Sale', 33, 2000.00, '[null,\"2\",null]', 2800.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(366, '2024-05-06', 17, 'App\\Models\\Sale', 33, 12000.00, '[null,\"12\",null]', 185.00, 370.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(367, '2024-05-06', 19, 'App\\Models\\Sale', 33, 12000.00, '[null,\"12\",null]', 185.00, 370.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(368, '2024-05-06', 92, 'App\\Models\\Sale', 33, 2000.00, '[null,\"2\",null]', 1440.00, 1700.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(369, '2024-05-06', 128, 'App\\Models\\Sale', 33, 2000.00, '[null,\"2\",null]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(370, '2024-05-06', 204, 'App\\Models\\Sale', 33, 12000.00, '[null,\"12\",null]', 255.00, 290.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(371, '2024-05-06', 205, 'App\\Models\\Sale', 33, 12.00, '[null,null,\"12\"]', 155.00, 190.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(372, '2024-05-06', 206, 'App\\Models\\Sale', 33, 500.00, '[null,null,\"500\"]', 600.00, 900.00, 1200.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(373, '2024-05-06', 207, 'App\\Models\\Sale', 33, 500.00, '[null,null,\"500\"]', 980.00, 1400.00, 2000.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(374, '2024-05-06', 141, 'App\\Models\\Sale', 33, 32.00, '[null,null,\"32\"]', 6.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(375, '2024-05-02', 90, 'App\\Models\\Sale', 28, 19.00, '[null,null,\"19\"]', 62.00, 90.00, 120.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(376, '2024-05-02', 91, 'App\\Models\\Sale', 28, 20.00, '[null,null,\"20\"]', 31.00, 60.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(377, '2024-05-02', 27, 'App\\Models\\Sale', 28, 6.00, '[null,null,\"6\"]', 380.00, 500.00, 600.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(378, '2024-05-02', 28, 'App\\Models\\Sale', 28, 13.00, '[null,null,\"13\"]', 190.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(379, '2024-05-02', 39, 'App\\Models\\Sale', 28, 10.00, '[null,null,\"10\"]', 11.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(380, '2024-05-02', 36, 'App\\Models\\Sale', 28, 10.00, '[null,null,\"10\"]', 10.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(381, '2024-05-02', 37, 'App\\Models\\Sale', 28, 1.00, '[null,null,\"1\"]', 5.00, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(382, '2024-05-02', 16, 'App\\Models\\Sale', 28, 11.00, '[null,null,\"11\"]', 20.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(383, '2024-05-02', 18, 'App\\Models\\Sale', 28, 11.00, '[null,null,\"11\"]', 20.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(384, '2024-05-02', 20, 'App\\Models\\Sale', 28, 9.00, '[null,null,\"9\"]', 20.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(385, '2024-05-02', 101, 'App\\Models\\Sale', 28, 10.00, '[null,null,\"10\"]', 180.00, 320.00, 440.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(386, '2024-05-02', 102, 'App\\Models\\Sale', 28, 6.00, '[null,null,\"6\"]', 90.00, 160.00, 220.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(387, '2024-05-02', 141, 'App\\Models\\Sale', 28, 19.00, '[null,null,\"19\"]', 6.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(388, '2024-05-02', 130, 'App\\Models\\Sale', 28, 12.00, '[null,null,\"12\"]', 150.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(389, '2024-05-02', 96, 'App\\Models\\Sale', 28, 31.00, '[null,null,\"31\"]', 82.00, 90.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(390, '2024-05-02', 181, 'App\\Models\\Sale', 28, 11.00, '[null,null,\"11\"]', 14.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(391, '2024-05-02', 182, 'App\\Models\\Sale', 28, 11.00, '[null,null,\"11\"]', 260.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(392, '2024-05-02', 87, 'App\\Models\\Sale', 28, 12.00, '[null,null,\"12\"]', 32.00, 70.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(393, '2024-05-02', 109, 'App\\Models\\Sale', 28, 20.00, '[null,null,\"20\"]', 70.00, 70.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(394, '2024-05-02', 63, 'App\\Models\\Sale', 28, 12.00, '[null,null,\"12\"]', 120.00, 170.00, 230.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(395, '2024-05-02', 177, 'App\\Models\\Sale', 28, 36.00, '[null,null,\"36\"]', 76.80, 96.00, 115.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(396, '2024-05-02', 111, 'App\\Models\\Sale', 28, 50.00, '[null,null,\"50\"]', 70.00, 150.00, 0.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(397, '2024-05-02', 162, 'App\\Models\\Sale', 28, 1000.00, '[null,\"1\",null]', 180.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-05-06 19:48:31', '2024-05-06 19:48:31'),
(398, '2024-05-08', 5, 'App\\Models\\Purchase', 22, 10000.00, '[null,\"10\",null]', 630.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-08 21:10:35', '2024-05-08 21:10:35'),
(399, '2024-05-08', 4, 'App\\Models\\Purchase', 22, 20000.00, '[null,\"20\",null]', 165.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-05-08 21:10:35', '2024-05-08 21:10:35'),
(400, '2024-05-08', 98, 'App\\Models\\Purchase', 22, 4500.00, '[null,\"4.5\",null]', 110.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-05-08 21:10:35', '2024-05-08 21:10:35'),
(401, '2024-05-08', 5, 'App\\Models\\Sale', 34, 10000.00, '[null,\"10\",null]', 630.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-08 21:15:47', '2024-05-08 21:15:47'),
(402, '2024-05-08', 4, 'App\\Models\\Sale', 34, 20000.00, '[null,\"20\",null]', 165.00, 300.00, 500.00, 0.00, 0.00, 'flat', '2024-05-08 21:15:47', '2024-05-08 21:15:47'),
(403, '2024-05-08', 98, 'App\\Models\\Sale', 34, 4500.00, '[null,\"4.5\",null]', 110.00, 200.00, 350.00, 0.00, 0.00, 'flat', '2024-05-08 21:15:47', '2024-05-08 21:15:47'),
(406, '2024-05-17', 208, 'App\\Models\\Sale', 35, 76.00, '[null,null,\"76\"]', 10.00, 43.00, 60.00, 0.00, 0.00, 'flat', '2024-05-17 18:04:31', '2024-05-17 18:04:31'),
(407, '2024-05-17', 102, 'App\\Models\\Sale', 35, 5.00, '[null,null,\"5\"]', 80.00, 160.00, 220.00, 0.00, 0.00, 'flat', '2024-05-17 18:04:31', '2024-05-17 18:04:31'),
(408, '2024-05-18', 209, 'App\\Models\\Purchase', 23, 10000.00, '[null,\"10\",null]', 930.00, 1250.00, 1550.00, 0.00, 0.00, 'flat', '2024-05-18 14:12:42', '2024-05-18 14:12:42'),
(409, '2024-05-18', 210, 'App\\Models\\Purchase', 23, 20.00, '[null,null,\"20\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-05-18 14:12:42', '2024-05-18 14:12:42'),
(410, '2024-05-18', 209, 'App\\Models\\Sale', 36, 10000.00, '[null,\"10\",null]', 930.00, 1250.00, 1550.00, 0.00, 0.00, 'flat', '2024-05-18 14:20:55', '2024-05-18 14:20:55'),
(411, '2024-05-18', 210, 'App\\Models\\Sale', 36, 20.00, '[null,null,\"20\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-05-18 14:20:55', '2024-05-18 14:20:55'),
(412, '2024-05-22', 3, 'App\\Models\\Purchase', 24, 2000.00, '[null,\"2\",null]', 2750.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-05-22 08:37:23', '2024-05-22 08:37:23'),
(413, '2024-05-22', 149, 'App\\Models\\Purchase', 24, 3000.00, '[null,\"3\",null]', 720.00, 1100.00, 1300.00, 0.00, 0.00, 'flat', '2024-05-22 08:37:23', '2024-05-22 08:37:23'),
(414, '2024-05-22', 3, 'App\\Models\\Sale', 37, 2000.00, '[null,\"2\",null]', 2750.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-05-22 08:38:31', '2024-05-22 08:38:31'),
(416, '2024-05-26', 86, 'App\\Models\\Purchase', 26, 2000.00, '[null,\"2\",null]', 320.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(417, '2024-05-26', 165, 'App\\Models\\Purchase', 26, 2000.00, '[null,\"2\",null]', 1460.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(418, '2024-05-26', 144, 'App\\Models\\Purchase', 26, 2000.00, '[null,\"2\",null]', 160.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(419, '2024-05-26', 104, 'App\\Models\\Purchase', 26, 1000.00, '[null,\"1\",null]', 140.00, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(420, '2024-05-26', 211, 'App\\Models\\Purchase', 26, 1000.00, '[null,\"1\",null]', 110.00, 230.00, 350.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(421, '2024-05-26', 158, 'App\\Models\\Purchase', 26, 2000.00, '[null,\"2\",null]', 240.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(422, '2024-05-26', 160, 'App\\Models\\Purchase', 26, 1000.00, '[null,\"1\",null]', 320.00, 700.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(423, '2024-05-26', 164, 'App\\Models\\Purchase', 26, 2500.00, '[null,\"2.5\",null]', 288.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(424, '2024-05-26', 157, 'App\\Models\\Purchase', 25, 25.00, '[null,null,\"25\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-05-26 16:16:50', '2024-05-26 16:16:50'),
(425, '2024-05-26', 212, 'App\\Models\\Sale', 38, 13.00, '[null,null,\"13\"]', 8.47, 23.00, 35.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(426, '2024-05-26', 175, 'App\\Models\\Sale', 38, 12.00, '[null,null,\"12\"]', 24.00, 65.00, 95.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(427, '2024-05-26', 164, 'App\\Models\\Sale', 38, 1500.00, '[null,\"1.5\",null]', 288.00, 325.00, 950.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(428, '2024-05-26', 160, 'App\\Models\\Sale', 38, 1000.00, '[null,\"1\",null]', 320.00, 700.00, 1000.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(429, '2024-05-26', 159, 'App\\Models\\Sale', 38, 20.00, '[null,null,\"20\"]', 24.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(430, '2024-05-26', 157, 'App\\Models\\Sale', 38, 25.00, '[null,null,\"25\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(431, '2024-05-26', 155, 'App\\Models\\Sale', 38, 14.00, '[null,null,\"14\"]', 60.00, 55.00, 65.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(432, '2024-05-26', 150, 'App\\Models\\Sale', 38, 15.00, '[null,null,\"15\"]', 90.00, 110.00, 130.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(433, '2024-05-26', 145, 'App\\Models\\Sale', 38, 19.00, '[null,null,\"19\"]', 16.85, 75.00, 100.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(434, '2024-05-26', 106, 'App\\Models\\Sale', 38, 12.00, '[null,null,\"12\"]', 11.67, 20.00, 0.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(435, '2024-05-26', 87, 'App\\Models\\Sale', 38, 21.00, '[null,null,\"21\"]', 31.00, 70.00, 0.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(436, '2024-05-26', 71, 'App\\Models\\Sale', 38, 23.00, '[null,null,\"23\"]', 127.00, 190.00, 230.00, 0.00, 0.00, 'flat', '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(437, '2024-05-28', 89, 'App\\Models\\Purchase', 27, 2000.00, '[null,\"2\",null]', 720.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-05-28 19:34:23', '2024-05-28 19:34:23'),
(438, '2024-05-28', 86, 'App\\Models\\Purchase', 27, 2000.00, '[null,\"2\",null]', 320.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-05-28 19:34:23', '2024-05-28 19:34:23'),
(439, '2024-05-28', 86, 'App\\Models\\Sale', 39, 2000.00, '[null,\"2\",null]', 320.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-05-28 19:35:21', '2024-05-28 19:35:21'),
(440, '2024-05-28', 89, 'App\\Models\\Sale', 39, 2000.00, '[null,\"2\",null]', 720.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-05-28 19:35:21', '2024-05-28 19:35:21'),
(441, '2024-06-01', 89, 'App\\Models\\Purchase', 28, 5000.00, '[null,\"5\",null]', 685.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-06-01 20:10:17', '2024-06-01 20:10:17'),
(442, '2024-06-01', 89, 'App\\Models\\Sale', 40, 5000.00, '[null,\"5\",null]', 685.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-06-01 20:12:32', '2024-06-01 20:12:32'),
(443, '2024-06-04', 26, 'App\\Models\\Purchase', 29, 1000.00, '[null,\"1\",null]', 3600.00, 5000.00, 6000.00, 0.00, 0.00, 'flat', '2024-06-04 20:55:05', '2024-06-04 20:55:05'),
(444, '2024-06-04', 5, 'App\\Models\\Purchase', 29, 10000.00, '[null,\"10\",null]', 600.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-06-04 20:55:05', '2024-06-04 20:55:05'),
(445, '2024-06-05', 213, 'App\\Models\\Purchase', 30, 5000.00, '[null,\"5\",null]', 330.00, 600.00, 800.00, 0.00, 0.00, 'flat', '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(446, '2024-06-05', 214, 'App\\Models\\Purchase', 30, 5000.00, '[null,\"5\",null]', 230.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(447, '2024-06-05', 215, 'App\\Models\\Purchase', 30, 2000.00, '[null,\"2\",null]', 730.00, 1400.00, 1800.00, 0.00, 0.00, 'flat', '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(448, '2024-06-05', 216, 'App\\Models\\Purchase', 30, 5000.00, '[null,\"5\",null]', 490.00, 700.00, 900.00, 0.00, 0.00, 'flat', '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(449, '2024-06-05', 86, 'App\\Models\\Purchase', 30, 3000.00, '[null,\"3\",null]', 330.00, 700.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(450, '2024-06-06', 210, 'App\\Models\\Purchase', 31, 50.00, '[null,null,\"50\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(451, '2024-06-06', 2, 'App\\Models\\Purchase', 31, 10000.00, '[null,\"10\",null]', 1280.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(452, '2024-06-06', 1, 'App\\Models\\Purchase', 31, 10000.00, '[null,\"10\",null]', 1080.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(453, '2024-06-06', 100, 'App\\Models\\Purchase', 31, 10000.00, '[null,\"10\",null]', 370.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(454, '2024-06-06', 199, 'App\\Models\\Purchase', 31, 5000.00, '[null,\"5\",null]', 410.00, 470.00, 650.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(455, '2024-06-06', 198, 'App\\Models\\Purchase', 31, 5000.00, '[null,\"5\",null]', 960.00, 1000.00, 1350.00, 0.00, 0.00, 'flat', '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(456, '2024-06-06', 216, 'App\\Models\\Sale', 41, 5000.00, '[null,\"5\",null]', 490.00, 700.00, 900.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(457, '2024-06-06', 215, 'App\\Models\\Sale', 41, 2000.00, '[null,\"2\",null]', 730.00, 1400.00, 1800.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(458, '2024-06-06', 214, 'App\\Models\\Sale', 41, 5000.00, '[null,\"5\",null]', 230.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42');
INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(459, '2024-06-06', 213, 'App\\Models\\Sale', 41, 5000.00, '[null,\"5\",null]', 330.00, 600.00, 800.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(460, '2024-06-06', 210, 'App\\Models\\Sale', 41, 50.00, '[null,null,\"50\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(461, '2024-06-06', 199, 'App\\Models\\Sale', 41, 5000.00, '[null,\"5\",null]', 410.00, 470.00, 650.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(462, '2024-06-06', 198, 'App\\Models\\Sale', 41, 5000.00, '[null,\"5\",null]', 960.00, 1000.00, 1350.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(463, '2024-06-06', 100, 'App\\Models\\Sale', 41, 10000.00, '[null,\"10\",null]', 370.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(464, '2024-06-06', 86, 'App\\Models\\Sale', 41, 3000.00, '[null,\"3\",null]', 330.00, 700.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(465, '2024-06-06', 26, 'App\\Models\\Sale', 41, 1000.00, '[null,\"1\",null]', 3600.00, 5000.00, 6000.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(466, '2024-06-06', 5, 'App\\Models\\Sale', 41, 10000.00, '[null,\"10\",null]', 600.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(467, '2024-06-06', 2, 'App\\Models\\Sale', 41, 10000.00, '[null,\"10\",null]', 1280.00, 1500.00, 1700.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(468, '2024-06-06', 1, 'App\\Models\\Sale', 41, 10000.00, '[null,\"10\",null]', 1080.00, 1250.00, 1400.00, 0.00, 0.00, 'flat', '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(469, '2024-06-07', 217, 'App\\Models\\Purchase', 32, 1000.00, '[null,\"1\",null]', 9720.00, 10440.00, 13950.00, 0.00, 0.00, 'flat', '2024-06-07 17:04:16', '2024-06-07 17:04:16'),
(470, '2024-06-07', 217, 'App\\Models\\Sale', 42, 1000.00, '[null,\"1\",null]', 9720.00, 10440.00, 13950.00, 0.00, 0.00, 'flat', '2024-06-07 17:05:12', '2024-06-07 17:05:12'),
(471, '2024-06-08', 218, 'App\\Models\\Purchase', 33, 24.00, '[null,null,\"24\"]', 85.00, 100.00, 165.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(472, '2024-06-08', 219, 'App\\Models\\Purchase', 33, 12.00, '[null,null,\"12\"]', 75.00, 100.00, 180.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(473, '2024-06-08', 220, 'App\\Models\\Purchase', 33, 12.00, '[null,null,\"12\"]', 55.00, 70.00, 110.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(474, '2024-06-08', 221, 'App\\Models\\Purchase', 33, 12.00, '[null,null,\"12\"]', 90.00, 100.00, 140.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(475, '2024-06-08', 222, 'App\\Models\\Purchase', 33, 12.00, '[null,null,\"12\"]', 85.00, 100.00, 140.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(476, '2024-06-08', 223, 'App\\Models\\Purchase', 33, 6.00, '[null,null,\"6\"]', 150.00, 185.00, 265.00, 0.00, 0.00, 'flat', '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(477, '2024-06-08', 218, 'App\\Models\\Sale', 43, 24.00, '[null,null,\"24\"]', 85.00, 100.00, 165.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(478, '2024-06-08', 219, 'App\\Models\\Sale', 43, 12.00, '[null,null,\"12\"]', 75.00, 100.00, 180.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(479, '2024-06-08', 220, 'App\\Models\\Sale', 43, 12.00, '[null,null,\"12\"]', 55.00, 70.00, 110.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(480, '2024-06-08', 221, 'App\\Models\\Sale', 43, 12.00, '[null,null,\"12\"]', 90.00, 100.00, 140.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(481, '2024-06-08', 222, 'App\\Models\\Sale', 43, 12.00, '[null,null,\"12\"]', 85.00, 100.00, 140.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(482, '2024-06-08', 223, 'App\\Models\\Sale', 43, 6.00, '[null,null,\"6\"]', 150.00, 185.00, 265.00, 0.00, 0.00, 'flat', '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(484, '2024-06-08', 160, 'App\\Models\\Purchase', 34, 1000.00, '[null,\"1\",null]', 350.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-06-08 21:07:40', '2024-06-08 21:07:40'),
(485, '2024-06-08', 160, 'App\\Models\\Sale', 44, 1000.00, '[null,\"1\",null]', 350.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-06-08 21:09:48', '2024-06-08 21:09:48'),
(494, '2024-06-09', 233, 'App\\Models\\Purchase', 36, 2.00, '[\"2\"]', 60.00, 75.00, 100.00, 0.00, 0.00, 'flat', '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(495, '2024-06-09', 234, 'App\\Models\\Purchase', 36, 2.00, '[\"2\"]', 120.00, 150.00, 190.00, 0.00, 0.00, 'flat', '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(496, '2024-06-09', 235, 'App\\Models\\Purchase', 36, 24.00, '[\"24\"]', 16.50, 20.00, 50.00, 0.00, 0.00, 'flat', '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(497, '2024-06-09', 236, 'App\\Models\\Purchase', 36, 12.00, '[\"12\"]', 50.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(498, '2024-06-09', 224, 'App\\Models\\Purchase', 35, 6.00, '[\"6\"]', 135.00, 170.00, 220.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(499, '2024-06-09', 225, 'App\\Models\\Purchase', 35, 6.00, '[\"6\"]', 180.00, 230.00, 295.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(500, '2024-06-09', 226, 'App\\Models\\Purchase', 35, 6.00, '[\"6\"]', 115.00, 145.00, 180.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(501, '2024-06-09', 228, 'App\\Models\\Purchase', 35, 6.00, '[\"6\"]', 115.00, 150.00, 210.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(502, '2024-06-09', 229, 'App\\Models\\Purchase', 35, 6.00, '[\"6\"]', 170.00, 220.00, 300.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(503, '2024-06-09', 230, 'App\\Models\\Purchase', 35, 12.00, '[\"12\"]', 170.00, 230.00, 300.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(504, '2024-06-09', 231, 'App\\Models\\Purchase', 35, 12.00, '[\"12\"]', 75.00, 130.00, 180.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(505, '2024-06-09', 232, 'App\\Models\\Purchase', 35, 12.00, '[\"12\"]', 110.00, 135.00, 220.00, 0.00, 0.00, 'flat', '2024-06-09 16:28:32', '2024-06-09 16:28:32'),
(506, '2024-06-09', 224, 'App\\Models\\Sale', 45, 6.00, '[\"6\"]', 135.00, 170.00, 220.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(507, '2024-06-09', 225, 'App\\Models\\Sale', 45, 6.00, '[\"6\"]', 180.00, 230.00, 295.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(508, '2024-06-09', 226, 'App\\Models\\Sale', 45, 6.00, '[\"6\"]', 115.00, 145.00, 180.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(509, '2024-06-09', 228, 'App\\Models\\Sale', 45, 6.00, '[\"6\"]', 115.00, 150.00, 210.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(510, '2024-06-09', 229, 'App\\Models\\Sale', 45, 6.00, '[\"6\"]', 170.00, 220.00, 300.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(511, '2024-06-09', 230, 'App\\Models\\Sale', 45, 12.00, '[\"12\"]', 170.00, 230.00, 300.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(512, '2024-06-09', 231, 'App\\Models\\Sale', 45, 12.00, '[\"12\"]', 75.00, 130.00, 180.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(513, '2024-06-09', 232, 'App\\Models\\Sale', 45, 12.00, '[\"12\"]', 110.00, 135.00, 220.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(514, '2024-06-09', 233, 'App\\Models\\Sale', 45, 2.00, '[\"2\"]', 60.00, 75.00, 100.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(515, '2024-06-09', 234, 'App\\Models\\Sale', 45, 2.00, '[\"2\"]', 120.00, 150.00, 190.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(516, '2024-06-09', 235, 'App\\Models\\Sale', 45, 24.00, '[\"24\"]', 16.50, 20.00, 50.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(517, '2024-06-09', 236, 'App\\Models\\Sale', 45, 12.00, '[\"12\"]', 50.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(518, '2024-06-09', 237, 'App\\Models\\Purchase', 37, 40000.00, '[null,\"40\",null]', 168.70, 240.00, 360.00, 0.00, 0.00, 'flat', '2024-06-09 16:47:22', '2024-06-09 16:47:22'),
(519, '2024-06-10', 238, 'App\\Models\\Purchase', 38, 60.00, '[\"60\"]', 14.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(520, '2024-06-10', 239, 'App\\Models\\Purchase', 38, 48.00, '[\"48\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(521, '2024-06-10', 240, 'App\\Models\\Purchase', 38, 40.00, '[\"40\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(522, '2024-06-10', 241, 'App\\Models\\Purchase', 38, 40.00, '[\"40\"]', 21.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(523, '2024-06-10', 242, 'App\\Models\\Purchase', 38, 20.00, '[\"20\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(524, '2024-06-10', 243, 'App\\Models\\Purchase', 38, 20.00, '[\"20\"]', 190.00, 210.00, 280.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(525, '2024-06-10', 244, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 36.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(526, '2024-06-10', 245, 'App\\Models\\Purchase', 38, 15.00, '[\"15\"]', 60.00, 67.00, 80.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(527, '2024-06-10', 246, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(528, '2024-06-10', 247, 'App\\Models\\Purchase', 38, 28.00, '[\"28\"]', 11.00, 12.00, 15.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(529, '2024-06-10', 248, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(530, '2024-06-10', 249, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 82.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(531, '2024-06-10', 250, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 80.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(532, '2024-06-10', 251, 'App\\Models\\Purchase', 38, 3.00, '[\"3\"]', 345.00, 370.00, 460.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(533, '2024-06-10', 252, 'App\\Models\\Purchase', 38, 3.00, '[\"3\"]', 540.00, 590.00, 790.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(534, '2024-06-10', 253, 'App\\Models\\Purchase', 38, 2.00, '[\"2\"]', 1170.00, 1200.00, 1450.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(535, '2024-06-10', 254, 'App\\Models\\Purchase', 38, 2.00, '[\"2\"]', 500.00, 600.00, 790.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(536, '2024-06-10', 255, 'App\\Models\\Purchase', 38, 2.00, '[\"2\"]', 620.00, 750.00, 990.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(537, '2024-06-10', 256, 'App\\Models\\Purchase', 38, 9.00, '[\"9\"]', 750.00, 880.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(538, '2024-06-10', 257, 'App\\Models\\Purchase', 38, 20.00, '[\"20\"]', 25.00, 28.00, 35.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(539, '2024-06-10', 258, 'App\\Models\\Purchase', 38, 9.00, '[\"9\"]', 500.00, 550.00, 750.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(540, '2024-06-10', 259, 'App\\Models\\Purchase', 38, 48.00, '[\"48\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(541, '2024-06-10', 260, 'App\\Models\\Purchase', 38, 160.00, '[\"160\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(542, '2024-06-10', 261, 'App\\Models\\Purchase', 38, 52.00, '[\"52\"]', 135.00, 140.00, 160.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(543, '2024-06-10', 262, 'App\\Models\\Purchase', 38, 24.00, '[\"24\"]', 285.00, 300.00, 350.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(544, '2024-06-10', 263, 'App\\Models\\Purchase', 38, 48.00, '[\"48\"]', 115.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(545, '2024-06-10', 238, 'App\\Models\\Sale', 46, 60.00, '[\"60\"]', 14.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(546, '2024-06-10', 239, 'App\\Models\\Sale', 46, 48.00, '[\"48\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(547, '2024-06-10', 240, 'App\\Models\\Sale', 46, 40.00, '[\"40\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(548, '2024-06-10', 241, 'App\\Models\\Sale', 46, 40.00, '[\"40\"]', 21.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(549, '2024-06-10', 242, 'App\\Models\\Sale', 46, 20.00, '[\"20\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(550, '2024-06-10', 243, 'App\\Models\\Sale', 46, 20.00, '[\"20\"]', 190.00, 210.00, 280.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(551, '2024-06-10', 244, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 36.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(552, '2024-06-10', 245, 'App\\Models\\Sale', 46, 15.00, '[\"15\"]', 60.00, 67.00, 80.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(553, '2024-06-10', 246, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(554, '2024-06-10', 247, 'App\\Models\\Sale', 46, 28.00, '[\"28\"]', 11.00, 12.00, 15.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(555, '2024-06-10', 248, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(556, '2024-06-10', 249, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 82.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(557, '2024-06-10', 250, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 80.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(558, '2024-06-10', 251, 'App\\Models\\Sale', 46, 3.00, '[\"3\"]', 345.00, 370.00, 460.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(559, '2024-06-10', 252, 'App\\Models\\Sale', 46, 3.00, '[\"3\"]', 540.00, 590.00, 790.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(560, '2024-06-10', 253, 'App\\Models\\Sale', 46, 2.00, '[\"2\"]', 1170.00, 1200.00, 1450.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(561, '2024-06-10', 254, 'App\\Models\\Sale', 46, 2.00, '[\"2\"]', 500.00, 600.00, 790.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(562, '2024-06-10', 255, 'App\\Models\\Sale', 46, 2.00, '[\"2\"]', 620.00, 750.00, 990.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(563, '2024-06-10', 256, 'App\\Models\\Sale', 46, 9.00, '[\"9\"]', 750.00, 880.00, 1100.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(564, '2024-06-10', 257, 'App\\Models\\Sale', 46, 20.00, '[\"20\"]', 25.00, 28.00, 35.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(565, '2024-06-10', 258, 'App\\Models\\Sale', 46, 9.00, '[\"9\"]', 500.00, 550.00, 750.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(566, '2024-06-10', 259, 'App\\Models\\Sale', 46, 48.00, '[\"48\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(567, '2024-06-10', 260, 'App\\Models\\Sale', 46, 160.00, '[\"160\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(568, '2024-06-10', 261, 'App\\Models\\Sale', 46, 52.00, '[\"52\"]', 135.00, 140.00, 160.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(569, '2024-06-10', 262, 'App\\Models\\Sale', 46, 24.00, '[\"24\"]', 285.00, 300.00, 350.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(570, '2024-06-10', 263, 'App\\Models\\Sale', 46, 48.00, '[\"48\"]', 115.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(571, '2024-06-11', 237, 'App\\Models\\Sale', 47, 40000.00, '[\"1\",null,null]', 168.70, 240.00, 360.00, 0.00, 0.00, 'flat', '2024-06-11 21:55:48', '2024-06-11 21:55:48'),
(583, '2024-06-13', 264, 'App\\Models\\Purchase', 39, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(584, '2024-06-13', 265, 'App\\Models\\Purchase', 39, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(585, '2024-06-13', 266, 'App\\Models\\Purchase', 39, 76.00, '[\"76\"]', 13.50, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(586, '2024-06-13', 267, 'App\\Models\\Purchase', 39, 2.00, '[\"2\"]', 551.00, 670.00, 895.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(587, '2024-06-13', 268, 'App\\Models\\Purchase', 39, 82.00, '[\"82\"]', 12.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(588, '2024-06-13', 269, 'App\\Models\\Purchase', 39, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(589, '2024-06-13', 270, 'App\\Models\\Purchase', 39, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:16', '2024-06-13 17:50:16'),
(590, '2024-06-13', 271, 'App\\Models\\Purchase', 39, 48.00, '[\"48\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:17', '2024-06-13 17:50:17'),
(591, '2024-06-13', 272, 'App\\Models\\Purchase', 39, 60.00, '[\"60\"]', 13.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:17', '2024-06-13 17:50:17'),
(592, '2024-06-13', 273, 'App\\Models\\Purchase', 39, 48.00, '[\"48\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:17', '2024-06-13 17:50:17'),
(593, '2024-06-13', 274, 'App\\Models\\Purchase', 39, 24.00, '[\"24\"]', 94.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-06-13 17:50:17', '2024-06-13 17:50:17'),
(594, '2024-06-13', 264, 'App\\Models\\Sale', 48, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(595, '2024-06-13', 265, 'App\\Models\\Sale', 48, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(596, '2024-06-13', 266, 'App\\Models\\Sale', 48, 76.00, '[\"76\"]', 13.50, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(597, '2024-06-13', 267, 'App\\Models\\Sale', 48, 2.00, '[\"2\"]', 551.00, 670.00, 895.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(598, '2024-06-13', 268, 'App\\Models\\Sale', 48, 82.00, '[\"82\"]', 12.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(599, '2024-06-13', 269, 'App\\Models\\Sale', 48, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(600, '2024-06-13', 270, 'App\\Models\\Sale', 48, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(601, '2024-06-13', 271, 'App\\Models\\Sale', 48, 48.00, '[\"48\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(602, '2024-06-13', 272, 'App\\Models\\Sale', 48, 60.00, '[\"60\"]', 13.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(603, '2024-06-13', 273, 'App\\Models\\Sale', 48, 48.00, '[\"48\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(604, '2024-06-13', 274, 'App\\Models\\Sale', 48, 24.00, '[\"24\"]', 94.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(605, '2024-06-13', 89, 'App\\Models\\Purchase', 40, 10000.00, '[null,\"10\",null]', 680.00, 900.00, 1300.00, 0.00, 0.00, 'flat', '2024-06-13 19:01:11', '2024-06-13 19:01:11'),
(606, '2024-06-14', 89, 'App\\Models\\Purchase', 41, 5000.00, '[null,\"5\",null]', 680.00, 0.00, 1300.00, 0.00, 0.00, 'flat', '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(607, '2024-06-14', 194, 'App\\Models\\Purchase', 41, 5000.00, '[null,\"5\",null]', 185.00, 360.00, 600.00, 0.00, 0.00, 'flat', '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(608, '2024-06-14', 21, 'App\\Models\\Purchase', 41, 1000.00, '[null,\"1\",null]', 510.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(609, '2024-06-14', 89, 'App\\Models\\Sale', 49, 15000.00, '[null,\"15\",null]', 680.00, 780.00, 1300.00, 0.00, 0.00, 'flat', '2024-06-14 13:51:59', '2024-06-14 13:51:59'),
(610, '2024-06-14', 21, 'App\\Models\\Sale', 49, 1000.00, '[null,\"1\",null]', 510.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-06-14 13:51:59', '2024-06-14 13:51:59'),
(611, '2024-06-14', 194, 'App\\Models\\Sale', 49, 5000.00, '[null,\"5\",null]', 185.00, 360.00, 600.00, 0.00, 0.00, 'flat', '2024-06-14 13:51:59', '2024-06-14 13:51:59'),
(624, '2024-06-14', 275, 'App\\Models\\Purchase', 42, 24.00, '[\"24\"]', 110.00, 150.00, 245.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(625, '2024-06-14', 276, 'App\\Models\\Purchase', 42, 24.00, '[\"24\"]', 205.00, 270.00, 365.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(626, '2024-06-14', 277, 'App\\Models\\Purchase', 42, 12.00, '[\"12\"]', 80.00, 105.00, 140.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(627, '2024-06-14', 278, 'App\\Models\\Purchase', 42, 24.00, '[\"24\"]', 120.00, 140.00, 170.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(628, '2024-06-14', 279, 'App\\Models\\Purchase', 42, 20.00, '[\"20\"]', 210.00, 325.00, 399.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(629, '2024-06-14', 280, 'App\\Models\\Purchase', 42, 12.00, '[\"12\"]', 70.00, 100.00, 170.00, 0.00, 0.00, 'flat', '2024-06-14 20:23:58', '2024-06-14 20:23:58'),
(630, '2024-06-14', 275, 'App\\Models\\Sale', 50, 24.00, '[\"24\"]', 110.00, 150.00, 245.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(631, '2024-06-14', 276, 'App\\Models\\Sale', 50, 24.00, '[\"24\"]', 205.00, 270.00, 365.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(632, '2024-06-14', 277, 'App\\Models\\Sale', 50, 12.00, '[\"12\"]', 80.00, 105.00, 140.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(633, '2024-06-14', 278, 'App\\Models\\Sale', 50, 24.00, '[\"24\"]', 120.00, 140.00, 170.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(634, '2024-06-14', 279, 'App\\Models\\Sale', 50, 20.00, '[\"20\"]', 210.00, 325.00, 399.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(635, '2024-06-14', 280, 'App\\Models\\Sale', 50, 12.00, '[\"12\"]', 70.00, 100.00, 115.00, 0.00, 0.00, 'flat', '2024-06-14 20:25:03', '2024-06-14 20:25:03'),
(636, '2024-06-15', 23, 'App\\Models\\Purchase', 43, 720.00, '[null,\".72\",null]', 700.00, 1150.00, 1600.00, 0.00, 4.00, 'flat', '2024-06-15 23:17:50', '2024-06-15 23:17:50'),
(637, '2024-06-15', 23, 'App\\Models\\Sale', 51, 720.00, '[null,null,\"720\"]', 700.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-06-15 23:18:34', '2024-06-15 23:18:34'),
(640, '2024-06-24', 213, 'App\\Models\\Purchase', 44, 10000.00, '[null,\"10\",null]', 310.00, 490.00, 660.00, 0.00, 0.00, 'flat', '2024-06-24 20:22:37', '2024-06-24 20:22:37'),
(641, '2024-06-24', 216, 'App\\Models\\Purchase', 44, 10000.00, '[null,\"10\",null]', 300.00, 480.00, 650.00, 0.00, 0.00, 'flat', '2024-06-24 20:22:37', '2024-06-24 20:22:37'),
(642, '2024-06-25', 281, 'App\\Models\\Purchase', 45, 12.00, '[\"12\"]', 550.00, 650.00, 850.00, 0.00, 0.00, 'flat', '2024-06-25 18:38:37', '2024-06-25 18:38:37'),
(643, '2024-06-25', 282, 'App\\Models\\Purchase', 45, 24.00, '[\"24\"]', 440.00, 490.00, 720.00, 0.00, 0.00, 'flat', '2024-06-25 18:38:37', '2024-06-25 18:38:37'),
(644, '2024-06-25', 281, 'App\\Models\\Sale', 52, 12.00, '[\"12\"]', 550.00, 650.00, 850.00, 0.00, 0.00, 'flat', '2024-06-25 18:46:15', '2024-06-25 18:46:15'),
(645, '2024-06-25', 282, 'App\\Models\\Sale', 52, 24.00, '[\"24\"]', 440.00, 490.00, 720.00, 0.00, 0.00, 'flat', '2024-06-25 18:46:15', '2024-06-25 18:46:15'),
(653, '2024-06-25', 83, 'App\\Models\\Purchase', 46, 1000.00, '[null,\"1\",null]', 160.00, 340.00, 500.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(654, '2024-06-25', 114, 'App\\Models\\Purchase', 46, 5000.00, '[null,\"5\",null]', 420.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(655, '2024-06-25', 140, 'App\\Models\\Purchase', 46, 5000.00, '[null,\"5\",null]', 52.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(656, '2024-06-25', 21, 'App\\Models\\Purchase', 46, 2000.00, '[null,\"2\",null]', 480.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(657, '2024-06-25', 215, 'App\\Models\\Purchase', 46, 2000.00, '[null,\"2\",null]', 730.00, 1400.00, 1800.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(658, '2024-06-25', 8, 'App\\Models\\Purchase', 46, 1000.00, '[null,\"1\",null]', 3600.00, 6000.00, 8000.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(659, '2024-06-25', 160, 'App\\Models\\Purchase', 46, 5000.00, '[null,\"5\",null]', 280.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-06-25 21:50:18', '2024-06-25 21:50:18'),
(660, '2024-06-26', 283, 'App\\Models\\Purchase', 47, 30.00, '[\"30\"]', 270.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-06-26 14:28:35', '2024-06-26 14:28:35'),
(661, '2024-06-26', 283, 'App\\Models\\Sale', 53, 30.00, '[\"30\"]', 270.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-06-26 14:29:24', '2024-06-26 14:29:24'),
(662, '2024-06-27', 32, 'App\\Models\\Purchase', 48, 10000.00, '[null,\"10\",null]', 625.00, 850.00, 1040.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(663, '2024-06-27', 110, 'App\\Models\\Purchase', 48, 25000.00, '[null,\"25\",null]', 142.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(664, '2024-06-27', 204, 'App\\Models\\Purchase', 48, 12000.00, '[null,\"12\",null]', 265.00, 290.00, 475.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(665, '2024-06-27', 205, 'App\\Models\\Purchase', 48, 12.00, '[null,null,\"12\"]', 150.00, 190.00, 275.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(666, '2024-06-27', 98, 'App\\Models\\Purchase', 48, 3000.00, '[null,\"3\",null]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(667, '2024-06-27', 4, 'App\\Models\\Purchase', 48, 20000.00, '[null,\"20\",null]', 175.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(668, '2024-06-27', 284, 'App\\Models\\Sale', 54, 20.00, '[null,null,\"20\"]', 90.00, 120.00, 145.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(669, '2024-06-27', 216, 'App\\Models\\Sale', 54, 10000.00, '[null,\"10\",null]', 300.00, 480.00, 650.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(670, '2024-06-27', 215, 'App\\Models\\Sale', 54, 2000.00, '[null,\"2\",null]', 730.00, 1400.00, 1800.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(671, '2024-06-27', 213, 'App\\Models\\Sale', 54, 10000.00, '[null,\"10\",null]', 310.00, 490.00, 660.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(672, '2024-06-27', 205, 'App\\Models\\Sale', 54, 12.00, '[null,null,\"12\"]', 150.00, 190.00, 275.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(673, '2024-06-27', 204, 'App\\Models\\Sale', 54, 12000.00, '[null,\"12\",null]', 265.00, 290.00, 475.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(674, '2024-06-27', 161, 'App\\Models\\Sale', 54, 41.00, '[null,null,\"41\"]', 28.00, 70.00, 100.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(675, '2024-06-27', 140, 'App\\Models\\Sale', 54, 5000.00, '[null,\"5\",null]', 52.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(676, '2024-06-27', 114, 'App\\Models\\Sale', 54, 5000.00, '[null,\"5\",null]', 420.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(677, '2024-06-27', 110, 'App\\Models\\Sale', 54, 25000.00, '[null,\"25\",null]', 142.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(678, '2024-06-27', 98, 'App\\Models\\Sale', 54, 3000.00, '[null,\"3\",null]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(679, '2024-06-27', 83, 'App\\Models\\Sale', 54, 1000.00, '[null,\"1\",null]', 160.00, 340.00, 500.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(680, '2024-06-27', 32, 'App\\Models\\Sale', 54, 10000.00, '[null,\"10\",null]', 625.00, 850.00, 1040.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(681, '2024-06-27', 28, 'App\\Models\\Sale', 54, 15.00, '[null,null,\"15\"]', 180.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(682, '2024-06-27', 21, 'App\\Models\\Sale', 54, 2000.00, '[null,\"2\",null]', 480.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(683, '2024-06-27', 4, 'App\\Models\\Sale', 54, 20000.00, '[null,\"20\",null]', 175.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(684, '2024-06-30', 1, 'App\\Models\\Purchase', 49, 10000.00, '[null,\"10\",null]', 1080.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(685, '2024-06-30', 2, 'App\\Models\\Purchase', 49, 10000.00, '[null,\"10\",null]', 1270.00, 1400.00, 1700.00, 0.00, 0.00, 'flat', '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(686, '2024-06-30', 193, 'App\\Models\\Purchase', 49, 5000.00, '[null,\"5\",null]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(687, '2024-06-30', 32, 'App\\Models\\Purchase', 49, 10000.00, '[null,\"10\",null]', 640.00, 800.00, 1040.00, 0.00, 0.00, 'flat', '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(688, '2024-06-30', 1, 'App\\Models\\Sale', 55, 10000.00, '[null,\"10\",null]', 1080.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(689, '2024-06-30', 2, 'App\\Models\\Sale', 55, 10000.00, '[null,\"10\",null]', 1270.00, 1400.00, 1700.00, 0.00, 0.00, 'flat', '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(690, '2024-06-30', 193, 'App\\Models\\Sale', 55, 5000.00, '[null,\"5\",null]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(691, '2024-06-30', 32, 'App\\Models\\Sale', 55, 10000.00, '[null,\"10\",null]', 640.00, 800.00, 1040.00, 0.00, 0.00, 'flat', '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(692, '2024-07-04', 287, 'App\\Models\\Purchase', 50, 20.00, '[\"20\"]', 50.00, 57.00, 90.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(693, '2024-07-04', 288, 'App\\Models\\Purchase', 50, 6.00, '[\"6\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(694, '2024-07-04', 289, 'App\\Models\\Purchase', 50, 6.00, '[\"6\"]', 130.00, 145.00, 210.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(695, '2024-07-04', 290, 'App\\Models\\Purchase', 50, 12.00, '[\"12\"]', 110.00, 125.00, 200.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(696, '2024-07-04', 291, 'App\\Models\\Purchase', 50, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(697, '2024-07-04', 292, 'App\\Models\\Purchase', 50, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(698, '2024-07-04', 274, 'App\\Models\\Purchase', 50, 48.00, '[\"48\"]', 94.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(699, '2024-07-04', 239, 'App\\Models\\Purchase', 50, 48.00, '[\"48\"]', 38.00, 45.00, 65.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(700, '2024-07-04', 238, 'App\\Models\\Purchase', 50, 48.00, '[\"48\"]', 27.00, 30.00, 45.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(701, '2024-07-04', 293, 'App\\Models\\Purchase', 50, 12.00, '[\"12\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(702, '2024-07-04', 294, 'App\\Models\\Purchase', 50, 36.00, '[\"36\"]', 105.00, 117.00, 140.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(703, '2024-07-04', 248, 'App\\Models\\Purchase', 50, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(704, '2024-07-04', 249, 'App\\Models\\Purchase', 50, 36.00, '[\"36\"]', 82.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(705, '2024-07-04', 295, 'App\\Models\\Purchase', 50, 24.00, '[\"24\"]', 108.00, 120.00, 150.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(706, '2024-07-04', 265, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 14.00, 17.00, 25.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(707, '2024-07-04', 269, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 14.00, 17.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(708, '2024-07-04', 264, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(709, '2024-07-04', 270, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 15.00, 18.00, 30.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(710, '2024-07-04', 246, 'App\\Models\\Purchase', 50, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(711, '2024-07-04', 259, 'App\\Models\\Purchase', 50, 96.00, '[\"96\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(712, '2024-07-04', 300, 'App\\Models\\Purchase', 50, 40.00, '[\"40\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(713, '2024-07-04', 298, 'App\\Models\\Purchase', 50, 48.00, '[\"48\"]', 37.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(714, '2024-07-04', 299, 'App\\Models\\Purchase', 50, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(715, '2024-07-04', 296, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 13.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(716, '2024-07-04', 297, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 13.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(717, '2024-07-04', 268, 'App\\Models\\Purchase', 50, 60.00, '[\"60\"]', 12.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(718, '2024-07-04', 301, 'App\\Models\\Purchase', 50, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(746, '2024-07-04', 301, 'App\\Models\\Sale', 56, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(747, '2024-07-04', 300, 'App\\Models\\Sale', 56, 40.00, '[\"40\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(748, '2024-07-04', 299, 'App\\Models\\Sale', 56, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(749, '2024-07-04', 298, 'App\\Models\\Sale', 56, 48.00, '[\"48\"]', 37.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(750, '2024-07-04', 297, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 13.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(751, '2024-07-04', 296, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 13.00, 16.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(752, '2024-07-04', 295, 'App\\Models\\Sale', 56, 24.00, '[\"24\"]', 108.00, 120.00, 150.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(753, '2024-07-04', 294, 'App\\Models\\Sale', 56, 36.00, '[\"36\"]', 105.00, 117.00, 140.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(754, '2024-07-04', 293, 'App\\Models\\Sale', 56, 12.00, '[\"12\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(755, '2024-07-04', 292, 'App\\Models\\Sale', 56, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(756, '2024-07-04', 291, 'App\\Models\\Sale', 56, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(757, '2024-07-04', 290, 'App\\Models\\Sale', 56, 12.00, '[\"12\"]', 110.00, 125.00, 200.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(758, '2024-07-04', 289, 'App\\Models\\Sale', 56, 6.00, '[\"6\"]', 130.00, 145.00, 210.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(759, '2024-07-04', 288, 'App\\Models\\Sale', 56, 6.00, '[\"6\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(760, '2024-07-04', 287, 'App\\Models\\Sale', 56, 20.00, '[\"20\"]', 50.00, 57.00, 90.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(761, '2024-07-04', 274, 'App\\Models\\Sale', 56, 48.00, '[\"48\"]', 94.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(762, '2024-07-04', 270, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 15.00, 18.00, 30.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(763, '2024-07-04', 269, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 14.00, 17.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(764, '2024-07-04', 268, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 12.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(765, '2024-07-04', 265, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 14.00, 17.00, 25.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(766, '2024-07-04', 264, 'App\\Models\\Sale', 56, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(767, '2024-07-04', 259, 'App\\Models\\Sale', 56, 96.00, '[\"96\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(768, '2024-07-04', 249, 'App\\Models\\Sale', 56, 36.00, '[\"36\"]', 82.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(769, '2024-07-04', 248, 'App\\Models\\Sale', 56, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(770, '2024-07-04', 246, 'App\\Models\\Sale', 56, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(771, '2024-07-04', 239, 'App\\Models\\Sale', 56, 48.00, '[\"48\"]', 38.00, 45.00, 65.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(772, '2024-07-04', 238, 'App\\Models\\Sale', 56, 48.00, '[\"48\"]', 27.00, 30.00, 45.00, 0.00, 0.00, 'flat', '2024-07-06 19:43:52', '2024-07-06 19:43:52'),
(778, '2024-07-11', 21, 'App\\Models\\Sale', 57, 5000.00, '[\"5000\"]', 470.00, 600.00, 700.00, 0.00, 0.00, 'flat', '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(779, '2024-07-11', 302, 'App\\Models\\Sale', 57, 100.00, '[\"100\"]', 11.00, 17.50, 25.00, 0.00, 0.00, 'flat', '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(780, '2024-07-11', 26, 'App\\Models\\Sale', 57, 1000.00, '[\"1000\"]', 3300.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(781, '2024-07-11', 29, 'App\\Models\\Sale', 57, 1000.00, '[\"1000\"]', 2700.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(782, '2024-07-11', 141, 'App\\Models\\Sale', 57, 50.00, '[\"50\"]', 6.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(783, '2024-07-11', 21, 'App\\Models\\Purchase', 51, 5000.00, '[\"5000\"]', 470.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-07-11 20:44:53', '2024-07-11 20:44:53'),
(784, '2024-07-11', 302, 'App\\Models\\Purchase', 51, 100.00, '[\"100\"]', 11.00, 17.00, 25.00, 0.00, 0.00, 'flat', '2024-07-11 20:44:53', '2024-07-11 20:44:53'),
(785, '2024-07-11', 26, 'App\\Models\\Purchase', 51, 1000.00, '[\"1000\"]', 3300.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-07-11 20:44:53', '2024-07-11 20:44:53'),
(786, '2024-07-11', 29, 'App\\Models\\Purchase', 51, 1000.00, '[\"1000\"]', 2700.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-07-11 20:44:53', '2024-07-11 20:44:53'),
(787, '2024-07-11', 140, 'App\\Models\\Purchase', 51, 5000.00, '[\"5000\"]', 50.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-07-11 20:44:53', '2024-07-11 20:44:53'),
(788, '2024-07-11', 281, 'App\\Models\\Purchase', 52, 24.00, '[\"24\"]', 520.00, 650.00, 850.00, 0.00, 0.00, 'flat', '2024-07-11 20:57:37', '2024-07-11 20:57:37'),
(789, '2024-07-11', 281, 'App\\Models\\Sale', 58, 24.00, '[\"24\"]', 520.00, 650.00, 850.00, 0.00, 0.00, 'flat', '2024-07-11 20:58:27', '2024-07-11 20:58:27'),
(790, '2024-07-16', 210, 'App\\Models\\Purchase', 53, 50.00, '[\"50\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-07-16 14:22:06', '2024-07-16 14:22:06'),
(791, '2024-07-16', 210, 'App\\Models\\Sale', 59, 50.00, '[\"50\"]', 465.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-07-16 14:22:51', '2024-07-16 14:22:51'),
(795, '2024-07-24', 99, 'App\\Models\\Purchase', 54, 25.00, '[\"25\"]', 11.20, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-07-24 15:11:38', '2024-07-24 15:11:38'),
(796, '2024-07-24', 4, 'App\\Models\\Purchase', 54, 20.00, '[\"20\"]', 165.00, 250.00, 380.00, 0.00, 0.00, 'flat', '2024-07-24 15:11:38', '2024-07-24 15:11:38'),
(797, '2024-07-24', 105, 'App\\Models\\Purchase', 54, 25.00, '[\"25\"]', 10.40, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-07-24 15:11:38', '2024-07-24 15:11:38'),
(798, '2024-07-24', 99, 'App\\Models\\Sale', 60, 25.00, '[\"25\"]', 11.20, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-07-24 15:15:11', '2024-07-24 15:15:11'),
(799, '2024-07-24', 105, 'App\\Models\\Sale', 60, 25.00, '[\"25\"]', 10.40, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-07-24 15:15:11', '2024-07-24 15:15:11'),
(800, '2024-07-24', 4, 'App\\Models\\Sale', 60, 20.00, '[\"20\"]', 165.00, 250.00, 380.00, 0.00, 0.00, 'flat', '2024-07-24 15:15:11', '2024-07-24 15:15:11'),
(801, '2024-07-30', 244, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 41.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(802, '2024-07-30', 303, 'App\\Models\\Purchase', 55, 120.00, '[\"120\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(803, '2024-07-30', 304, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(804, '2024-07-30', 242, 'App\\Models\\Purchase', 55, 40.00, '[\"40\"]', 88.00, 98.00, 125.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(805, '2024-07-30', 305, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 44.00, 50.00, 70.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(806, '2024-07-30', 300, 'App\\Models\\Purchase', 55, 40.00, '[\"40\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(807, '2024-07-30', 283, 'App\\Models\\Purchase', 55, 20.00, '[\"20\"]', 290.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(808, '2024-07-30', 306, 'App\\Models\\Purchase', 55, 200.00, '[\"200\"]', 11.00, 12.50, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(809, '2024-07-30', 307, 'App\\Models\\Purchase', 55, 300.00, '[\"300\"]', 6.00, 7.00, 10.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(810, '2024-07-30', 308, 'App\\Models\\Purchase', 55, 6.00, '[\"6\"]', 150.00, 155.00, 200.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(811, '2024-07-30', 309, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 82.00, 90.00, 130.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(812, '2024-07-30', 287, 'App\\Models\\Purchase', 55, 20.00, '[\"20\"]', 50.00, 57.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(813, '2024-07-30', 52, 'App\\Models\\Purchase', 55, 6.00, '[\"6\"]', 176.00, 190.00, 280.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(814, '2024-07-30', 288, 'App\\Models\\Purchase', 55, 6.00, '[\"6\"]', 220.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(815, '2024-07-30', 311, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 25.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(816, '2024-07-30', 312, 'App\\Models\\Purchase', 55, 50.00, '[\"50\"]', 21.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(817, '2024-07-30', 295, 'App\\Models\\Purchase', 55, 72.00, '[\"72\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(818, '2024-07-30', 313, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 80.00, 88.00, 110.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(819, '2024-07-30', 314, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 235.00, 260.00, 325.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(820, '2024-07-30', 315, 'App\\Models\\Purchase', 55, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(821, '2024-07-30', 316, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 220.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(822, '2024-07-30', 246, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(823, '2024-07-30', 317, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 31.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(824, '2024-07-30', 299, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 11.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(825, '2024-07-30', 243, 'App\\Models\\Purchase', 55, 40.00, '[\"40\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(826, '2024-07-30', 318, 'App\\Models\\Purchase', 55, 32.00, '[\"32\"]', 130.00, 145.00, 210.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(827, '2024-07-30', 319, 'App\\Models\\Purchase', 55, 48.00, '[\"48\"]', 12.00, 14.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(828, '2024-07-30', 320, 'App\\Models\\Purchase', 55, 12.00, '[\"12\"]', 100.00, 110.00, 150.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(829, '2024-07-30', 292, 'App\\Models\\Purchase', 55, 60.00, '[\"60\"]', 24.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(830, '2024-07-30', 291, 'App\\Models\\Purchase', 55, 120.00, '[\"120\"]', 24.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(831, '2024-07-30', 321, 'App\\Models\\Purchase', 55, 12.00, '[\"12\"]', 25.00, 30.00, 60.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(832, '2024-07-30', 322, 'App\\Models\\Purchase', 55, 24.00, '[\"24\"]', 67.00, 74.00, 105.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(833, '2024-07-30', 323, 'App\\Models\\Purchase', 55, 48.00, '[\"48\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(834, '2024-07-30', 248, 'App\\Models\\Purchase', 55, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(835, '2024-07-30', 324, 'App\\Models\\Purchase', 55, 6.00, '[\"6\"]', 620.00, 670.00, 890.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(836, '2024-07-30', 325, 'App\\Models\\Purchase', 55, 20.00, '[\"20\"]', 61.00, 67.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(837, '2024-07-30', 326, 'App\\Models\\Purchase', 55, 48.00, '[\"48\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(838, '2024-07-30', 327, 'App\\Models\\Purchase', 55, 112.00, '[\"112\"]', 13.00, 15.00, 25.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(839, '2024-07-30', 310, 'App\\Models\\Purchase', 55, 6.00, '[\"6\"]', 245.00, 290.00, 400.00, 0.00, 0.00, 'flat', '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(840, '2024-07-30', 244, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 41.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(841, '2024-07-30', 303, 'App\\Models\\Sale', 61, 120.00, '[\"120\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12');
INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(842, '2024-07-30', 304, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(843, '2024-07-30', 242, 'App\\Models\\Sale', 61, 40.00, '[\"40\"]', 88.00, 98.00, 125.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(844, '2024-07-30', 305, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 44.00, 50.00, 70.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(845, '2024-07-30', 300, 'App\\Models\\Sale', 61, 40.00, '[\"40\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(846, '2024-07-30', 283, 'App\\Models\\Sale', 61, 20.00, '[\"20\"]', 290.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(847, '2024-07-30', 306, 'App\\Models\\Sale', 61, 200.00, '[\"200\"]', 11.00, 12.50, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(848, '2024-07-30', 307, 'App\\Models\\Sale', 61, 300.00, '[\"300\"]', 6.00, 7.00, 10.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(849, '2024-07-30', 308, 'App\\Models\\Sale', 61, 6.00, '[\"6\"]', 150.00, 155.00, 200.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(850, '2024-07-30', 309, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 82.00, 90.00, 130.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(851, '2024-07-30', 287, 'App\\Models\\Sale', 61, 20.00, '[\"20\"]', 50.00, 57.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(852, '2024-07-30', 52, 'App\\Models\\Sale', 61, 6.00, '[\"6\"]', 176.00, 190.00, 280.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(853, '2024-07-30', 288, 'App\\Models\\Sale', 61, 6.00, '[\"6\"]', 220.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(854, '2024-07-30', 311, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 25.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(855, '2024-07-30', 312, 'App\\Models\\Sale', 61, 50.00, '[\"50\"]', 21.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(856, '2024-07-30', 295, 'App\\Models\\Sale', 61, 72.00, '[\"72\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(857, '2024-07-30', 313, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 80.00, 88.00, 110.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(858, '2024-07-30', 314, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 235.00, 260.00, 325.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(859, '2024-07-30', 315, 'App\\Models\\Sale', 61, 180.00, '[\"180\"]', 22.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(860, '2024-07-30', 316, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 220.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(861, '2024-07-30', 246, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 100.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(862, '2024-07-30', 317, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 31.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(863, '2024-07-30', 299, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 11.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(864, '2024-07-30', 243, 'App\\Models\\Sale', 61, 40.00, '[\"40\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(865, '2024-07-30', 318, 'App\\Models\\Sale', 61, 32.00, '[\"32\"]', 130.00, 145.00, 210.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(866, '2024-07-30', 319, 'App\\Models\\Sale', 61, 48.00, '[\"48\"]', 12.00, 14.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(867, '2024-07-30', 320, 'App\\Models\\Sale', 61, 12.00, '[\"12\"]', 100.00, 110.00, 150.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(868, '2024-07-30', 292, 'App\\Models\\Sale', 61, 60.00, '[\"60\"]', 24.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(869, '2024-07-30', 291, 'App\\Models\\Sale', 61, 120.00, '[\"120\"]', 24.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(870, '2024-07-30', 321, 'App\\Models\\Sale', 61, 12.00, '[\"12\"]', 25.00, 30.00, 60.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(871, '2024-07-30', 322, 'App\\Models\\Sale', 61, 24.00, '[\"24\"]', 67.00, 74.00, 105.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(872, '2024-07-30', 323, 'App\\Models\\Sale', 61, 48.00, '[\"48\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(873, '2024-07-30', 248, 'App\\Models\\Sale', 61, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(874, '2024-07-30', 324, 'App\\Models\\Sale', 61, 6.00, '[\"6\"]', 620.00, 670.00, 890.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(875, '2024-07-30', 325, 'App\\Models\\Sale', 61, 20.00, '[\"20\"]', 61.00, 67.00, 90.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(876, '2024-07-30', 326, 'App\\Models\\Sale', 61, 48.00, '[\"48\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(877, '2024-07-30', 327, 'App\\Models\\Sale', 61, 112.00, '[\"112\"]', 13.00, 15.00, 25.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(878, '2024-07-30', 310, 'App\\Models\\Sale', 61, 6.00, '[\"6\"]', 245.00, 290.00, 400.00, 0.00, 0.00, 'flat', '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(879, '2024-07-31', 328, 'App\\Models\\Purchase', 56, 6.00, '[\"6\"]', 600.00, 650.00, 780.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(880, '2024-07-31', 329, 'App\\Models\\Purchase', 56, 12.00, '[\"12\"]', 405.00, 430.00, 540.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(881, '2024-07-31', 330, 'App\\Models\\Purchase', 56, 30.00, '[\"30\"]', 63.00, 70.00, 120.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(882, '2024-07-31', 331, 'App\\Models\\Purchase', 56, 42.00, '[\"42\"]', 74.00, 80.00, 110.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(883, '2024-07-31', 260, 'App\\Models\\Purchase', 56, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(884, '2024-07-31', 332, 'App\\Models\\Purchase', 56, 6.00, '[\"6\"]', 360.00, 390.00, 490.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(885, '2024-07-31', 333, 'App\\Models\\Purchase', 56, 72.00, '[\"72\"]', 27.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(886, '2024-07-31', 334, 'App\\Models\\Purchase', 56, 36.00, '[\"36\"]', 28.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(887, '2024-07-31', 335, 'App\\Models\\Purchase', 56, 12.00, '[\"12\"]', 138.00, 145.00, 195.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(888, '2024-07-31', 336, 'App\\Models\\Purchase', 56, 6.00, '[\"6\"]', 440.00, 480.00, 680.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(889, '2024-07-31', 337, 'App\\Models\\Purchase', 56, 12.00, '[\"12\"]', 120.00, 135.00, 190.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(890, '2024-07-31', 270, 'App\\Models\\Purchase', 56, 60.00, '[\"60\"]', 14.00, 18.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(891, '2024-07-31', 338, 'App\\Models\\Purchase', 56, 6.00, '[\"6\"]', 330.00, 360.00, 460.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(892, '2024-07-31', 339, 'App\\Models\\Purchase', 56, 36.00, '[\"36\"]', 28.00, 32.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(893, '2024-07-31', 241, 'App\\Models\\Purchase', 56, 80.00, '[\"80\"]', 21.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(894, '2024-07-31', 340, 'App\\Models\\Purchase', 56, 12.00, '[\"12\"]', 120.00, 130.00, 190.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(895, '2024-07-31', 341, 'App\\Models\\Purchase', 56, 126.00, '[\"126\"]', 20.00, 22.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(896, '2024-07-31', 328, 'App\\Models\\Sale', 62, 6.00, '[\"6\"]', 600.00, 650.00, 780.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:08', '2024-07-31 21:29:08'),
(897, '2024-07-31', 329, 'App\\Models\\Sale', 62, 12.00, '[\"12\"]', 405.00, 430.00, 540.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:08', '2024-07-31 21:29:08'),
(898, '2024-07-31', 330, 'App\\Models\\Sale', 62, 30.00, '[\"30\"]', 63.00, 70.00, 120.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(899, '2024-07-31', 331, 'App\\Models\\Sale', 62, 42.00, '[\"42\"]', 74.00, 80.00, 110.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(900, '2024-07-31', 260, 'App\\Models\\Sale', 62, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(901, '2024-07-31', 332, 'App\\Models\\Sale', 62, 6.00, '[\"6\"]', 360.00, 390.00, 490.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(902, '2024-07-31', 333, 'App\\Models\\Sale', 62, 72.00, '[\"72\"]', 27.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(903, '2024-07-31', 334, 'App\\Models\\Sale', 62, 36.00, '[\"36\"]', 28.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(904, '2024-07-31', 335, 'App\\Models\\Sale', 62, 12.00, '[\"12\"]', 138.00, 145.00, 195.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(905, '2024-07-31', 336, 'App\\Models\\Sale', 62, 6.00, '[\"6\"]', 440.00, 480.00, 680.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(906, '2024-07-31', 337, 'App\\Models\\Sale', 62, 12.00, '[\"12\"]', 120.00, 135.00, 190.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(907, '2024-07-31', 270, 'App\\Models\\Sale', 62, 60.00, '[\"60\"]', 14.00, 18.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(908, '2024-07-31', 338, 'App\\Models\\Sale', 62, 6.00, '[\"6\"]', 330.00, 360.00, 460.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(909, '2024-07-31', 339, 'App\\Models\\Sale', 62, 36.00, '[\"36\"]', 28.00, 32.00, 0.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(910, '2024-07-31', 241, 'App\\Models\\Sale', 62, 80.00, '[\"80\"]', 21.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(911, '2024-07-31', 340, 'App\\Models\\Sale', 62, 12.00, '[\"12\"]', 120.00, 130.00, 190.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(912, '2024-07-31', 341, 'App\\Models\\Sale', 62, 126.00, '[\"126\"]', 20.00, 22.00, 30.00, 0.00, 0.00, 'flat', '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(913, '2024-08-02', 4, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 165.00, 250.00, 380.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(914, '2024-08-02', 89, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 680.00, 0.00, 1300.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(915, '2024-08-02', 176, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 960.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(916, '2024-08-02', 72, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 310.00, 800.00, 0.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(917, '2024-08-02', 75, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 290.00, 650.00, 0.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(918, '2024-08-02', 8, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 3600.00, 6000.00, 8000.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(919, '2024-08-02', 95, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 820.00, 1300.00, 1600.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(920, '2024-08-02', 128, 'App\\Models\\Purchase', 57, 1.00, '[\"1\"]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(921, '2024-08-02', 107, 'App\\Models\\Purchase', 57, 1.00, '[\"1\"]', 1400.00, 2800.00, 3500.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(922, '2024-08-02', 29, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 2700.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(923, '2024-08-02', 100, 'App\\Models\\Purchase', 57, 3.00, '[\"3\"]', 370.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(924, '2024-08-02', 6, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 1200.00, 1750.00, 2300.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(925, '2024-08-02', 23, 'App\\Models\\Purchase', 57, 3.00, '[\"3\"]', 700.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(926, '2024-08-02', 165, 'App\\Models\\Purchase', 57, 2.00, '[\"2\"]', 1460.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(927, '2024-08-02', 86, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 330.00, 700.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(928, '2024-08-02', 26, 'App\\Models\\Purchase', 57, 3.00, '[\"3\"]', 3300.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(929, '2024-08-02', 21, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 470.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(930, '2024-08-02', 104, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 140.00, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(931, '2024-08-02', 140, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 50.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(932, '2024-08-02', 98, 'App\\Models\\Purchase', 57, 5.00, '[\"5\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(933, '2024-08-02', 32, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 640.00, 800.00, 1040.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(934, '2024-08-02', 110, 'App\\Models\\Purchase', 57, 25.00, '[\"25\"]', 142.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(935, '2024-08-02', 114, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 420.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(936, '2024-08-02', 167, 'App\\Models\\Purchase', 57, 3.00, '[\"3\"]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(937, '2024-08-02', 213, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 260.00, 490.00, 660.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(938, '2024-08-02', 216, 'App\\Models\\Purchase', 57, 10.00, '[\"10\"]', 260.00, 480.00, 650.00, 0.00, 0.00, 'flat', '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(939, '2024-08-04', 144, 'App\\Models\\Purchase', 58, 3.00, '[\"3\"]', 150.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(940, '2024-08-04', 160, 'App\\Models\\Purchase', 58, 5.00, '[\"5\"]', 270.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(941, '2024-08-04', 164, 'App\\Models\\Purchase', 58, 6.00, '[\"6\"]', 340.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(942, '2024-08-04', 342, 'App\\Models\\Purchase', 59, 30.00, '[\"30\"]', 216.60, 260.00, 330.00, 0.00, 0.00, 'flat', '2024-08-04 02:46:37', '2024-08-04 02:46:37'),
(943, '2024-08-04', 343, 'App\\Models\\Purchase', 59, 15.00, '[\"15\"]', 433.50, 520.00, 660.00, 0.00, 0.00, 'flat', '2024-08-04 02:46:37', '2024-08-04 02:46:37'),
(973, '2024-08-04', 111, 'App\\Models\\Sale', 63, 23.00, '[\"23\"]', 87.60, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(974, '2024-08-04', 113, 'App\\Models\\Sale', 63, 70.00, '[\"70\"]', 21.75, 40.00, 55.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(975, '2024-08-04', 24, 'App\\Models\\Sale', 63, 135.00, '[\"135\"]', 18.89, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(976, '2024-08-04', 161, 'App\\Models\\Sale', 63, 25.00, '[\"25\"]', 58.00, 120.00, 175.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(977, '2024-08-04', 145, 'App\\Models\\Sale', 63, 29.00, '[\"29\"]', 11.72, 55.00, 85.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(978, '2024-08-04', 90, 'App\\Models\\Sale', 63, 37.00, '[\"37\"]', 60.00, 80.00, 95.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(979, '2024-08-04', 284, 'App\\Models\\Sale', 63, 68.00, '[\"68\"]', 82.50, 120.00, 145.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(980, '2024-08-04', 344, 'App\\Models\\Sale', 63, 53.00, '[\"53\"]', 100.00, 120.00, 140.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(981, '2024-08-04', 69, 'App\\Models\\Sale', 63, 24.00, '[\"24\"]', 93.33, 130.00, 150.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(982, '2024-08-04', 73, 'App\\Models\\Sale', 63, 24.00, '[\"24\"]', 24.17, 40.00, 55.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(983, '2024-08-04', 130, 'App\\Models\\Sale', 63, 32.00, '[\"32\"]', 96.88, 120.00, 145.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(984, '2024-08-04', 101, 'App\\Models\\Sale', 63, 8.00, '[\"8\"]', 142.50, 250.00, 340.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(985, '2024-08-04', 71, 'App\\Models\\Sale', 63, 36.00, '[\"36\"]', 78.89, 140.00, 195.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(986, '2024-08-04', 109, 'App\\Models\\Sale', 63, 17.00, '[\"17\"]', 67.50, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(987, '2024-08-04', 31, 'App\\Models\\Sale', 63, 54.00, '[\"54\"]', 101.86, 150.00, 190.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(988, '2024-08-04', 141, 'App\\Models\\Sale', 63, 57.00, '[\"57\"]', 6.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(989, '2024-08-04', 175, 'App\\Models\\Sale', 63, 49.00, '[\"49\"]', 41.63, 85.00, 125.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(990, '2024-08-04', 28, 'App\\Models\\Sale', 63, 34.00, '[\"34\"]', 165.00, 245.00, 295.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(991, '2024-08-04', 63, 'App\\Models\\Sale', 63, 23.00, '[\"23\"]', 118.27, 170.00, 230.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(992, '2024-08-04', 87, 'App\\Models\\Sale', 63, 49.00, '[\"49\"]', 36.73, 70.00, 95.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(993, '2024-08-04', 105, 'App\\Models\\Sale', 63, 50.00, '[\"50\"]', 12.80, 30.00, 45.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(994, '2024-08-04', 177, 'App\\Models\\Sale', 63, 40.00, '[\"40\"]', 66.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(995, '2024-08-04', 22, 'App\\Models\\Sale', 63, 48.00, '[\"48\"]', 50.00, 75.00, 95.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(996, '2024-08-04', 169, 'App\\Models\\Sale', 63, 30.00, '[\"30\"]', 33.00, 60.00, 85.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(997, '2024-08-04', 121, 'App\\Models\\Sale', 63, 12.00, '[\"12\"]', 0.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(998, '2024-08-04', 181, 'App\\Models\\Sale', 63, 22.00, '[\"22\"]', 0.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(999, '2024-08-04', 65, 'App\\Models\\Sale', 63, 13.00, '[\"13\"]', 0.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(1000, '2024-08-04', 342, 'App\\Models\\Sale', 63, 30.00, '[\"30\"]', 216.60, 260.00, 330.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(1001, '2024-08-04', 343, 'App\\Models\\Sale', 63, 15.00, '[\"15\"]', 433.50, 520.00, 660.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(1002, '2024-08-04', 67, 'App\\Models\\Sale', 63, 13.00, '[\"13\"]', 160.00, 230.00, 270.00, 0.00, 0.00, 'flat', '2024-08-04 04:24:26', '2024-08-04 04:24:26'),
(1005, '2024-08-04', 108, 'App\\Models\\Purchase', 60, 1.00, '[\"1\"]', 0.00, 140.00, 0.00, 0.00, 0.00, 'flat', '2024-08-04 04:35:14', '2024-08-04 04:35:14'),
(1006, '2024-08-04', 67, 'App\\Models\\Purchase', 60, 6.50, '[\"6.5\"]', 0.00, 230.00, 270.00, 0.00, 0.00, 'flat', '2024-08-04 04:35:14', '2024-08-04 04:35:14'),
(1020, '2024-08-04', 4, 'App\\Models\\Sale', 69, 10.00, '[\"10\"]', 165.00, 250.00, 380.00, 0.00, 0.00, 'flat', '2024-08-04 04:46:17', '2024-08-04 04:46:17'),
(1021, '2024-08-04', 108, 'App\\Models\\Sale', 69, 1.00, '[\"1\"]', 0.00, 140.00, 0.00, 0.00, 0.00, 'flat', '2024-08-04 04:46:17', '2024-08-04 04:46:17'),
(1022, '2024-08-04', 67, 'App\\Models\\Sale', 69, 6.00, '[\"6\"]', 0.00, 434.00, 270.00, 0.00, 0.00, 'flat', '2024-08-04 04:46:17', '2024-08-04 04:46:17'),
(1023, '2024-08-05', 32, 'App\\Models\\Sale', 70, 10.00, '[\"10\"]', 640.00, 750.00, 1040.00, 0.00, 0.00, 'flat', '2024-08-05 09:11:39', '2024-08-05 09:11:39'),
(1024, '2024-08-06', 1, 'App\\Models\\Purchase', 61, 10.00, '[\"10\"]', 950.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1025, '2024-08-06', 2, 'App\\Models\\Purchase', 61, 4.00, '[\"4\"]', 1400.00, 1400.00, 1700.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1026, '2024-08-06', 5, 'App\\Models\\Purchase', 61, 1.00, '[\"1\"]', 620.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1027, '2024-08-06', 3, 'App\\Models\\Purchase', 61, 2.00, '[\"2\"]', 2750.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1028, '2024-08-06', 149, 'App\\Models\\Purchase', 61, 3.00, '[\"3\"]', 740.00, 1100.00, 1300.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1029, '2024-08-06', 193, 'App\\Models\\Purchase', 61, 3.00, '[\"3\"]', 380.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1030, '2024-08-06', 38, 'App\\Models\\Purchase', 61, 5.00, '[\"5\"]', 105.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(1031, '2024-08-06', 345, 'App\\Models\\Sale', 71, 15.00, '[\"15\"]', 76.00, 110.00, 145.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1032, '2024-08-06', 150, 'App\\Models\\Sale', 71, 15.00, '[\"15\"]', 148.00, 220.00, 280.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1033, '2024-08-06', 115, 'App\\Models\\Sale', 71, 60.00, '[\"60\"]', 28.00, 55.00, 70.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1034, '2024-08-06', 99, 'App\\Models\\Sale', 71, 38.00, '[\"38\"]', 11.05, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1035, '2024-08-06', 61, 'App\\Models\\Sale', 71, 10.00, '[\"10\"]', 62.00, 75.00, 90.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1036, '2024-08-06', 59, 'App\\Models\\Sale', 71, 21.00, '[\"21\"]', 130.96, 190.00, 220.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1037, '2024-08-06', 58, 'App\\Models\\Sale', 71, 16.00, '[\"16\"]', 171.88, 260.00, 335.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1038, '2024-08-06', 56, 'App\\Models\\Sale', 71, 20.00, '[\"20\"]', 280.00, 330.00, 370.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1039, '2024-08-06', 54, 'App\\Models\\Sale', 71, 50.00, '[\"50\"]', 190.00, 245.00, 280.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1040, '2024-08-06', 48, 'App\\Models\\Sale', 71, 11.00, '[\"11\"]', 0.00, 75.00, 105.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1041, '2024-08-06', 42, 'App\\Models\\Sale', 71, 19.00, '[\"19\"]', 0.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1042, '2024-08-06', 36, 'App\\Models\\Sale', 71, 30.00, '[\"30\"]', 15.75, 35.00, 55.00, 0.00, 0.00, 'flat', '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(1043, '2024-08-09', 110, 'App\\Models\\Purchase', 62, 25.00, '[\"25\"]', 147.20, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1044, '2024-08-09', 26, 'App\\Models\\Purchase', 62, 3.00, '[\"3\"]', 3350.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1045, '2024-08-09', 8, 'App\\Models\\Purchase', 62, 3.00, '[\"3\"]', 3200.00, 6000.00, 8000.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1046, '2024-08-09', 100, 'App\\Models\\Purchase', 62, 5.00, '[\"5\"]', 370.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1047, '2024-08-09', 23, 'App\\Models\\Purchase', 62, 1.00, '[\"1\"]', 920.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1048, '2024-08-09', 128, 'App\\Models\\Purchase', 62, 1.00, '[\"1\"]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1049, '2024-08-09', 89, 'App\\Models\\Purchase', 62, 5.00, '[\"5\"]', 680.00, 0.00, 1300.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1050, '2024-08-09', 165, 'App\\Models\\Purchase', 62, 2.00, '[\"2\"]', 1420.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1051, '2024-08-09', 21, 'App\\Models\\Purchase', 62, 5.00, '[\"5\"]', 500.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1052, '2024-08-09', 107, 'App\\Models\\Purchase', 62, 1.00, '[\"1\"]', 1350.00, 2800.00, 3500.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1053, '2024-08-09', 167, 'App\\Models\\Purchase', 62, 3.00, '[\"3\"]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1054, '2024-08-09', 1, 'App\\Models\\Purchase', 62, 10.00, '[\"10\"]', 1120.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(1055, '2024-08-10', 187, 'App\\Models\\Purchase', 63, 2.00, '[\"2\"]', 6800.00, 7850.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1056, '2024-08-10', 199, 'App\\Models\\Purchase', 63, 2.00, '[\"2\"]', 2100.00, 2450.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1057, '2024-08-10', 198, 'App\\Models\\Purchase', 63, 5.00, '[\"5\"]', 4950.00, 5700.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1058, '2024-08-10', 2, 'App\\Models\\Purchase', 63, 10.00, '[\"10\"]', 1430.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1059, '2024-08-10', 193, 'App\\Models\\Purchase', 63, 10.00, '[\"10\"]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1060, '2024-08-10', 149, 'App\\Models\\Purchase', 63, 5.00, '[\"5\"]', 680.00, 1150.00, 1500.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1061, '2024-08-10', 32, 'App\\Models\\Purchase', 63, 20.00, '[\"20\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1062, '2024-08-10', 194, 'App\\Models\\Purchase', 63, 5.00, '[\"5\"]', 230.00, 360.00, 600.00, 0.00, 0.00, 'flat', '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(1063, '2024-08-10', 301, 'App\\Models\\Purchase', 64, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1064, '2024-08-10', 299, 'App\\Models\\Purchase', 64, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1065, '2024-08-10', 240, 'App\\Models\\Purchase', 64, 80.00, '[\"80\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1066, '2024-08-10', 313, 'App\\Models\\Purchase', 64, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1067, '2024-08-10', 274, 'App\\Models\\Purchase', 64, 96.00, '[\"96\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1068, '2024-08-10', 303, 'App\\Models\\Purchase', 64, 96.00, '[\"96\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1069, '2024-08-10', 307, 'App\\Models\\Purchase', 64, 6.00, '[\"6\"]', 320.00, 370.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1070, '2024-08-10', 306, 'App\\Models\\Purchase', 64, 10.00, '[\"10\"]', 240.00, 300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1071, '2024-08-10', 300, 'App\\Models\\Purchase', 64, 60.00, '[\"60\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1072, '2024-08-10', 244, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 42.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1073, '2024-08-10', 321, 'App\\Models\\Purchase', 64, 120.00, '[\"120\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1074, '2024-08-10', 294, 'App\\Models\\Purchase', 64, 72.00, '[\"72\"]', 115.00, 130.00, 160.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1075, '2024-08-10', 326, 'App\\Models\\Purchase', 64, 30.00, '[\"30\"]', 112.00, 128.00, 150.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1076, '2024-08-10', 318, 'App\\Models\\Purchase', 64, 32.00, '[\"32\"]', 135.00, 155.00, 210.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1077, '2024-08-10', 304, 'App\\Models\\Purchase', 64, 240.00, '[\"240\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1078, '2024-08-10', 319, 'App\\Models\\Purchase', 64, 192.00, '[\"192\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1079, '2024-08-10', 292, 'App\\Models\\Purchase', 64, 120.00, '[\"120\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1080, '2024-08-10', 291, 'App\\Models\\Purchase', 64, 120.00, '[\"120\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1081, '2024-08-10', 246, 'App\\Models\\Purchase', 64, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1082, '2024-08-10', 295, 'App\\Models\\Purchase', 64, 72.00, '[\"72\"]', 97.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1083, '2024-08-10', 288, 'App\\Models\\Purchase', 64, 12.00, '[\"12\"]', 225.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1084, '2024-08-10', 311, 'App\\Models\\Purchase', 64, 240.00, '[\"240\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1085, '2024-08-10', 315, 'App\\Models\\Purchase', 64, 30.00, '[\"30\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1086, '2024-08-10', 316, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 230.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1087, '2024-08-10', 314, 'App\\Models\\Purchase', 64, 12.00, '[\"12\"]', 250.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1088, '2024-08-10', 322, 'App\\Models\\Purchase', 64, 12.00, '[\"12\"]', 70.00, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1089, '2024-08-10', 325, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 63.00, 72.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1090, '2024-08-10', 324, 'App\\Models\\Purchase', 64, 6.00, '[\"6\"]', 630.00, 695.00, 890.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1091, '2024-08-10', 309, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 85.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1092, '2024-08-10', 241, 'App\\Models\\Purchase', 64, 80.00, '[\"80\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1093, '2024-08-10', 273, 'App\\Models\\Purchase', 64, 48.00, '[\"48\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1094, '2024-08-10', 287, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 50.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1095, '2024-08-10', 317, 'App\\Models\\Purchase', 64, 30.00, '[\"30\"]', 33.00, 38.00, 50.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1096, '2024-08-10', 248, 'App\\Models\\Purchase', 64, 24.00, '[\"24\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(1097, '2024-08-10', 353, 'App\\Models\\Purchase', 65, 60.00, '[\"60\"]', 21.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:13', '2024-08-10 04:15:13'),
(1098, '2024-08-10', 352, 'App\\Models\\Purchase', 65, 24.00, '[\"24\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:13', '2024-08-10 04:15:13'),
(1099, '2024-08-10', 351, 'App\\Models\\Purchase', 65, 12.00, '[\"12\"]', 225.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1100, '2024-08-10', 350, 'App\\Models\\Purchase', 65, 6.00, '[\"6\"]', 120.00, 135.00, 190.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1101, '2024-08-10', 349, 'App\\Models\\Purchase', 65, 12.00, '[\"12\"]', 225.00, 275.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1102, '2024-08-10', 348, 'App\\Models\\Purchase', 65, 18.00, '[\"18\"]', 180.00, 210.00, 280.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1103, '2024-08-10', 347, 'App\\Models\\Purchase', 65, 120.00, '[\"120\"]', 67.00, 75.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1104, '2024-08-10', 346, 'App\\Models\\Purchase', 65, 24.00, '[\"24\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(1105, '2024-08-10', 301, 'App\\Models\\Sale', 72, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1106, '2024-08-10', 299, 'App\\Models\\Sale', 72, 60.00, '[\"60\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1107, '2024-08-10', 240, 'App\\Models\\Sale', 72, 80.00, '[\"80\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1108, '2024-08-10', 313, 'App\\Models\\Sale', 72, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1109, '2024-08-10', 274, 'App\\Models\\Sale', 72, 96.00, '[\"96\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1110, '2024-08-10', 303, 'App\\Models\\Sale', 72, 96.00, '[\"96\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1111, '2024-08-10', 307, 'App\\Models\\Sale', 72, 6.00, '[\"6\"]', 320.00, 370.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1112, '2024-08-10', 306, 'App\\Models\\Sale', 72, 10.00, '[\"10\"]', 240.00, 300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1113, '2024-08-10', 300, 'App\\Models\\Sale', 72, 60.00, '[\"60\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1114, '2024-08-10', 244, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 42.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1115, '2024-08-10', 321, 'App\\Models\\Sale', 72, 120.00, '[\"120\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1116, '2024-08-10', 294, 'App\\Models\\Sale', 72, 72.00, '[\"72\"]', 115.00, 130.00, 160.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1117, '2024-08-10', 326, 'App\\Models\\Sale', 72, 30.00, '[\"30\"]', 112.00, 128.00, 150.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1118, '2024-08-10', 318, 'App\\Models\\Sale', 72, 32.00, '[\"32\"]', 135.00, 155.00, 210.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1119, '2024-08-10', 304, 'App\\Models\\Sale', 72, 240.00, '[\"240\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1120, '2024-08-10', 319, 'App\\Models\\Sale', 72, 192.00, '[\"192\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1121, '2024-08-10', 292, 'App\\Models\\Sale', 72, 120.00, '[\"120\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1122, '2024-08-10', 291, 'App\\Models\\Sale', 72, 120.00, '[\"120\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1123, '2024-08-10', 246, 'App\\Models\\Sale', 72, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1124, '2024-08-10', 295, 'App\\Models\\Sale', 72, 75.00, '[\"75\"]', 97.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1125, '2024-08-10', 288, 'App\\Models\\Sale', 72, 12.00, '[\"12\"]', 225.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1126, '2024-08-10', 311, 'App\\Models\\Sale', 72, 240.00, '[\"240\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1127, '2024-08-10', 315, 'App\\Models\\Sale', 72, 30.00, '[\"30\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1128, '2024-08-10', 316, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 230.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1129, '2024-08-10', 314, 'App\\Models\\Sale', 72, 12.00, '[\"12\"]', 250.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1130, '2024-08-10', 322, 'App\\Models\\Sale', 72, 12.00, '[\"12\"]', 70.00, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1131, '2024-08-10', 325, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 63.00, 72.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1132, '2024-08-10', 324, 'App\\Models\\Sale', 72, 6.00, '[\"6\"]', 630.00, 695.00, 890.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1133, '2024-08-10', 309, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 85.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1134, '2024-08-10', 241, 'App\\Models\\Sale', 72, 80.00, '[\"80\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1135, '2024-08-10', 273, 'App\\Models\\Sale', 72, 48.00, '[\"48\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1136, '2024-08-10', 287, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 50.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1137, '2024-08-10', 317, 'App\\Models\\Sale', 72, 30.00, '[\"30\"]', 33.00, 38.00, 50.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1138, '2024-08-10', 248, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1139, '2024-08-10', 353, 'App\\Models\\Sale', 72, 60.00, '[\"60\"]', 21.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1140, '2024-08-10', 352, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1141, '2024-08-10', 351, 'App\\Models\\Sale', 72, 12.00, '[\"12\"]', 225.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1142, '2024-08-10', 350, 'App\\Models\\Sale', 72, 6.00, '[\"6\"]', 120.00, 135.00, 190.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1143, '2024-08-10', 349, 'App\\Models\\Sale', 72, 12.00, '[\"12\"]', 225.00, 275.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1144, '2024-08-10', 348, 'App\\Models\\Sale', 72, 18.00, '[\"18\"]', 180.00, 210.00, 280.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1145, '2024-08-10', 347, 'App\\Models\\Sale', 72, 120.00, '[\"120\"]', 67.00, 75.00, 90.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1146, '2024-08-10', 346, 'App\\Models\\Sale', 72, 24.00, '[\"24\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(1157, '2024-08-10', 187, 'App\\Models\\Sale', 73, 2.00, '[\"2\"]', 6800.00, 7500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:57:19', '2024-08-10 04:57:19'),
(1158, '2024-08-10', 199, 'App\\Models\\Sale', 73, 1.00, '[\"1\"]', 2100.00, 3000.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:57:19', '2024-08-10 04:57:19'),
(1159, '2024-08-10', 198, 'App\\Models\\Sale', 73, 4.00, '[\"4\"]', 4950.00, 5500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 04:57:19', '2024-08-10 04:57:19'),
(1160, '2024-08-10', 271, 'App\\Models\\Purchase', 66, 24.00, '[\"24\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1161, '2024-08-10', 346, 'App\\Models\\Purchase', 66, 120.00, '[\"120\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1162, '2024-08-10', 260, 'App\\Models\\Purchase', 66, 5.00, '[\"5\"]', 350.00, 385.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1163, '2024-08-10', 264, 'App\\Models\\Purchase', 66, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1164, '2024-08-10', 270, 'App\\Models\\Purchase', 66, 60.00, '[\"60\"]', 20.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1165, '2024-08-10', 354, 'App\\Models\\Purchase', 66, 2.00, '[\"2\"]', 550.00, 600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1166, '2024-08-10', 282, 'App\\Models\\Purchase', 66, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1167, '2024-08-10', 281, 'App\\Models\\Purchase', 66, 24.00, '[\"24\"]', 500.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1168, '2024-08-10', 259, 'App\\Models\\Purchase', 66, 4.00, '[\"4\"]', 390.00, 430.00, 760.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1169, '2024-08-10', 243, 'App\\Models\\Purchase', 66, 40.00, '[\"40\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1170, '2024-08-10', 293, 'App\\Models\\Purchase', 66, 10.00, '[\"10\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1171, '2024-08-10', 304, 'App\\Models\\Purchase', 66, 120.00, '[\"120\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1172, '2024-08-10', 294, 'App\\Models\\Purchase', 66, 48.00, '[\"48\"]', 115.00, 130.00, 160.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1173, '2024-08-10', 52, 'App\\Models\\Purchase', 66, 1.00, '[\"1\"]', 1200.00, 1350.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1174, '2024-08-10', 298, 'App\\Models\\Purchase', 66, 48.00, '[\"48\"]', 37.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(1190, '2024-08-10', 199, 'App\\Models\\Sale', 76, 1.00, '[\"1\"]', 2100.00, 2450.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1191, '2024-08-10', 198, 'App\\Models\\Sale', 76, 1.00, '[\"1\"]', 4950.00, 5700.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1192, '2024-08-10', 194, 'App\\Models\\Sale', 76, 5.00, '[\"5\"]', 230.00, 360.00, 600.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1193, '2024-08-10', 193, 'App\\Models\\Sale', 76, 10.00, '[\"10\"]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1194, '2024-08-10', 167, 'App\\Models\\Sale', 76, 3.00, '[\"3\"]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1195, '2024-08-10', 165, 'App\\Models\\Sale', 76, 2.00, '[\"2\"]', 1420.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1196, '2024-08-10', 149, 'App\\Models\\Sale', 76, 5.00, '[\"5\"]', 680.00, 1150.00, 1500.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1197, '2024-08-10', 128, 'App\\Models\\Sale', 76, 1.00, '[\"1\"]', 3000.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1198, '2024-08-10', 114, 'App\\Models\\Sale', 76, 6.00, '[\"6\"]', 420.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1199, '2024-08-10', 110, 'App\\Models\\Sale', 76, 25.00, '[\"25\"]', 147.20, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1200, '2024-08-10', 107, 'App\\Models\\Sale', 76, 1.00, '[\"1\"]', 1350.00, 2800.00, 3500.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1201, '2024-08-10', 104, 'App\\Models\\Sale', 76, 0.70, '[\".7\"]', 140.00, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1202, '2024-08-10', 100, 'App\\Models\\Sale', 76, 5.00, '[\"5\"]', 370.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1203, '2024-08-10', 98, 'App\\Models\\Sale', 76, 2.00, '[\"2\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1204, '2024-08-10', 89, 'App\\Models\\Sale', 76, 5.00, '[\"5\"]', 680.00, 800.00, 1300.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1205, '2024-08-10', 32, 'App\\Models\\Sale', 76, 10.00, '[\"10\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1206, '2024-08-10', 26, 'App\\Models\\Sale', 76, 3.00, '[\"3\"]', 3350.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1207, '2024-08-10', 23, 'App\\Models\\Sale', 76, 1.00, '[\"1\"]', 920.00, 1500.00, 1600.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1208, '2024-08-10', 21, 'App\\Models\\Sale', 76, 5.00, '[\"5\"]', 500.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1209, '2024-08-10', 8, 'App\\Models\\Sale', 76, 3.00, '[\"3\"]', 3200.00, 4200.00, 8000.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1210, '2024-08-10', 2, 'App\\Models\\Sale', 76, 10.00, '[\"10\"]', 1430.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1211, '2024-08-10', 1, 'App\\Models\\Sale', 76, 10.00, '[\"10\"]', 1120.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(1212, '2024-08-10', 271, 'App\\Models\\Sale', 75, 24.00, '[\"24\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1213, '2024-08-10', 346, 'App\\Models\\Sale', 75, 120.00, '[\"120\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1214, '2024-08-10', 260, 'App\\Models\\Sale', 75, 5.00, '[\"5\"]', 350.00, 385.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1215, '2024-08-10', 264, 'App\\Models\\Sale', 75, 60.00, '[\"60\"]', 18.00, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1216, '2024-08-10', 270, 'App\\Models\\Sale', 75, 60.00, '[\"60\"]', 20.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1217, '2024-08-10', 354, 'App\\Models\\Sale', 75, 2.00, '[\"2\"]', 550.00, 600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1218, '2024-08-10', 282, 'App\\Models\\Sale', 75, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1219, '2024-08-10', 281, 'App\\Models\\Sale', 75, 24.00, '[\"24\"]', 500.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1220, '2024-08-10', 259, 'App\\Models\\Sale', 75, 4.00, '[\"4\"]', 390.00, 430.00, 760.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1221, '2024-08-10', 243, 'App\\Models\\Sale', 75, 40.00, '[\"40\"]', 230.00, 240.00, 300.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1222, '2024-08-10', 293, 'App\\Models\\Sale', 75, 10.00, '[\"10\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1223, '2024-08-10', 304, 'App\\Models\\Sale', 75, 120.00, '[\"120\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36');
INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(1224, '2024-08-10', 294, 'App\\Models\\Sale', 75, 48.00, '[\"48\"]', 115.00, 130.00, 160.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1225, '2024-08-10', 52, 'App\\Models\\Sale', 75, 1.00, '[\"1\"]', 1200.00, 1350.00, 0.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1226, '2024-08-10', 298, 'App\\Models\\Sale', 75, 48.00, '[\"48\"]', 37.00, 45.00, 60.00, 0.00, 0.00, 'flat', '2024-08-10 09:52:36', '2024-08-10 09:52:36'),
(1227, '2024-08-14', 355, 'App\\Models\\Purchase', 67, 12.00, '[\"12\"]', 550.00, 610.00, 710.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1228, '2024-08-14', 356, 'App\\Models\\Purchase', 67, 12.00, '[\"12\"]', 175.00, 210.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1229, '2024-08-14', 357, 'App\\Models\\Purchase', 67, 12.00, '[\"12\"]', 400.00, 460.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1230, '2024-08-14', 358, 'App\\Models\\Purchase', 67, 12.00, '[\"12\"]', 220.00, 245.00, 280.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1231, '2024-08-14', 359, 'App\\Models\\Purchase', 67, 24.00, '[\"24\"]', 250.00, 280.00, 330.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1232, '2024-08-14', 360, 'App\\Models\\Purchase', 67, 1.00, '[\"1\"]', 810.00, 900.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1233, '2024-08-14', 361, 'App\\Models\\Purchase', 67, 6.00, '[\"6\"]', 530.00, 650.00, 895.00, 0.00, 0.00, 'flat', '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(1234, '2024-08-14', 362, 'App\\Models\\Purchase', 68, 10.00, '[\"10\"]', 220.00, 260.00, 315.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1235, '2024-08-14', 363, 'App\\Models\\Purchase', 68, 12.00, '[\"12\"]', 250.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1236, '2024-08-14', 364, 'App\\Models\\Purchase', 68, 12.00, '[\"12\"]', 160.00, 190.00, 230.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1237, '2024-08-14', 365, 'App\\Models\\Purchase', 68, 24.00, '[\"24\"]', 220.00, 260.00, 340.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1238, '2024-08-14', 366, 'App\\Models\\Purchase', 68, 12.00, '[\"12\"]', 200.00, 220.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1239, '2024-08-14', 367, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 1450.00, 1600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1240, '2024-08-14', 368, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 2500.00, 2770.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1241, '2024-08-14', 369, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 2420.00, 2640.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1242, '2024-08-14', 370, 'App\\Models\\Purchase', 68, 2.00, '[\"2\"]', 790.00, 850.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1243, '2024-08-14', 371, 'App\\Models\\Purchase', 68, 2.00, '[\"2\"]', 1430.00, 1580.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1244, '2024-08-14', 372, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 3000.00, 3300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1245, '2024-08-14', 373, 'App\\Models\\Purchase', 68, 6.00, '[\"6\"]', 440.00, 490.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1246, '2024-08-14', 374, 'App\\Models\\Purchase', 68, 8.00, '[\"8\"]', 370.00, 440.00, 530.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1247, '2024-08-14', 375, 'App\\Models\\Purchase', 68, 2.00, '[\"2\"]', 930.00, 990.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1248, '2024-08-14', 376, 'App\\Models\\Purchase', 68, 6.00, '[\"6\"]', 350.00, 410.00, 490.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1249, '2024-08-14', 377, 'App\\Models\\Purchase', 68, 8.00, '[\"8\"]', 410.00, 480.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1250, '2024-08-14', 378, 'App\\Models\\Purchase', 68, 6.00, '[\"6\"]', 350.00, 400.00, 470.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1251, '2024-08-14', 379, 'App\\Models\\Purchase', 68, 2.00, '[\"2\"]', 1320.00, 1450.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1252, '2024-08-14', 380, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 3300.00, 3600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1253, '2024-08-14', 381, 'App\\Models\\Purchase', 68, 48.00, '[\"48\"]', 77.00, 90.00, 120.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1254, '2024-08-14', 382, 'App\\Models\\Purchase', 68, 2.00, '[\"2\"]', 450.00, 500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1255, '2024-08-14', 383, 'App\\Models\\Purchase', 68, 1.00, '[\"1\"]', 2100.00, 2300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(1256, '2024-08-14', 329, 'App\\Models\\Purchase', 69, 20.00, '[\"20\"]', 430.00, 480.00, 540.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1257, '2024-08-14', 384, 'App\\Models\\Purchase', 69, 24.00, '[\"24\"]', 135.00, 150.00, 180.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1258, '2024-08-14', 388, 'App\\Models\\Purchase', 69, 12.00, '[\"12\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1259, '2024-08-14', 301, 'App\\Models\\Purchase', 69, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1260, '2024-08-14', 304, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 640.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1261, '2024-08-14', 335, 'App\\Models\\Purchase', 69, 24.00, '[\"24\"]', 145.00, 165.00, 195.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1262, '2024-08-14', 328, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 620.00, 680.00, 780.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1263, '2024-08-14', 295, 'App\\Models\\Purchase', 69, 12.00, '[\"12\"]', 300.00, 330.00, 380.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1264, '2024-08-14', 330, 'App\\Models\\Purchase', 69, 60.00, '[\"60\"]', 70.00, 85.00, 120.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1265, '2024-08-14', 332, 'App\\Models\\Purchase', 69, 12.00, '[\"12\"]', 360.00, 410.00, 490.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1266, '2024-08-14', 385, 'App\\Models\\Purchase', 69, 10.00, '[\"10\"]', 620.00, 680.00, 750.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1267, '2024-08-14', 386, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 770.00, 850.00, 950.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1268, '2024-08-14', 340, 'App\\Models\\Purchase', 69, 20.00, '[\"20\"]', 130.00, 145.00, 190.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1269, '2024-08-14', 310, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 230.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1270, '2024-08-14', 191, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 530.00, 580.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1271, '2024-08-14', 333, 'App\\Models\\Purchase', 69, 10.00, '[\"10\"]', 27.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1272, '2024-08-14', 339, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 28.00, 32.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1273, '2024-08-14', 334, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 28.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1274, '2024-08-14', 308, 'App\\Models\\Purchase', 69, 6.00, '[\"6\"]', 460.00, 500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1275, '2024-08-14', 387, 'App\\Models\\Purchase', 69, 40.00, '[\"40\"]', 180.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1276, '2024-08-14', 250, 'App\\Models\\Purchase', 69, 36.00, '[\"36\"]', 80.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1277, '2024-08-14', 331, 'App\\Models\\Purchase', 69, 48.00, '[\"48\"]', 74.00, 80.00, 110.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1278, '2024-08-14', 299, 'App\\Models\\Purchase', 69, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(1279, '2024-08-14', 392, 'App\\Models\\Sale', 77, 32.00, '[\"32\"]', 132.00, 280.00, 330.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1280, '2024-08-14', 391, 'App\\Models\\Sale', 77, 23.00, '[\"23\"]', 58.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1281, '2024-08-14', 390, 'App\\Models\\Sale', 77, 46.00, '[\"46\"]', 52.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1282, '2024-08-14', 389, 'App\\Models\\Sale', 77, 47.00, '[\"47\"]', 52.00, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1283, '2024-08-14', 388, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1284, '2024-08-14', 387, 'App\\Models\\Sale', 77, 40.00, '[\"40\"]', 180.00, 200.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1285, '2024-08-14', 386, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 770.00, 850.00, 950.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1286, '2024-08-14', 385, 'App\\Models\\Sale', 77, 10.00, '[\"10\"]', 620.00, 680.00, 750.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1287, '2024-08-14', 384, 'App\\Models\\Sale', 77, 24.00, '[\"24\"]', 135.00, 150.00, 180.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1288, '2024-08-14', 383, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 2100.00, 2300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1289, '2024-08-14', 382, 'App\\Models\\Sale', 77, 2.00, '[\"2\"]', 450.00, 500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1290, '2024-08-14', 381, 'App\\Models\\Sale', 77, 48.00, '[\"48\"]', 77.00, 90.00, 120.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1291, '2024-08-14', 380, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 3300.00, 3600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1292, '2024-08-14', 379, 'App\\Models\\Sale', 77, 2.00, '[\"2\"]', 1320.00, 1450.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1293, '2024-08-14', 378, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 350.00, 400.00, 470.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1294, '2024-08-14', 377, 'App\\Models\\Sale', 77, 8.00, '[\"8\"]', 410.00, 480.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1295, '2024-08-14', 376, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 350.00, 410.00, 490.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1296, '2024-08-14', 375, 'App\\Models\\Sale', 77, 2.00, '[\"2\"]', 930.00, 990.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1297, '2024-08-14', 374, 'App\\Models\\Sale', 77, 8.00, '[\"8\"]', 370.00, 440.00, 530.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1298, '2024-08-14', 373, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 440.00, 490.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1299, '2024-08-14', 372, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 3000.00, 3300.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1300, '2024-08-14', 371, 'App\\Models\\Sale', 77, 2.00, '[\"2\"]', 1430.00, 1580.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1301, '2024-08-14', 370, 'App\\Models\\Sale', 77, 2.00, '[\"2\"]', 790.00, 850.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1302, '2024-08-14', 369, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 2420.00, 2640.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1303, '2024-08-14', 368, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 2500.00, 2770.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1304, '2024-08-14', 367, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 1450.00, 1600.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1305, '2024-08-14', 366, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 200.00, 220.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1306, '2024-08-14', 365, 'App\\Models\\Sale', 77, 24.00, '[\"24\"]', 220.00, 260.00, 340.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1307, '2024-08-14', 364, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 160.00, 190.00, 230.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1308, '2024-08-14', 363, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 250.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1309, '2024-08-14', 362, 'App\\Models\\Sale', 77, 10.00, '[\"10\"]', 220.00, 260.00, 315.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1310, '2024-08-14', 361, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 530.00, 650.00, 895.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1311, '2024-08-14', 360, 'App\\Models\\Sale', 77, 1.00, '[\"1\"]', 810.00, 900.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1312, '2024-08-14', 359, 'App\\Models\\Sale', 77, 24.00, '[\"24\"]', 250.00, 280.00, 330.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1313, '2024-08-14', 358, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 220.00, 245.00, 280.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1314, '2024-08-14', 357, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 400.00, 460.00, 580.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1315, '2024-08-14', 356, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 175.00, 210.00, 250.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1316, '2024-08-14', 355, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 550.00, 610.00, 710.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1317, '2024-08-14', 340, 'App\\Models\\Sale', 77, 20.00, '[\"20\"]', 130.00, 145.00, 190.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1318, '2024-08-14', 339, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 28.00, 32.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1319, '2024-08-14', 335, 'App\\Models\\Sale', 77, 24.00, '[\"24\"]', 145.00, 165.00, 195.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1320, '2024-08-14', 334, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 28.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1321, '2024-08-14', 333, 'App\\Models\\Sale', 77, 10.00, '[\"10\"]', 27.00, 30.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1322, '2024-08-14', 332, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 360.00, 410.00, 490.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1323, '2024-08-14', 331, 'App\\Models\\Sale', 77, 48.00, '[\"48\"]', 74.00, 80.00, 110.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1324, '2024-08-14', 330, 'App\\Models\\Sale', 77, 60.00, '[\"60\"]', 70.00, 85.00, 120.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1325, '2024-08-14', 329, 'App\\Models\\Sale', 77, 20.00, '[\"20\"]', 430.00, 480.00, 540.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1326, '2024-08-14', 328, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 620.00, 680.00, 780.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1327, '2024-08-14', 310, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 230.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1328, '2024-08-14', 308, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 460.00, 500.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1329, '2024-08-14', 304, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 640.00, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1330, '2024-08-14', 301, 'App\\Models\\Sale', 77, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1331, '2024-08-14', 299, 'App\\Models\\Sale', 77, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1332, '2024-08-14', 295, 'App\\Models\\Sale', 77, 12.00, '[\"12\"]', 300.00, 330.00, 380.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1333, '2024-08-14', 250, 'App\\Models\\Sale', 77, 36.00, '[\"36\"]', 80.00, 90.00, 110.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1334, '2024-08-14', 191, 'App\\Models\\Sale', 77, 6.00, '[\"6\"]', 530.00, 580.00, 0.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1335, '2024-08-14', 32, 'App\\Models\\Sale', 77, 10.00, '[\"10\"]', 630.00, 850.00, 950.00, 0.00, 0.00, 'flat', '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(1336, '2024-08-15', 52, 'App\\Models\\Purchase', 70, 1.00, '[\"1\"]', 75780.00, 83880.00, 0.00, 0.00, 0.00, 'flat', '2024-08-15 02:46:14', '2024-08-15 02:46:14'),
(1337, '2024-08-15', 52, 'App\\Models\\Sale', 78, 1.00, '[\"1\"]', 75780.00, 83880.00, 0.00, 0.00, 0.00, 'flat', '2024-08-15 02:47:05', '2024-08-15 02:47:05'),
(1427, '2024-08-15', 321, 'App\\Models\\Purchase', 71, 120.00, '[\"120\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1428, '2024-08-15', 349, 'App\\Models\\Purchase', 71, 12.00, '[\"12\"]', 240.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1429, '2024-08-15', 52, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 100.00, 110.00, 145.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1430, '2024-08-15', 53, 'App\\Models\\Purchase', 71, 50.00, '[\"50\"]', 45.00, 50.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1431, '2024-08-15', 287, 'App\\Models\\Purchase', 71, 100.00, '[\"100\"]', 50.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1432, '2024-08-15', 323, 'App\\Models\\Purchase', 71, 144.00, '[\"144\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1433, '2024-08-15', 315, 'App\\Models\\Purchase', 71, 540.00, '[\"540\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1434, '2024-08-15', 319, 'App\\Models\\Purchase', 71, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1435, '2024-08-15', 353, 'App\\Models\\Purchase', 71, 64.00, '[\"64\"]', 21.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1436, '2024-08-15', 244, 'App\\Models\\Purchase', 71, 48.00, '[\"48\"]', 42.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1437, '2024-08-15', 300, 'App\\Models\\Purchase', 71, 60.00, '[\"60\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1438, '2024-08-15', 273, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1439, '2024-08-15', 238, 'App\\Models\\Purchase', 71, 90.00, '[\"90\"]', 15.00, 20.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1440, '2024-08-15', 299, 'App\\Models\\Purchase', 71, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1441, '2024-08-15', 301, 'App\\Models\\Purchase', 71, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1442, '2024-08-15', 322, 'App\\Models\\Purchase', 71, 72.00, '[\"72\"]', 70.00, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1443, '2024-08-15', 241, 'App\\Models\\Purchase', 71, 40.00, '[\"40\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1444, '2024-08-15', 240, 'App\\Models\\Purchase', 71, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1445, '2024-08-15', 313, 'App\\Models\\Purchase', 71, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1446, '2024-08-15', 393, 'App\\Models\\Purchase', 71, 56.00, '[\"56\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1447, '2024-08-15', 394, 'App\\Models\\Purchase', 71, 40.00, '[\"40\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1448, '2024-08-15', 395, 'App\\Models\\Purchase', 71, 30.00, '[\"30\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1449, '2024-08-15', 352, 'App\\Models\\Purchase', 71, 50.00, '[\"50\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1450, '2024-08-15', 397, 'App\\Models\\Purchase', 71, 30.00, '[\"30\"]', 29.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1451, '2024-08-15', 398, 'App\\Models\\Purchase', 71, 30.00, '[\"30\"]', 26.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1452, '2024-08-15', 282, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1453, '2024-08-15', 326, 'App\\Models\\Purchase', 71, 30.00, '[\"30\"]', 112.00, 128.00, 150.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1454, '2024-08-15', 400, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 34.00, 38.00, 55.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1455, '2024-08-15', 350, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 110.00, 125.00, 190.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1456, '2024-08-15', 347, 'App\\Models\\Purchase', 71, 6.00, '[\"6\"]', 140.00, 180.00, 250.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1457, '2024-08-15', 295, 'App\\Models\\Purchase', 71, 72.00, '[\"72\"]', 95.00, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1458, '2024-08-15', 305, 'App\\Models\\Purchase', 71, 24.00, '[\"24\"]', 44.00, 50.00, 70.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1459, '2024-08-15', 354, 'App\\Models\\Purchase', 71, 2.00, '[\"2\"]', 780.00, 860.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1460, '2024-08-15', 341, 'App\\Models\\Purchase', 71, 2.00, '[\"2\"]', 1200.00, 1320.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1461, '2024-08-15', 399, 'App\\Models\\Purchase', 71, 2.00, '[\"2\"]', 1200.00, 1320.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:13:03', '2024-08-16 08:13:03'),
(1462, '2024-08-16', 321, 'App\\Models\\Sale', 79, 120.00, '[\"120\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1463, '2024-08-16', 349, 'App\\Models\\Sale', 79, 12.00, '[\"12\"]', 240.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1464, '2024-08-16', 52, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 100.00, 110.00, 145.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1465, '2024-08-16', 53, 'App\\Models\\Sale', 79, 50.00, '[\"50\"]', 45.00, 50.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1466, '2024-08-16', 287, 'App\\Models\\Sale', 79, 100.00, '[\"100\"]', 50.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1467, '2024-08-16', 323, 'App\\Models\\Sale', 79, 144.00, '[\"144\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1468, '2024-08-16', 315, 'App\\Models\\Sale', 79, 540.00, '[\"540\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1469, '2024-08-16', 319, 'App\\Models\\Sale', 79, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1470, '2024-08-16', 353, 'App\\Models\\Sale', 79, 64.00, '[\"64\"]', 21.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1471, '2024-08-16', 244, 'App\\Models\\Sale', 79, 48.00, '[\"48\"]', 42.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1472, '2024-08-16', 300, 'App\\Models\\Sale', 79, 60.00, '[\"60\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1473, '2024-08-16', 273, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 44.00, 48.00, 60.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1474, '2024-08-16', 238, 'App\\Models\\Sale', 79, 90.00, '[\"90\"]', 15.00, 20.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1475, '2024-08-16', 299, 'App\\Models\\Sale', 79, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1476, '2024-08-16', 301, 'App\\Models\\Sale', 79, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1477, '2024-08-16', 322, 'App\\Models\\Sale', 79, 72.00, '[\"72\"]', 70.00, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1478, '2024-08-16', 241, 'App\\Models\\Sale', 79, 40.00, '[\"40\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1479, '2024-08-16', 240, 'App\\Models\\Sale', 79, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1480, '2024-08-16', 313, 'App\\Models\\Sale', 79, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1481, '2024-08-16', 393, 'App\\Models\\Sale', 79, 56.00, '[\"56\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1482, '2024-08-16', 394, 'App\\Models\\Sale', 79, 40.00, '[\"40\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1483, '2024-08-16', 395, 'App\\Models\\Sale', 79, 30.00, '[\"30\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1484, '2024-08-16', 352, 'App\\Models\\Sale', 79, 50.00, '[\"50\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1485, '2024-08-16', 397, 'App\\Models\\Sale', 79, 30.00, '[\"30\"]', 29.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1486, '2024-08-16', 398, 'App\\Models\\Sale', 79, 30.00, '[\"30\"]', 26.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1487, '2024-08-16', 282, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1488, '2024-08-16', 326, 'App\\Models\\Sale', 79, 30.00, '[\"30\"]', 112.00, 128.00, 150.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1489, '2024-08-16', 400, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 34.00, 38.00, 55.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1490, '2024-08-16', 350, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 110.00, 125.00, 190.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1491, '2024-08-16', 347, 'App\\Models\\Sale', 79, 6.00, '[\"6\"]', 140.00, 180.00, 250.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1492, '2024-08-16', 295, 'App\\Models\\Sale', 79, 72.00, '[\"72\"]', 95.00, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1493, '2024-08-16', 305, 'App\\Models\\Sale', 79, 24.00, '[\"24\"]', 44.00, 50.00, 70.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1494, '2024-08-16', 354, 'App\\Models\\Sale', 79, 2.00, '[\"2\"]', 780.00, 860.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1495, '2024-08-16', 341, 'App\\Models\\Sale', 79, 2.00, '[\"2\"]', 1200.00, 1320.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1496, '2024-08-16', 399, 'App\\Models\\Sale', 79, 2.00, '[\"2\"]', 1200.00, 1320.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(1497, '2024-08-16', 104, 'App\\Models\\Purchase', 72, 1.00, '[\"1\"]', 272.40, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-08-16 08:26:56', '2024-08-16 08:26:56'),
(1499, '2024-08-21', 52, 'App\\Models\\Purchase', 73, 1.00, '[\"1\"]', 373810.00, 412000.00, 0.00, 0.00, 0.00, 'flat', '2024-08-21 03:11:43', '2024-08-21 03:11:43'),
(1501, '2024-08-21', 401, 'App\\Models\\Purchase', 74, 3.00, '[\"3\"]', 210.00, 750.00, 0.00, 0.00, 0.00, 'flat', '2024-08-21 03:27:01', '2024-08-21 03:27:01'),
(1502, '2024-08-21', 402, 'App\\Models\\Purchase', 74, 3.00, '[\"3\"]', 93.34, 700.00, 0.00, 0.00, 0.00, 'flat', '2024-08-21 03:27:01', '2024-08-21 03:27:01'),
(1503, '2024-08-21', 52, 'App\\Models\\Sale', 80, 1.00, '[\"1\"]', 373810.00, 420000.00, 0.00, 0.00, 0.00, 'flat', '2024-08-21 11:12:15', '2024-08-21 11:12:15'),
(1504, '2024-08-23', 403, 'App\\Models\\Purchase', 75, 20.00, '[\"20\"]', 31.00, 60.00, 80.00, 0.00, 0.00, 'flat', '2024-08-23 03:27:30', '2024-08-23 03:27:30'),
(1508, '2024-08-23', 403, 'App\\Models\\Sale', 81, 20.00, '[\"20\"]', 31.00, 60.00, 80.00, 0.00, 0.00, 'flat', '2024-08-23 03:31:23', '2024-08-23 03:31:23'),
(1509, '2024-08-23', 404, 'App\\Models\\Sale', 81, 16.00, '[\"16\"]', 17.50, 70.00, 130.00, 0.00, 0.00, 'flat', '2024-08-23 03:31:23', '2024-08-23 03:31:23'),
(1510, '2024-08-23', 405, 'App\\Models\\Sale', 81, 10.00, '[\"10\"]', 21.00, 50.00, 80.00, 0.00, 0.00, 'flat', '2024-08-23 03:31:23', '2024-08-23 03:31:23'),
(1511, '2024-08-25', 209, 'App\\Models\\Purchase', 76, 40.00, '[\"40\"]', 976.25, 1250.00, 1550.00, 0.00, 0.00, 'flat', '2024-08-25 12:33:29', '2024-08-25 12:33:29'),
(1512, '2024-08-25', 209, 'App\\Models\\Sale', 82, 40.00, '[\"40\"]', 976.25, 1250.00, 1550.00, 0.00, 0.00, 'flat', '2024-08-25 12:33:59', '2024-08-25 12:33:59'),
(1513, '2024-08-25', 166, 'App\\Models\\Purchase', 77, 25.00, '[\"25\"]', 72.00, 300.00, 500.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1514, '2024-08-25', 140, 'App\\Models\\Purchase', 77, 10.00, '[\"10\"]', 50.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1515, '2024-08-25', 81, 'App\\Models\\Purchase', 77, 10.00, '[\"10\"]', 75.00, 250.00, 0.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1516, '2024-08-25', 144, 'App\\Models\\Purchase', 77, 5.00, '[\"5\"]', 140.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1517, '2024-08-25', 19, 'App\\Models\\Purchase', 77, 5.00, '[\"5\"]', 170.00, 450.00, 600.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1518, '2024-08-25', 100, 'App\\Models\\Purchase', 77, 5.00, '[\"5\"]', 360.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1519, '2024-08-25', 23, 'App\\Models\\Purchase', 77, 1.00, '[\"1\"]', 1050.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1520, '2024-08-25', 86, 'App\\Models\\Purchase', 77, 5.00, '[\"5\"]', 360.00, 700.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1521, '2024-08-25', 38, 'App\\Models\\Purchase', 77, 5.00, '[\"5\"]', 100.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(1522, '2024-08-26', 406, 'App\\Models\\Purchase', 78, 48.00, '[\"48\"]', 90.00, 105.00, 150.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1523, '2024-08-26', 407, 'App\\Models\\Purchase', 78, 24.00, '[\"24\"]', 155.00, 170.00, 280.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1524, '2024-08-26', 408, 'App\\Models\\Purchase', 78, 48.00, '[\"48\"]', 54.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1525, '2024-08-26', 358, 'App\\Models\\Purchase', 78, 24.00, '[\"24\"]', 235.00, 255.00, 320.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1526, '2024-08-26', 409, 'App\\Models\\Purchase', 78, 24.00, '[\"24\"]', 125.00, 135.00, 175.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1527, '2024-08-26', 274, 'App\\Models\\Purchase', 78, 24.00, '[\"24\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1528, '2024-08-26', 410, 'App\\Models\\Purchase', 78, 6.00, '[\"6\"]', 520.00, 580.00, 775.00, 0.00, 0.00, 'flat', '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(1529, '2024-08-26', 406, 'App\\Models\\Sale', 83, 48.00, '[\"48\"]', 90.00, 105.00, 150.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1530, '2024-08-26', 407, 'App\\Models\\Sale', 83, 24.00, '[\"24\"]', 155.00, 170.00, 280.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1531, '2024-08-26', 408, 'App\\Models\\Sale', 83, 48.00, '[\"48\"]', 54.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1532, '2024-08-26', 358, 'App\\Models\\Sale', 83, 24.00, '[\"24\"]', 235.00, 255.00, 320.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1533, '2024-08-26', 409, 'App\\Models\\Sale', 83, 24.00, '[\"24\"]', 125.00, 135.00, 175.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1534, '2024-08-26', 274, 'App\\Models\\Sale', 83, 24.00, '[\"24\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1535, '2024-08-26', 410, 'App\\Models\\Sale', 83, 6.00, '[\"6\"]', 520.00, 580.00, 775.00, 0.00, 0.00, 'flat', '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(1561, '2024-08-26', 351, 'App\\Models\\Purchase', 79, 72.00, '[\"72\"]', 235.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1562, '2024-08-26', 349, 'App\\Models\\Purchase', 79, 12.00, '[\"12\"]', 240.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1563, '2024-08-26', 246, 'App\\Models\\Purchase', 79, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1564, '2024-08-26', 400, 'App\\Models\\Purchase', 79, 72.00, '[\"72\"]', 34.00, 38.00, 55.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1565, '2024-08-26', 274, 'App\\Models\\Purchase', 79, 72.00, '[\"72\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1566, '2024-08-26', 239, 'App\\Models\\Purchase', 79, 48.00, '[\"48\"]', 34.00, 38.00, 45.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1567, '2024-08-26', 238, 'App\\Models\\Purchase', 79, 60.00, '[\"60\"]', 13.00, 17.00, 30.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1568, '2024-08-26', 303, 'App\\Models\\Purchase', 79, 120.00, '[\"120\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1569, '2024-08-26', 300, 'App\\Models\\Purchase', 79, 72.00, '[\"72\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1570, '2024-08-26', 411, 'App\\Models\\Purchase', 79, 6.00, '[\"6\"]', 800.00, 900.00, 1320.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1571, '2024-08-26', 354, 'App\\Models\\Purchase', 79, 2.00, '[\"2\"]', 730.00, 820.00, 1200.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1572, '2024-08-26', 290, 'App\\Models\\Purchase', 79, 24.00, '[\"24\"]', 245.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1573, '2024-08-26', 310, 'App\\Models\\Purchase', 79, 12.00, '[\"12\"]', 265.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1574, '2024-08-26', 248, 'App\\Models\\Purchase', 79, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1575, '2024-08-26', 350, 'App\\Models\\Purchase', 79, 12.00, '[\"12\"]', 120.00, 130.00, 190.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1576, '2024-08-26', 326, 'App\\Models\\Purchase', 79, 1.00, '[\"1\"]', 3300.00, 3600.00, 4080.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1577, '2024-08-26', 307, 'App\\Models\\Purchase', 79, 6.00, '[\"6\"]', 320.00, 370.00, 500.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1578, '2024-08-26', 395, 'App\\Models\\Purchase', 79, 10.00, '[\"10\"]', 215.00, 236.00, 320.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:34', '2024-08-26 06:13:34'),
(1579, '2024-08-26', 295, 'App\\Models\\Purchase', 79, 3.00, '[\"3\"]', 220.00, 245.00, 330.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1580, '2024-08-26', 352, 'App\\Models\\Purchase', 79, 60.00, '[\"60\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1581, '2024-08-26', 315, 'App\\Models\\Purchase', 79, 180.00, '[\"180\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1582, '2024-08-26', 288, 'App\\Models\\Purchase', 79, 12.00, '[\"12\"]', 225.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1583, '2024-08-26', 299, 'App\\Models\\Purchase', 79, 30.00, '[\"30\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1584, '2024-08-26', 301, 'App\\Models\\Purchase', 79, 32.00, '[\"32\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1585, '2024-08-26', 393, 'App\\Models\\Purchase', 79, 144.00, '[\"144\"]', 10.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1586, '2024-08-26', 347, 'App\\Models\\Purchase', 79, 1.00, '[\"1\"]', 140.00, 180.00, 250.00, 0.00, 0.00, 'flat', '2024-08-26 06:13:35', '2024-08-26 06:13:35'),
(1587, '2024-08-26', 351, 'App\\Models\\Sale', 84, 72.00, '[\"72\"]', 235.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1588, '2024-08-26', 349, 'App\\Models\\Sale', 84, 12.00, '[\"12\"]', 240.00, 290.00, 350.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1589, '2024-08-26', 246, 'App\\Models\\Sale', 84, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1590, '2024-08-26', 400, 'App\\Models\\Sale', 84, 72.00, '[\"72\"]', 34.00, 38.00, 55.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1591, '2024-08-26', 274, 'App\\Models\\Sale', 84, 72.00, '[\"72\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1592, '2024-08-26', 239, 'App\\Models\\Sale', 84, 48.00, '[\"48\"]', 34.00, 38.00, 45.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1593, '2024-08-26', 238, 'App\\Models\\Sale', 84, 60.00, '[\"60\"]', 13.00, 17.00, 30.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1594, '2024-08-26', 303, 'App\\Models\\Sale', 84, 120.00, '[\"120\"]', 29.50, 32.50, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1595, '2024-08-26', 300, 'App\\Models\\Sale', 84, 72.00, '[\"72\"]', 64.00, 70.00, 90.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1596, '2024-08-26', 411, 'App\\Models\\Sale', 84, 6.00, '[\"6\"]', 800.00, 900.00, 1320.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1597, '2024-08-26', 354, 'App\\Models\\Sale', 84, 2.00, '[\"2\"]', 730.00, 820.00, 1200.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1598, '2024-08-26', 290, 'App\\Models\\Sale', 84, 24.00, '[\"24\"]', 245.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1599, '2024-08-26', 310, 'App\\Models\\Sale', 84, 12.00, '[\"12\"]', 265.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1600, '2024-08-26', 248, 'App\\Models\\Sale', 84, 72.00, '[\"72\"]', 23.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1601, '2024-08-26', 350, 'App\\Models\\Sale', 84, 12.00, '[\"12\"]', 120.00, 130.00, 190.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1602, '2024-08-26', 326, 'App\\Models\\Sale', 84, 1.00, '[\"1\"]', 3300.00, 3600.00, 4080.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(1603, '2024-08-26', 307, 'App\\Models\\Sale', 84, 6.00, '[\"6\"]', 320.00, 370.00, 500.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1604, '2024-08-26', 395, 'App\\Models\\Sale', 84, 10.00, '[\"10\"]', 215.00, 236.00, 320.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1605, '2024-08-26', 295, 'App\\Models\\Sale', 84, 3.00, '[\"3\"]', 97.00, 245.00, 330.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1606, '2024-08-26', 352, 'App\\Models\\Sale', 84, 60.00, '[\"60\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1607, '2024-08-26', 315, 'App\\Models\\Sale', 84, 180.00, '[\"180\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1608, '2024-08-26', 288, 'App\\Models\\Sale', 84, 12.00, '[\"12\"]', 225.00, 250.00, 300.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1609, '2024-08-26', 299, 'App\\Models\\Sale', 84, 30.00, '[\"30\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1610, '2024-08-26', 301, 'App\\Models\\Sale', 84, 32.00, '[\"32\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1611, '2024-08-26', 393, 'App\\Models\\Sale', 84, 144.00, '[\"144\"]', 10.00, 13.00, 20.00, 0.00, 0.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1612, '2024-08-26', 347, 'App\\Models\\Sale', 84, 1.00, '[\"1\"]', 140.00, 180.00, 250.00, 0.00, 180.00, 'flat', '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(1613, '2024-08-27', 1, 'App\\Models\\Purchase', 80, 3.00, '[\"3\"]', 1020.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(1614, '2024-08-27', 2, 'App\\Models\\Purchase', 80, 3.00, '[\"3\"]', 1540.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(1615, '2024-08-27', 144, 'App\\Models\\Purchase', 80, 5.00, '[\"5\"]', 140.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(1616, '2024-08-28', 102, 'App\\Models\\Sale', 85, 25.00, '[\"25\"]', 80.00, 140.00, 220.00, 0.00, 0.00, 'flat', '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(1617, '2024-08-28', 145, 'App\\Models\\Sale', 85, 44.00, '[\"44\"]', 11.72, 55.00, 85.00, 0.00, 0.00, 'flat', '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(1618, '2024-08-28', 141, 'App\\Models\\Sale', 85, 99.00, '[\"99\"]', 6.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(1619, '2024-08-28', 55, 'App\\Models\\Sale', 85, 36.00, '[\"36\"]', 85.00, 120.00, 150.00, 0.00, 0.00, 'flat', '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(1620, '2024-08-28', 57, 'App\\Models\\Sale', 85, 35.00, '[\"35\"]', 132.00, 165.00, 195.00, 0.00, 0.00, 'flat', '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(1624, '2024-08-30', 367, 'App\\Models\\Purchase', 81, 40.00, '[\"40\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-08-30 07:17:25', '2024-08-30 07:17:25'),
(1625, '2024-08-30', 412, 'App\\Models\\Purchase', 81, 24.00, '[\"24\"]', 715.00, 790.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-30 07:17:25', '2024-08-30 07:17:25'),
(1626, '2024-08-31', 100, 'App\\Models\\Purchase', 82, 10.00, '[\"10\"]', 360.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:25', '2024-08-31 02:39:25'),
(1627, '2024-08-31', 140, 'App\\Models\\Purchase', 82, 5.00, '[\"5\"]', 50.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:25', '2024-08-31 02:39:25'),
(1628, '2024-08-31', 160, 'App\\Models\\Purchase', 82, 5.00, '[\"5\"]', 280.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:25', '2024-08-31 02:39:25'),
(1629, '2024-08-31', 96, 'App\\Models\\Purchase', 82, 5.00, '[\"5\"]', 105.00, 90.00, 0.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(1630, '2024-08-31', 93, 'App\\Models\\Purchase', 82, 5.00, '[\"5\"]', 136.00, 90.00, 0.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(1631, '2024-08-31', 158, 'App\\Models\\Purchase', 82, 6.00, '[\"6\"]', 230.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(1632, '2024-08-31', 149, 'App\\Models\\Purchase', 82, 2.00, '[\"2\"]', 850.00, 1150.00, 1500.00, 0.00, 0.00, 'flat', '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(1633, '2024-08-31', 213, 'App\\Models\\Purchase', 83, 10.00, '[\"10\"]', 200.00, 490.00, 660.00, 0.00, 0.00, 'flat', '2024-08-31 02:43:22', '2024-08-31 02:43:22'),
(1634, '2024-08-31', 157, 'App\\Models\\Purchase', 83, 28.00, '[\"28\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-08-31 02:43:22', '2024-08-31 02:43:22'),
(1635, '2024-08-31', 412, 'App\\Models\\Sale', 86, 24.00, '[\"24\"]', 715.00, 790.00, 1100.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1636, '2024-08-31', 367, 'App\\Models\\Sale', 86, 40.00, '[\"40\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1637, '2024-08-31', 159, 'App\\Models\\Sale', 86, 98.00, '[\"98\"]', 14.09, 40.00, 65.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1638, '2024-08-31', 157, 'App\\Models\\Sale', 86, 28.00, '[\"28\"]', 58.34, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1639, '2024-08-31', 155, 'App\\Models\\Sale', 86, 18.00, '[\"18\"]', 85.00, 115.00, 150.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1640, '2024-08-31', 145, 'App\\Models\\Sale', 86, 45.00, '[\"45\"]', 11.72, 55.00, 85.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1641, '2024-08-31', 141, 'App\\Models\\Sale', 86, 42.00, '[\"42\"]', 5.96, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1642, '2024-08-31', 102, 'App\\Models\\Sale', 86, 52.00, '[\"52\"]', 69.23, 160.00, 220.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1643, '2024-08-31', 87, 'App\\Models\\Sale', 86, 46.00, '[\"46\"]', 39.13, 70.00, 95.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1644, '2024-08-31', 39, 'App\\Models\\Sale', 86, 46.00, '[\"46\"]', 10.87, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1645, '2024-08-31', 24, 'App\\Models\\Sale', 86, 48.00, '[\"48\"]', 21.89, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(1646, '2024-08-31', 19, 'App\\Models\\Sale', 87, 5.00, '[\"5\"]', 170.00, 220.00, 600.00, 0.00, 0.00, 'flat', '2024-08-31 04:20:27', '2024-08-31 04:20:27'),
(1647, '2024-08-31', 81, 'App\\Models\\Sale', 87, 10.00, '[\"10\"]', 75.00, 100.00, 0.00, 0.00, 0.00, 'flat', '2024-08-31 04:20:27', '2024-08-31 04:20:27'),
(1648, '2024-08-31', 166, 'App\\Models\\Sale', 87, 25.00, '[\"25\"]', 72.00, 85.00, 500.00, 0.00, 0.00, 'flat', '2024-08-31 04:20:27', '2024-08-31 04:20:27'),
(1649, '2024-09-07', 283, 'App\\Models\\Purchase', 84, 20.00, '[\"20\"]', 290.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-09-07 04:10:45', '2024-09-07 04:10:45'),
(1650, '2024-09-07', 242, 'App\\Models\\Purchase', 84, 4.00, '[\"4\"]', 2050.00, 2270.00, 2800.00, 0.00, 0.00, 'flat', '2024-09-07 04:10:45', '2024-09-07 04:10:45'),
(1651, '2024-09-07', 388, 'App\\Models\\Purchase', 84, 6.00, '[\"6\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-09-07 04:10:45', '2024-09-07 04:10:45'),
(1652, '2024-09-07', 337, 'App\\Models\\Purchase', 84, 12.00, '[\"12\"]', 145.00, 155.00, 220.00, 0.00, 0.00, 'flat', '2024-09-07 04:10:46', '2024-09-07 04:10:46'),
(1653, '2024-09-07', 281, 'App\\Models\\Purchase', 84, 12.00, '[\"12\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-07 04:10:46', '2024-09-07 04:10:46'),
(1654, '2024-09-07', 412, 'App\\Models\\Purchase', 85, 6.00, '[\"6\"]', 715.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-09-07 04:18:37', '2024-09-07 04:18:37'),
(1655, '2024-09-07', 367, 'App\\Models\\Purchase', 85, 40.00, '[\"40\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-09-07 04:18:37', '2024-09-07 04:18:37'),
(1656, '2024-09-07', 346, 'App\\Models\\Purchase', 86, 144.00, '[\"144\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1657, '2024-09-07', 406, 'App\\Models\\Purchase', 86, 48.00, '[\"48\"]', 90.00, 115.00, 150.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17');
INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(1658, '2024-09-07', 407, 'App\\Models\\Purchase', 86, 24.00, '[\"24\"]', 155.00, 170.00, 280.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1659, '2024-09-07', 408, 'App\\Models\\Purchase', 86, 72.00, '[\"72\"]', 54.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1660, '2024-09-07', 298, 'App\\Models\\Purchase', 86, 2.00, '[\"2\"]', 650.00, 720.00, 0.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1661, '2024-09-07', 270, 'App\\Models\\Purchase', 86, 60.00, '[\"60\"]', 16.00, 22.00, 30.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1662, '2024-09-07', 271, 'App\\Models\\Purchase', 86, 48.00, '[\"48\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(1663, '2024-09-07', 412, 'App\\Models\\Sale', 88, 6.00, '[\"6\"]', 715.00, 790.00, 1000.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1664, '2024-09-07', 408, 'App\\Models\\Sale', 88, 72.00, '[\"72\"]', 54.00, 60.00, 90.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1665, '2024-09-07', 407, 'App\\Models\\Sale', 88, 24.00, '[\"24\"]', 155.00, 170.00, 280.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1666, '2024-09-07', 406, 'App\\Models\\Sale', 88, 48.00, '[\"48\"]', 90.00, 115.00, 150.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1667, '2024-09-07', 367, 'App\\Models\\Sale', 88, 40.00, '[\"40\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1668, '2024-09-07', 346, 'App\\Models\\Sale', 88, 144.00, '[\"144\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1669, '2024-09-07', 298, 'App\\Models\\Sale', 88, 2.00, '[\"2\"]', 650.00, 720.00, 0.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1670, '2024-09-07', 283, 'App\\Models\\Sale', 88, 10.00, '[\"10\"]', 290.00, 310.00, 370.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1671, '2024-09-07', 271, 'App\\Models\\Sale', 88, 48.00, '[\"48\"]', 90.00, 100.00, 130.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1672, '2024-09-07', 270, 'App\\Models\\Sale', 88, 60.00, '[\"60\"]', 16.00, 22.00, 30.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1673, '2024-09-07', 242, 'App\\Models\\Sale', 88, 2.00, '[\"2\"]', 2050.00, 2270.00, 2800.00, 0.00, 0.00, 'flat', '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(1674, '2024-09-07', 32, 'App\\Models\\Purchase', 87, 10.00, '[\"10\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-09-07 06:14:36', '2024-09-07 06:14:36'),
(1675, '2024-09-08', 388, 'App\\Models\\Sale', 89, 6.00, '[\"6\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1676, '2024-09-08', 337, 'App\\Models\\Sale', 89, 12.00, '[\"12\"]', 145.00, 155.00, 220.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1677, '2024-09-08', 283, 'App\\Models\\Sale', 89, 10.00, '[\"10\"]', 290.00, 390.00, 370.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1678, '2024-09-08', 281, 'App\\Models\\Sale', 89, 12.00, '[\"12\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1679, '2024-09-08', 242, 'App\\Models\\Sale', 89, 2.00, '[\"2\"]', 2050.00, 2270.00, 2800.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1680, '2024-09-08', 32, 'App\\Models\\Sale', 89, 10.00, '[\"10\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(1681, '2024-09-08', 110, 'App\\Models\\Purchase', 88, 25.00, '[\"25\"]', 146.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1682, '2024-09-08', 114, 'App\\Models\\Purchase', 88, 10.00, '[\"10\"]', 460.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1683, '2024-09-08', 21, 'App\\Models\\Purchase', 88, 10.00, '[\"10\"]', 480.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1684, '2024-09-08', 89, 'App\\Models\\Purchase', 88, 10.00, '[\"10\"]', 640.00, 0.00, 1300.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1685, '2024-09-08', 95, 'App\\Models\\Purchase', 88, 5.00, '[\"5\"]', 1100.00, 1300.00, 1600.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1686, '2024-09-08', 29, 'App\\Models\\Purchase', 88, 2.00, '[\"2\"]', 2750.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1687, '2024-09-08', 140, 'App\\Models\\Purchase', 88, 20.00, '[\"20\"]', 55.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1688, '2024-09-08', 98, 'App\\Models\\Purchase', 88, 4.00, '[\"4\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(1689, '2024-09-11', 413, 'App\\Models\\Purchase', 89, 36.00, '[\"36\"]', 451.00, 520.00, 620.00, 0.00, 0.00, 'flat', '2024-09-11 03:53:16', '2024-09-11 03:53:16'),
(1690, '2024-09-11', 413, 'App\\Models\\Sale', 90, 24.00, '[\"24\"]', 451.00, 520.00, 620.00, 0.00, 0.00, 'flat', '2024-09-11 03:53:43', '2024-09-11 03:53:43'),
(1691, '2024-09-17', 164, 'App\\Models\\Purchase', 90, 5.00, '[\"5\"]', 340.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-09-17 09:08:33', '2024-09-17 09:08:33'),
(1692, '2024-09-17', 32, 'App\\Models\\Purchase', 91, 20.00, '[\"20\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1693, '2024-09-17', 2, 'App\\Models\\Purchase', 91, 10.00, '[\"10\"]', 1570.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1694, '2024-09-17', 1, 'App\\Models\\Purchase', 91, 10.00, '[\"10\"]', 1050.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1695, '2024-09-17', 193, 'App\\Models\\Purchase', 91, 25.00, '[\"25\"]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1696, '2024-09-17', 3, 'App\\Models\\Purchase', 91, 3.00, '[\"3\"]', 2700.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1697, '2024-09-17', 199, 'App\\Models\\Purchase', 91, 2.00, '[\"2\"]', 2200.00, 2500.00, 0.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1698, '2024-09-17', 198, 'App\\Models\\Purchase', 91, 1.00, '[\"1\"]', 5150.00, 5800.00, 0.00, 0.00, 0.00, 'flat', '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(1716, '2024-09-17', 370, 'App\\Models\\Purchase', 92, 10.00, '[\"10\"]', 300.00, 600.00, 850.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:22', '2024-09-17 09:21:22'),
(1717, '2024-09-17', 413, 'App\\Models\\Sale', 91, 12.00, '[\"12\"]', 451.00, 520.00, 620.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1718, '2024-09-17', 213, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 200.00, 490.00, 660.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1719, '2024-09-17', 199, 'App\\Models\\Sale', 91, 2.00, '[\"2\"]', 2200.00, 2500.00, 0.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1720, '2024-09-17', 198, 'App\\Models\\Sale', 91, 1.00, '[\"1\"]', 5150.00, 5800.00, 0.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1721, '2024-09-17', 193, 'App\\Models\\Sale', 91, 25.00, '[\"25\"]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1722, '2024-09-17', 140, 'App\\Models\\Sale', 91, 20.00, '[\"20\"]', 55.00, 350.00, 500.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1723, '2024-09-17', 114, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 460.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1724, '2024-09-17', 110, 'App\\Models\\Sale', 91, 25.00, '[\"25\"]', 146.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1725, '2024-09-17', 98, 'App\\Models\\Sale', 91, 4.00, '[\"4\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1726, '2024-09-17', 95, 'App\\Models\\Sale', 91, 5.00, '[\"5\"]', 1100.00, 1300.00, 1600.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1727, '2024-09-17', 89, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 640.00, 0.00, 1300.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1728, '2024-09-17', 32, 'App\\Models\\Sale', 91, 20.00, '[\"20\"]', 630.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1729, '2024-09-17', 29, 'App\\Models\\Sale', 91, 2.00, '[\"2\"]', 2750.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1730, '2024-09-17', 21, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 480.00, 630.00, 700.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1731, '2024-09-17', 3, 'App\\Models\\Sale', 91, 3.00, '[\"3\"]', 2700.00, 3800.00, 4400.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1732, '2024-09-17', 2, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 1570.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1733, '2024-09-17', 1, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 1050.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1734, '2024-09-17', 370, 'App\\Models\\Sale', 91, 10.00, '[\"10\"]', 300.00, 600.00, 850.00, 0.00, 0.00, 'flat', '2024-09-17 09:21:56', '2024-09-17 09:21:56'),
(1773, '2024-09-25', 205, 'App\\Models\\Purchase', 93, 24.00, '[\"24\"]', 150.00, 190.00, 275.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1774, '2024-09-25', 204, 'App\\Models\\Purchase', 93, 24.00, '[\"24\"]', 265.00, 290.00, 475.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1775, '2024-09-25', 414, 'App\\Models\\Purchase', 93, 50.00, '[\"50\"]', 46.00, 52.00, 60.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1776, '2024-09-25', 396, 'App\\Models\\Purchase', 93, 120.00, '[\"120\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1777, '2024-09-25', 346, 'App\\Models\\Purchase', 93, 96.00, '[\"96\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1778, '2024-09-25', 370, 'App\\Models\\Purchase', 93, 1.00, '[\"1\"]', 800.00, 1000.00, 1700.00, 0.00, 40.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1779, '2024-09-25', 238, 'App\\Models\\Purchase', 93, 90.00, '[\"90\"]', 13.00, 17.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1780, '2024-09-25', 239, 'App\\Models\\Purchase', 93, 72.00, '[\"72\"]', 34.00, 38.00, 45.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1781, '2024-09-25', 265, 'App\\Models\\Purchase', 93, 2.00, '[\"2\"]', 14.00, 17.00, 25.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1782, '2024-09-25', 283, 'App\\Models\\Purchase', 93, 30.00, '[\"30\"]', 290.00, 320.00, 395.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1783, '2024-09-25', 242, 'App\\Models\\Purchase', 93, 60.00, '[\"60\"]', 115.00, 125.00, 150.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1784, '2024-09-25', 274, 'App\\Models\\Purchase', 93, 24.00, '[\"24\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1785, '2024-09-25', 411, 'App\\Models\\Purchase', 93, 6.00, '[\"6\"]', 800.00, 900.00, 1320.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1786, '2024-09-25', 246, 'App\\Models\\Purchase', 93, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1787, '2024-09-25', 319, 'App\\Models\\Purchase', 93, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1788, '2024-09-25', 241, 'App\\Models\\Purchase', 93, 120.00, '[\"120\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1789, '2024-09-25', 303, 'App\\Models\\Purchase', 93, 240.00, '[\"240\"]', 31.00, 34.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1790, '2024-09-25', 304, 'App\\Models\\Purchase', 93, 180.00, '[\"180\"]', 27.50, 31.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1791, '2024-09-25', 240, 'App\\Models\\Purchase', 93, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1792, '2024-09-25', 313, 'App\\Models\\Purchase', 93, 48.00, '[\"48\"]', 78.00, 86.00, 110.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1793, '2024-09-25', 260, 'App\\Models\\Purchase', 93, 160.00, '[\"160\"]', 10.00, 12.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1794, '2024-09-25', 243, 'App\\Models\\Purchase', 93, 40.00, '[\"40\"]', 200.00, 225.00, 300.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1795, '2024-09-25', 395, 'App\\Models\\Purchase', 93, 10.00, '[\"10\"]', 220.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1796, '2024-09-25', 315, 'App\\Models\\Purchase', 93, 180.00, '[\"180\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1797, '2024-09-25', 312, 'App\\Models\\Purchase', 93, 42.00, '[\"42\"]', 15.00, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1798, '2024-09-25', 415, 'App\\Models\\Purchase', 93, 2.00, '[\"2\"]', 410.00, 460.00, 720.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1799, '2024-09-25', 307, 'App\\Models\\Purchase', 93, 12.00, '[\"12\"]', 320.00, 400.00, 750.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1800, '2024-09-25', 292, 'App\\Models\\Purchase', 93, 180.00, '[\"180\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1801, '2024-09-25', 291, 'App\\Models\\Purchase', 93, 180.00, '[\"180\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1802, '2024-09-25', 321, 'App\\Models\\Purchase', 93, 96.00, '[\"96\"]', 30.00, 40.00, 60.00, 0.00, 30.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1803, '2024-09-25', 352, 'App\\Models\\Purchase', 93, 100.00, '[\"100\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1804, '2024-09-25', 310, 'App\\Models\\Purchase', 93, 12.00, '[\"12\"]', 265.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1805, '2024-09-25', 293, 'App\\Models\\Purchase', 93, 12.00, '[\"12\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1806, '2024-09-25', 318, 'App\\Models\\Purchase', 93, 32.00, '[\"32\"]', 145.00, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1807, '2024-09-25', 301, 'App\\Models\\Purchase', 93, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1808, '2024-09-25', 299, 'App\\Models\\Purchase', 93, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1809, '2024-09-25', 416, 'App\\Models\\Purchase', 93, 3.00, '[\"3\"]', 500.00, 550.00, 800.00, 0.00, 0.00, 'flat', '2024-09-25 07:46:40', '2024-09-25 07:46:40'),
(1810, '2024-09-25', 416, 'App\\Models\\Sale', 92, 3.00, '[\"3\"]', 500.00, 550.00, 800.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1811, '2024-09-25', 415, 'App\\Models\\Sale', 92, 2.00, '[\"2\"]', 410.00, 460.00, 720.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1812, '2024-09-25', 414, 'App\\Models\\Sale', 92, 50.00, '[\"50\"]', 46.00, 52.00, 60.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1813, '2024-09-25', 411, 'App\\Models\\Sale', 92, 6.00, '[\"6\"]', 800.00, 900.00, 1320.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1814, '2024-09-25', 401, 'App\\Models\\Sale', 92, 2.00, '[\"2\"]', 210.00, 750.00, 0.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1815, '2024-09-25', 396, 'App\\Models\\Sale', 92, 120.00, '[\"120\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1816, '2024-09-25', 395, 'App\\Models\\Sale', 92, 10.00, '[\"10\"]', 220.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1817, '2024-09-25', 370, 'App\\Models\\Sale', 92, 1.00, '[\"1\"]', 800.00, 1000.00, 1700.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1818, '2024-09-25', 352, 'App\\Models\\Sale', 92, 100.00, '[\"100\"]', 25.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1819, '2024-09-25', 346, 'App\\Models\\Sale', 92, 96.00, '[\"96\"]', 90.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1820, '2024-09-25', 321, 'App\\Models\\Sale', 92, 96.00, '[\"96\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1821, '2024-09-25', 319, 'App\\Models\\Sale', 92, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1822, '2024-09-25', 318, 'App\\Models\\Sale', 92, 32.00, '[\"32\"]', 145.00, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1823, '2024-09-25', 315, 'App\\Models\\Sale', 92, 180.00, '[\"180\"]', 20.00, 25.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1824, '2024-09-25', 313, 'App\\Models\\Sale', 92, 48.00, '[\"48\"]', 78.00, 86.00, 110.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1825, '2024-09-25', 312, 'App\\Models\\Sale', 92, 42.00, '[\"42\"]', 15.00, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1826, '2024-09-25', 310, 'App\\Models\\Sale', 92, 12.00, '[\"12\"]', 265.00, 290.00, 370.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1827, '2024-09-25', 307, 'App\\Models\\Sale', 92, 12.00, '[\"12\"]', 320.00, 400.00, 750.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1828, '2024-09-25', 304, 'App\\Models\\Sale', 92, 180.00, '[\"180\"]', 27.50, 31.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1829, '2024-09-25', 303, 'App\\Models\\Sale', 92, 240.00, '[\"240\"]', 31.00, 34.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1830, '2024-09-25', 301, 'App\\Models\\Sale', 92, 90.00, '[\"90\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1831, '2024-09-25', 299, 'App\\Models\\Sale', 92, 96.00, '[\"96\"]', 13.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1832, '2024-09-25', 293, 'App\\Models\\Sale', 92, 12.00, '[\"12\"]', 420.00, 450.00, 580.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1833, '2024-09-25', 292, 'App\\Models\\Sale', 92, 180.00, '[\"180\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1834, '2024-09-25', 291, 'App\\Models\\Sale', 92, 180.00, '[\"180\"]', 24.00, 30.00, 40.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1835, '2024-09-25', 283, 'App\\Models\\Sale', 92, 30.00, '[\"30\"]', 290.00, 320.00, 395.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1836, '2024-09-25', 274, 'App\\Models\\Sale', 92, 24.00, '[\"24\"]', 98.00, 108.00, 130.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1837, '2024-09-25', 265, 'App\\Models\\Sale', 92, 2.00, '[\"2\"]', 14.00, 17.00, 25.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1838, '2024-09-25', 260, 'App\\Models\\Sale', 92, 160.00, '[\"160\"]', 10.00, 12.00, 20.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1839, '2024-09-25', 204, 'App\\Models\\Sale', 92, 24.00, '[\"24\"]', 265.00, 290.00, 475.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1840, '2024-09-25', 205, 'App\\Models\\Sale', 92, 24.00, '[\"24\"]', 150.00, 190.00, 275.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1841, '2024-09-25', 246, 'App\\Models\\Sale', 92, 48.00, '[\"48\"]', 98.00, 110.00, 140.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1842, '2024-09-25', 243, 'App\\Models\\Sale', 92, 40.00, '[\"40\"]', 200.00, 225.00, 300.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1843, '2024-09-25', 242, 'App\\Models\\Sale', 92, 60.00, '[\"60\"]', 115.00, 125.00, 150.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1844, '2024-09-25', 241, 'App\\Models\\Sale', 92, 120.00, '[\"120\"]', 22.00, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1845, '2024-09-25', 240, 'App\\Models\\Sale', 92, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1846, '2024-09-25', 239, 'App\\Models\\Sale', 92, 72.00, '[\"72\"]', 34.00, 38.00, 45.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1847, '2024-09-25', 238, 'App\\Models\\Sale', 92, 90.00, '[\"90\"]', 13.00, 17.00, 30.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1848, '2024-09-25', 164, 'App\\Models\\Sale', 92, 5.00, '[\"5\"]', 340.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1849, '2024-09-25', 160, 'App\\Models\\Sale', 92, 2.00, '[\"2\"]', 280.00, 420.00, 1000.00, 0.00, 0.00, 'flat', '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(1850, '2024-09-28', 72, 'App\\Models\\Purchase', 94, 2.00, '[\"2\"]', 260.00, 800.00, 0.00, 0.00, 0.00, 'flat', '2024-09-28 11:40:05', '2024-09-28 11:40:05'),
(1851, '2024-09-28', 104, 'App\\Models\\Purchase', 94, 5.00, '[\"5\"]', 120.00, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-09-28 11:40:05', '2024-09-28 11:40:05'),
(1852, '2024-09-29', 281, 'App\\Models\\Purchase', 95, 24.00, '[\"24\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(1853, '2024-09-29', 282, 'App\\Models\\Purchase', 95, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(1854, '2024-09-29', 370, 'App\\Models\\Purchase', 95, 2.00, '[\"2\"]', 800.00, 1000.00, 1700.00, 0.00, 0.00, 'flat', '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(1855, '2024-09-29', 396, 'App\\Models\\Purchase', 95, 360.00, '[\"360\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(1856, '2024-09-29', 321, 'App\\Models\\Purchase', 95, 50.00, '[\"50\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(1868, '2024-09-30', 23, 'App\\Models\\Purchase', 96, 1.00, '[\"1\"]', 1050.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1869, '2024-09-30', 105, 'App\\Models\\Purchase', 96, 8.00, '[\"8\"]', 12.80, 30.00, 45.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1870, '2024-09-30', 102, 'App\\Models\\Purchase', 96, 10.00, '[\"10\"]', 69.23, 160.00, 220.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1871, '2024-09-30', 56, 'App\\Models\\Purchase', 96, 9.00, '[\"9\"]', 280.00, 330.00, 370.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1872, '2024-09-30', 112, 'App\\Models\\Purchase', 96, 2.00, '[\"2\"]', 80.00, 120.00, 0.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1873, '2024-09-30', 93, 'App\\Models\\Purchase', 96, 2.00, '[\"2\"]', 136.00, 130.00, 155.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1874, '2024-09-30', 69, 'App\\Models\\Purchase', 96, 2.00, '[\"2\"]', 93.33, 130.00, 150.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1875, '2024-09-30', 182, 'App\\Models\\Purchase', 96, 6.00, '[\"6\"]', 104.00, 155.00, 200.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1876, '2024-09-30', 121, 'App\\Models\\Purchase', 96, 8.00, '[\"8\"]', 0.00, 26.00, 40.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1877, '2024-09-30', 175, 'App\\Models\\Purchase', 96, 1.00, '[\"1\"]', 41.63, 85.00, 125.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1878, '2024-09-30', 39, 'App\\Models\\Purchase', 96, 3.00, '[\"3\"]', 10.87, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1879, '2024-09-30', 87, 'App\\Models\\Purchase', 96, 7.00, '[\"7\"]', 39.13, 70.00, 95.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1880, '2024-09-30', 145, 'App\\Models\\Purchase', 96, 2.00, '[\"2\"]', 11.72, 55.00, 85.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1881, '2024-09-30', 193, 'App\\Models\\Purchase', 96, 12.00, '[\"12\"]', 340.00, 500.00, 700.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1882, '2024-09-30', 73, 'App\\Models\\Purchase', 96, 12.00, '[\"12\"]', 6.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(1883, '2024-09-30', 417, 'App\\Models\\Sale', 93, 22.00, '[\"22\"]', 20.00, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1884, '2024-09-30', 396, 'App\\Models\\Sale', 93, 150.00, '[\"150\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1885, '2024-09-30', 370, 'App\\Models\\Sale', 93, 2.00, '[\"2\"]', 800.00, 1000.00, 1700.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1886, '2024-09-30', 321, 'App\\Models\\Sale', 93, 50.00, '[\"50\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1887, '2024-09-30', 282, 'App\\Models\\Sale', 93, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1888, '2024-09-30', 281, 'App\\Models\\Sale', 93, 24.00, '[\"24\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1889, '2024-09-30', 153, 'App\\Models\\Sale', 93, 41.00, '[\"41\"]', 52.00, 75.00, 105.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1890, '2024-09-30', 141, 'App\\Models\\Sale', 93, 28.00, '[\"28\"]', 5.96, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1891, '2024-09-30', 105, 'App\\Models\\Sale', 93, 53.00, '[\"53\"]', 12.80, 30.00, 45.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1892, '2024-09-30', 73, 'App\\Models\\Sale', 93, 65.00, '[\"65\"]', 6.00, 15.00, 20.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1893, '2024-09-30', 65, 'App\\Models\\Sale', 93, 10.00, '[\"10\"]', 220.00, 290.00, 380.00, 0.00, 0.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1894, '2024-09-30', 87, 'App\\Models\\Sale', 93, 5.00, '[\"5\"]', 39.13, 70.00, 95.00, 0.00, 95.00, 'flat', '2024-09-30 08:58:54', '2024-09-30 08:58:54'),
(1895, '2024-10-06', 33, 'App\\Models\\Purchase', 97, 29.00, '[\"29\"]', 65.17, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1896, '2024-10-06', 99, 'App\\Models\\Purchase', 97, 15.00, '[\"15\"]', 9.33, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1897, '2024-10-06', 98, 'App\\Models\\Purchase', 97, 2.00, '[\"2\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1898, '2024-10-06', 87, 'App\\Models\\Purchase', 97, 44.00, '[\"44\"]', 40.91, 70.00, 95.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1899, '2024-10-06', 111, 'App\\Models\\Purchase', 97, 30.00, '[\"30\"]', 87.60, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1900, '2024-10-06', 112, 'App\\Models\\Purchase', 97, 33.00, '[\"33\"]', 36.50, 70.00, 110.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1901, '2024-10-06', 21, 'App\\Models\\Purchase', 97, 10.00, '[\"10\"]', 480.00, 7500.00, 9500.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1902, '2024-10-06', 26, 'App\\Models\\Purchase', 97, 3.00, '[\"3\"]', 3300.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1903, '2024-10-06', 212, 'App\\Models\\Purchase', 97, 13.00, '[\"13\"]', 9.23, 25.00, 35.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1904, '2024-10-06', 63, 'App\\Models\\Purchase', 97, 32.00, '[\"32\"]', 84.38, 140.00, 200.00, 0.00, 0.00, 'flat', '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(1937, '2024-10-06', 33, 'App\\Models\\Sale', 94, 29.00, '[\"29\"]', 65.17, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1938, '2024-10-06', 99, 'App\\Models\\Sale', 94, 15.00, '[\"15\"]', 9.33, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1939, '2024-10-06', 98, 'App\\Models\\Sale', 94, 2.00, '[\"2\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1940, '2024-10-06', 87, 'App\\Models\\Sale', 94, 46.00, '[\"46\"]', 40.91, 70.00, 95.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1941, '2024-10-06', 111, 'App\\Models\\Sale', 94, 30.00, '[\"30\"]', 87.60, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1942, '2024-10-06', 112, 'App\\Models\\Sale', 94, 35.00, '[\"35\"]', 36.50, 70.00, 110.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1943, '2024-10-06', 21, 'App\\Models\\Sale', 94, 10.00, '[\"10\"]', 480.00, 750.00, 9500.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1944, '2024-10-06', 26, 'App\\Models\\Sale', 94, 3.00, '[\"3\"]', 3300.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1945, '2024-10-06', 212, 'App\\Models\\Sale', 94, 13.00, '[\"13\"]', 9.23, 25.00, 35.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1946, '2024-10-06', 63, 'App\\Models\\Sale', 94, 32.00, '[\"32\"]', 84.38, 140.00, 200.00, 0.00, 0.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1947, '2024-10-06', 182, 'App\\Models\\Sale', 94, 6.00, '[\"6\"]', 104.00, 155.00, 200.00, 0.00, 200.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1948, '2024-10-06', 175, 'App\\Models\\Sale', 94, 1.00, '[\"1\"]', 41.63, 70.00, 125.00, 0.00, 95.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1949, '2024-10-06', 145, 'App\\Models\\Sale', 94, 2.00, '[\"2\"]', 11.72, 55.00, 85.00, 0.00, 85.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1950, '2024-10-06', 121, 'App\\Models\\Sale', 94, 8.00, '[\"8\"]', 0.00, 30.00, 40.00, 0.00, 55.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1951, '2024-10-06', 105, 'App\\Models\\Sale', 94, 8.00, '[\"8\"]', 12.80, 25.00, 45.00, 0.00, 40.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1952, '2024-10-06', 102, 'App\\Models\\Sale', 94, 10.00, '[\"10\"]', 69.23, 160.00, 220.00, 0.00, 220.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1953, '2024-10-06', 73, 'App\\Models\\Sale', 94, 12.00, '[\"12\"]', 6.00, 15.00, 20.00, 0.00, 20.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1954, '2024-10-06', 69, 'App\\Models\\Sale', 94, 2.00, '[\"2\"]', 93.33, 130.00, 150.00, 0.00, 155.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1955, '2024-10-06', 93, 'App\\Models\\Sale', 94, 7.00, '[\"7\"]', 136.00, 130.00, 155.00, 0.00, 155.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1956, '2024-10-06', 56, 'App\\Models\\Sale', 94, 9.00, '[\"9\"]', 280.00, 330.00, 370.00, 0.00, 400.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1957, '2024-10-06', 39, 'App\\Models\\Sale', 94, 3.00, '[\"3\"]', 10.87, 40.00, 60.00, 0.00, 60.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1958, '2024-10-06', 24, 'App\\Models\\Sale', 94, 41.00, '[\"41\"]', 21.89, 35.00, 50.00, 0.00, 50.00, 'flat', '2024-10-06 06:28:22', '2024-10-06 06:28:22'),
(1959, '2024-10-07', 396, 'App\\Models\\Sale', 95, 210.00, '[\"210\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-10-07 03:13:25', '2024-10-07 03:13:25'),
(1960, '2024-10-08', 89, 'App\\Models\\Purchase', 98, 10.00, '[\"10\"]', 660.00, 850.00, 1000.00, 0.00, 0.00, 'flat', '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(1961, '2024-10-08', 165, 'App\\Models\\Purchase', 98, 5.00, '[\"5\"]', 1400.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(1962, '2024-10-08', 8, 'App\\Models\\Purchase', 98, 3.00, '[\"3\"]', 3200.00, 4400.00, 5400.00, 0.00, 0.00, 'flat', '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(1963, '2024-10-08', 92, 'App\\Models\\Purchase', 98, 3.00, '[\"3\"]', 1660.00, 2200.00, 2600.00, 0.00, 0.00, 'flat', '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(1964, '2024-10-08', 114, 'App\\Models\\Purchase', 98, 10.00, '[\"10\"]', 450.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(1995, '2024-10-10', 344, 'App\\Models\\Sale', 98, 12.00, '[\"12\"]', 71.11, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(1996, '2024-10-10', 115, 'App\\Models\\Sale', 98, 24.00, '[\"24\"]', 45.00, 65.00, 85.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(1997, '2024-10-10', 93, 'App\\Models\\Sale', 98, 20.00, '[\"20\"]', 118.58, 145.00, 185.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(1998, '2024-10-10', 91, 'App\\Models\\Sale', 98, 6.00, '[\"6\"]', 130.69, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(1999, '2024-10-10', 90, 'App\\Models\\Sale', 98, 6.00, '[\"6\"]', 65.34, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(2000, '2024-10-10', 67, 'App\\Models\\Sale', 98, 12.00, '[\"12\"]', 160.00, 210.00, 260.00, 0.00, 0.00, 'flat', '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(2010, '2024-10-12', 198, 'App\\Models\\Purchase', 99, 1.00, '[\"1\"]', 27200.00, 30000.00, 0.00, 0.00, 0.00, 'flat', '2024-10-12 06:22:37', '2024-10-12 06:22:37'),
(2011, '2024-10-09', 344, 'App\\Models\\Sale', 96, 33.00, '[\"33\"]', 71.11, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2012, '2024-10-09', 115, 'App\\Models\\Sale', 96, 76.00, '[\"76\"]', 45.00, 65.00, 85.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2013, '2024-10-09', 93, 'App\\Models\\Sale', 96, 22.00, '[\"22\"]', 118.58, 145.00, 185.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2014, '2024-10-09', 91, 'App\\Models\\Sale', 96, 24.00, '[\"24\"]', 130.69, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2015, '2024-10-09', 90, 'App\\Models\\Sale', 96, 35.00, '[\"35\"]', 65.34, 80.00, 105.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2016, '2024-10-09', 71, 'App\\Models\\Sale', 96, 52.00, '[\"52\"]', 94.23, 140.00, 195.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2017, '2024-10-09', 67, 'App\\Models\\Sale', 96, 28.00, '[\"28\"]', 160.00, 210.00, 260.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2018, '2024-10-09', 165, 'App\\Models\\Sale', 96, 1500.00, '[null,\"1\",\"500\"]', 1400.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2019, '2024-10-09', 161, 'App\\Models\\Sale', 96, 29.00, '[\"29\"]', 28.00, 60.00, 85.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2020, '2024-10-09', 198, 'App\\Models\\Sale', 96, 1.00, '[\"1\"]', 27200.00, 30000.00, 0.00, 0.00, 0.00, 'flat', '2024-10-12 06:23:53', '2024-10-12 06:23:53'),
(2021, '2024-10-16', 56, 'App\\Models\\SaleReturn', 7, 1.00, '[\"1\"]', 280.00, 0.00, 0.00, 330.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2022, '2024-10-16', 59, 'App\\Models\\SaleReturn', 7, 12.00, '[\"12\"]', 130.96, 0.00, 0.00, 190.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2023, '2024-10-16', 54, 'App\\Models\\SaleReturn', 7, 28.00, '[\"28\"]', 190.00, 0.00, 0.00, 245.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2024, '2024-10-16', 389, 'App\\Models\\SaleReturn', 7, 20.00, '[\"20\"]', 52.00, 0.00, 0.00, 105.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2025, '2024-10-16', 391, 'App\\Models\\SaleReturn', 7, 6.00, '[\"6\"]', 58.00, 0.00, 0.00, 100.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2026, '2024-10-16', 91, 'App\\Models\\SaleReturn', 7, 10.00, '[\"10\"]', 130.69, 0.00, 0.00, 280.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2027, '2024-10-16', 390, 'App\\Models\\SaleReturn', 7, 12.00, '[\"12\"]', 52.00, 0.00, 0.00, 100.00, 0.00, 'flat', '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(2028, '2024-10-16', 210, 'App\\Models\\Purchase', 100, 40.00, '[\"40\"]', 475.00, 625.00, 775.00, 0.00, 0.00, 'flat', '2024-10-15 22:37:30', '2024-10-15 22:37:30'),
(2029, '2024-10-16', 391, 'App\\Models\\Sale', 99, 6.00, '[\"6\"]', 58.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2030, '2024-10-16', 390, 'App\\Models\\Sale', 99, 12.00, '[\"12\"]', 52.00, 100.00, 125.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2031, '2024-10-16', 389, 'App\\Models\\Sale', 99, 20.00, '[\"20\"]', 52.00, 105.00, 130.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2032, '2024-10-16', 210, 'App\\Models\\Sale', 99, 40.00, '[\"40\"]', 475.00, 600.00, 775.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2033, '2024-10-16', 91, 'App\\Models\\Sale', 99, 10.00, '[\"10\"]', 130.69, 160.00, 210.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2034, '2024-10-16', 59, 'App\\Models\\Sale', 99, 12.00, '[\"12\"]', 130.96, 190.00, 220.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2035, '2024-10-16', 54, 'App\\Models\\Sale', 99, 28.00, '[\"28\"]', 190.00, 245.00, 280.00, 0.00, 0.00, 'flat', '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(2118, '2024-10-16', 396, 'App\\Models\\Sale', 100, 900.00, '[\"900\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2119, '2024-10-16', 370, 'App\\Models\\Sale', 100, 5.00, '[\"5\"]', 800.00, 1000.00, 1700.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2120, '2024-10-16', 321, 'App\\Models\\Sale', 100, 96.00, '[\"96\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2121, '2024-10-16', 240, 'App\\Models\\Sale', 100, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2122, '2024-10-16', 313, 'App\\Models\\Sale', 100, 65.00, '[\"65\"]', 40.00, 45.00, 65.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2123, '2024-10-16', 282, 'App\\Models\\Sale', 100, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2124, '2024-10-16', 281, 'App\\Models\\Sale', 100, 24.00, '[\"24\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2125, '2024-10-16', 270, 'App\\Models\\Sale', 100, 120.00, '[\"120\"]', 16.00, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2126, '2024-10-16', 331, 'App\\Models\\Sale', 100, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2127, '2024-10-16', 249, 'App\\Models\\Sale', 100, 48.00, '[\"48\"]', 87.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2128, '2024-10-16', 248, 'App\\Models\\Sale', 100, 60.00, '[\"60\"]', 23.50, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2129, '2024-10-16', 393, 'App\\Models\\Sale', 100, 56.00, '[\"56\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2130, '2024-10-16', 394, 'App\\Models\\Sale', 100, 40.00, '[\"40\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2131, '2024-10-16', 395, 'App\\Models\\Sale', 100, 30.00, '[\"30\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2132, '2024-10-16', 319, 'App\\Models\\Sale', 100, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2133, '2024-10-16', 283, 'App\\Models\\Sale', 100, 30.00, '[\"30\"]', 330.00, 360.00, 440.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2134, '2024-10-16', 312, 'App\\Models\\Sale', 100, 120.00, '[\"120\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2135, '2024-10-16', 388, 'App\\Models\\Sale', 100, 24.00, '[\"24\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2136, '2024-10-16', 326, 'App\\Models\\Sale', 100, 60.00, '[\"60\"]', 120.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2137, '2024-10-16', 418, 'App\\Models\\Sale', 100, 48.00, '[\"48\"]', 98.00, 110.00, 150.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2138, '2024-10-16', 242, 'App\\Models\\Sale', 100, 40.00, '[\"40\"]', 115.00, 125.00, 150.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:21', '2024-10-16 07:43:21'),
(2139, '2024-10-16', 396, 'App\\Models\\Purchase', 101, 900.00, '[\"900\"]', 28.00, 32.00, 40.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2140, '2024-10-16', 370, 'App\\Models\\Purchase', 101, 5.00, '[\"5\"]', 800.00, 1000.00, 1700.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2141, '2024-10-16', 321, 'App\\Models\\Purchase', 101, 96.00, '[\"96\"]', 30.00, 40.00, 60.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2142, '2024-10-16', 240, 'App\\Models\\Purchase', 101, 80.00, '[\"80\"]', 20.00, 23.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2143, '2024-10-16', 313, 'App\\Models\\Purchase', 101, 65.00, '[\"65\"]', 40.00, 45.00, 65.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2144, '2024-10-16', 282, 'App\\Models\\Purchase', 101, 24.00, '[\"24\"]', 440.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2145, '2024-10-16', 281, 'App\\Models\\Purchase', 101, 24.00, '[\"24\"]', 460.00, 590.00, 720.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2146, '2024-10-16', 270, 'App\\Models\\Purchase', 101, 120.00, '[\"120\"]', 16.00, 20.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2147, '2024-10-16', 331, 'App\\Models\\Purchase', 101, 48.00, '[\"48\"]', 85.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2148, '2024-10-16', 249, 'App\\Models\\Purchase', 101, 48.00, '[\"48\"]', 87.00, 95.00, 120.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2149, '2024-10-16', 248, 'App\\Models\\Purchase', 101, 60.00, '[\"60\"]', 23.50, 25.00, 30.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2150, '2024-10-16', 393, 'App\\Models\\Purchase', 101, 56.00, '[\"56\"]', 18.50, 20.00, 25.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2151, '2024-10-16', 394, 'App\\Models\\Purchase', 101, 40.00, '[\"40\"]', 36.00, 40.00, 50.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2152, '2024-10-16', 395, 'App\\Models\\Purchase', 101, 30.00, '[\"30\"]', 75.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2153, '2024-10-16', 319, 'App\\Models\\Purchase', 101, 288.00, '[\"288\"]', 14.00, 15.50, 20.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2154, '2024-10-16', 283, 'App\\Models\\Purchase', 101, 30.00, '[\"30\"]', 330.00, 360.00, 440.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2155, '2024-10-16', 242, 'App\\Models\\Purchase', 101, 40.00, '[\"40\"]', 115.00, 125.00, 150.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2156, '2024-10-16', 312, 'App\\Models\\Purchase', 101, 120.00, '[\"120\"]', 23.00, 28.00, 40.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2157, '2024-10-16', 388, 'App\\Models\\Purchase', 101, 24.00, '[\"24\"]', 235.00, 280.00, 350.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2158, '2024-10-16', 326, 'App\\Models\\Purchase', 101, 60.00, '[\"60\"]', 120.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2159, '2024-10-16', 418, 'App\\Models\\Purchase', 101, 48.00, '[\"48\"]', 98.00, 110.00, 150.00, 0.00, 0.00, 'flat', '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(2160, '2024-10-19', 167, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 320.00, 750.00, 1100.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2161, '2024-10-19', 180, 'App\\Models\\Purchase', 102, 2.00, '[\"2\"]', 140.00, 300.00, 400.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2162, '2024-10-19', 23, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 1150.00, 1150.00, 1600.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2163, '2024-10-19', 26, 'App\\Models\\Purchase', 102, 2.00, '[\"2\"]', 4100.00, 4100.00, 4800.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2164, '2024-10-19', 29, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 2600.00, 3400.00, 4000.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2165, '2024-10-19', 114, 'App\\Models\\Purchase', 102, 10.00, '[\"10\"]', 450.00, 700.00, 950.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2166, '2024-10-19', 165, 'App\\Models\\Purchase', 102, 5000.00, '[null,\"5\",null]', 1310.00, 2100.00, 2500.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2167, '2024-10-19', 89, 'App\\Models\\Purchase', 102, 10.00, '[\"10\"]', 660.00, 850.00, 1000.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2168, '2024-10-19', 176, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 820.00, 1200.00, 1400.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2169, '2024-10-19', 144, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 200.00, 750.00, 1000.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2170, '2024-10-19', 128, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 2900.00, 4000.00, 5000.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2171, '2024-10-19', 107, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 1300.00, 2800.00, 3500.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2172, '2024-10-19', 104, 'App\\Models\\Purchase', 102, 5000.00, '[null,\"5\",null]', 130.00, 400.00, 0.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2173, '2024-10-19', 95, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 1050.00, 1300.00, 1600.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2174, '2024-10-19', 72, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 320.00, 800.00, 0.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2175, '2024-10-19', 38, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 120.00, 400.00, 600.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2176, '2024-10-19', 6, 'App\\Models\\Purchase', 102, 2.00, '[\"2\"]', 1220.00, 1750.00, 2300.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2177, '2024-10-19', 100, 'App\\Models\\Purchase', 102, 15.00, '[\"15\"]', 520.00, 800.00, 1100.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2178, '2024-10-19', 32, 'App\\Models\\Purchase', 102, 10.00, '[\"10\"]', 640.00, 800.00, 950.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2179, '2024-10-19', 110, 'App\\Models\\Purchase', 102, 25.00, '[\"25\"]', 146.00, 240.00, 350.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2180, '2024-10-19', 98, 'App\\Models\\Purchase', 102, 5.00, '[\"5\"]', 140.00, 250.00, 350.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2181, '2024-10-19', 157, 'App\\Models\\Purchase', 102, 50.00, '[\"50\"]', 72.00, 100.00, 150.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2182, '2024-10-19', 158, 'App\\Models\\Purchase', 102, 4.00, '[\"4\"]', 260.00, 400.00, 500.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2183, '2024-10-19', 2, 'App\\Models\\Purchase', 102, 10.00, '[\"10\"]', 1720.00, 1700.00, 2000.00, 0.00, 0.00, 'flat', '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(2184, '2024-10-19', 169, 'App\\Models\\Sale', 101, 56.00, '[\"56\"]', 28.58, 60.00, 85.00, 0.00, 0.00, 'flat', '2024-10-19 05:42:14', '2024-10-19 05:42:14'),
(2185, '2024-10-19', 102, 'App\\Models\\Sale', 101, 38.00, '[\"38\"]', 104.00, 160.00, 220.00, 0.00, 0.00, 'flat', '2024-10-19 05:42:14', '2024-10-19 05:42:14'),
(2186, '2024-10-19', 57, 'App\\Models\\Sale', 101, 51.00, '[\"51\"]', 172.00, 210.00, 240.00, 0.00, 0.00, 'flat', '2024-10-19 05:42:14', '2024-10-19 05:42:14'),
(2187, '2024-10-19', 56, 'App\\Models\\Sale', 101, 21.00, '[\"21\"]', 344.00, 420.00, 480.00, 0.00, 0.00, 'flat', '2024-10-19 05:42:14', '2024-10-19 05:42:14');
INSERT INTO `details` (`id`, `date`, `product_id`, `detailable_type`, `detailable_id`, `quantity`, `quantity_in_unit`, `purchase_price`, `sale_price`, `wholesale_price`, `return_price`, `discount`, `discount_type`, `created_at`, `updated_at`) VALUES
(2188, '2024-10-21', 419, 'App\\Models\\Purchase', 103, 40.00, '[\"40\"]', 31.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(2189, '2024-10-21', 263, 'App\\Models\\Purchase', 103, 24.00, '[\"24\"]', 115.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(2190, '2024-10-21', 367, 'App\\Models\\Purchase', 103, 96.00, '[\"96\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(2191, '2024-10-21', 420, 'App\\Models\\Purchase', 103, 306.00, '[\"306\"]', 11.00, 13.00, 25.00, 0.00, 0.00, 'flat', '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(2192, '2024-10-21', 419, 'App\\Models\\Sale', 102, 40.00, '[\"40\"]', 31.00, 35.00, 50.00, 0.00, 0.00, 'flat', '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(2193, '2024-10-21', 263, 'App\\Models\\Sale', 102, 24.00, '[\"24\"]', 115.00, 130.00, 170.00, 0.00, 0.00, 'flat', '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(2194, '2024-10-21', 367, 'App\\Models\\Sale', 102, 96.00, '[\"96\"]', 120.00, 135.00, 170.00, 0.00, 0.00, 'flat', '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(2195, '2024-10-21', 420, 'App\\Models\\Sale', 102, 306.00, '[\"306\"]', 11.00, 13.00, 25.00, 0.00, 0.00, 'flat', '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(2198, '2024-10-22', 284, 'App\\Models\\Sale', 103, 20.00, '[\"20\"]', 102.50, 125.00, 145.00, 0.00, 0.00, 'flat', '2024-10-22 03:08:40', '2024-10-22 03:08:40'),
(2199, '2024-10-22', 28, 'App\\Models\\Sale', 103, 20.00, '[\"20\"]', 205.00, 255.00, 295.00, 0.00, 0.00, 'flat', '2024-10-22 03:08:40', '2024-10-22 03:08:40'),
(2200, '2024-10-23', 286, 'App\\Models\\Sale', 104, 12.00, '[\"12\"]', 320.00, 400.00, 490.00, 0.00, 0.00, 'flat', '2024-10-23 03:11:27', '2024-10-23 03:11:27'),
(2201, '2024-10-23', 33, 'App\\Models\\Sale', 104, 39.00, '[\"39\"]', 64.00, 80.00, 100.00, 0.00, 0.00, 'flat', '2024-10-23 03:11:27', '2024-10-23 03:11:27'),
(2202, '2024-10-25', 198, 'App\\Models\\Purchase', 104, 1.00, '[\"1\"]', 37700.00, 42000.00, 0.00, 0.00, 0.00, 'flat', '2024-10-25 09:19:04', '2024-10-25 09:19:04'),
(2203, '2024-10-25', 198, 'App\\Models\\Sale', 105, 1.00, '[\"1\"]', 37700.00, 42000.00, 0.00, 0.00, 0.00, 'flat', '2024-10-25 09:19:30', '2024-10-25 09:19:30');

-- --------------------------------------------------------

--
-- Table structure for table `due_manages`
--

CREATE TABLE `due_manages` (
  `id` bigint UNSIGNED NOT NULL,
  `party_id` bigint UNSIGNED NOT NULL,
  `cash_id` bigint UNSIGNED DEFAULT NULL,
  `bank_account_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `check_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('supplier','customer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'positive amount in received & negetive amount is paid',
  `adjustment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `due_manages`
--

INSERT INTO `due_manages` (`id`, `party_id`, `cash_id`, `bank_account_id`, `user_id`, `check_number`, `type`, `date`, `amount`, `adjustment`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 2, NULL, NULL, 1, NULL, 'customer', '2024-04-02', 5000.00, 0.00, NULL, NULL, '2024-04-04 14:25:03', '2024-04-04 14:25:03'),
(4, 2, NULL, NULL, 1, NULL, 'customer', '2024-04-03', 5000.00, 0.00, NULL, NULL, '2024-04-04 14:49:13', '2024-04-04 14:49:13'),
(6, 3, 3, NULL, 1, NULL, 'supplier', '2024-03-31', -3410.00, 0.00, NULL, NULL, '2024-04-04 18:58:34', '2024-04-04 19:03:44'),
(7, 4, 3, NULL, 1, NULL, 'customer', '2024-04-04', 5000.00, 0.00, NULL, NULL, '2024-04-04 19:29:53', '2024-04-04 19:29:53'),
(8, 4, 3, NULL, 1, NULL, 'customer', '2024-04-06', 10000.00, 0.00, NULL, NULL, '2024-04-06 20:00:34', '2024-04-06 20:00:34'),
(9, 4, 3, NULL, 1, NULL, 'customer', '2024-04-07', 5000.00, 0.00, NULL, NULL, '2024-04-07 20:16:37', '2024-04-07 20:16:37'),
(10, 3, 3, NULL, 1, NULL, 'supplier', '2024-04-08', -15000.00, 0.00, NULL, NULL, '2024-04-08 19:12:07', '2024-04-08 19:12:07'),
(11, 4, 3, NULL, 1, NULL, 'customer', '2024-04-09', 10000.00, 0.00, NULL, NULL, '2024-04-09 20:01:43', '2024-04-09 20:01:43'),
(12, 4, 3, NULL, 1, NULL, 'customer', '2024-04-10', 10000.00, 0.00, NULL, NULL, '2024-04-10 21:53:23', '2024-04-10 21:53:23'),
(13, 4, 3, NULL, 1, NULL, 'customer', '2024-04-13', 30000.00, 0.00, NULL, NULL, '2024-04-13 18:43:44', '2024-04-13 18:43:44'),
(14, 4, 3, NULL, 1, NULL, 'customer', '2024-04-14', 20000.00, 0.00, NULL, NULL, '2024-04-14 18:32:05', '2024-04-14 18:32:05'),
(15, 4, 3, NULL, 1, NULL, 'customer', '2024-04-20', 5000.00, 0.00, NULL, NULL, '2024-04-20 20:56:06', '2024-04-20 20:56:06'),
(16, 4, 3, NULL, 1, NULL, 'customer', '2024-04-24', 5000.00, 0.00, NULL, NULL, '2024-04-24 13:27:32', '2024-04-24 13:27:32'),
(17, 4, 3, NULL, 1, NULL, 'customer', '2024-04-24', 5000.00, 0.00, NULL, NULL, '2024-04-24 21:20:07', '2024-04-24 21:20:07'),
(18, 3, 3, NULL, 1, NULL, 'supplier', '2024-04-25', -2290.00, 0.00, NULL, NULL, '2024-04-25 21:10:11', '2024-04-25 21:10:11'),
(19, 4, 3, NULL, 1, NULL, 'customer', '2024-04-27', 5725.00, 0.00, NULL, NULL, '2024-04-27 19:40:08', '2024-04-27 19:40:08'),
(20, 4, 3, NULL, 1, NULL, 'customer', '2024-04-28', 5000.00, 0.00, NULL, NULL, '2024-04-28 11:24:12', '2024-04-28 11:24:12'),
(21, 3, 3, NULL, 1, NULL, 'supplier', '2024-04-28', -15000.00, 0.00, NULL, NULL, '2024-04-28 20:16:18', '2024-04-28 20:16:18'),
(22, 4, 3, NULL, 1, NULL, 'customer', '2024-04-30', 5000.00, 0.00, NULL, NULL, '2024-04-30 18:24:04', '2024-04-30 18:24:04'),
(23, 4, 3, NULL, 1, NULL, 'customer', '2024-05-02', 5000.00, 0.00, NULL, NULL, '2024-05-02 12:04:39', '2024-05-02 12:04:39'),
(24, 4, 3, NULL, 1, NULL, 'customer', '2024-05-03', 20000.00, 0.00, NULL, NULL, '2024-05-03 19:33:48', '2024-05-03 19:33:48'),
(25, 4, 3, NULL, 1, NULL, 'customer', '2024-05-06', 3400.00, 0.00, NULL, NULL, '2024-05-06 14:10:36', '2024-05-06 14:10:36'),
(26, 7, 3, NULL, 1, NULL, 'supplier', '2024-05-06', -27550.00, 0.00, NULL, NULL, '2024-05-06 18:30:19', '2024-05-06 18:30:19'),
(27, 4, 3, NULL, 1, NULL, 'customer', '2024-05-07', 14810.00, 0.00, NULL, NULL, '2024-05-07 13:03:31', '2024-05-07 13:03:31'),
(28, 3, 3, NULL, 1, NULL, 'supplier', '2024-05-07', -15000.00, 0.00, NULL, NULL, '2024-05-07 13:04:09', '2024-05-07 13:04:09'),
(29, 4, 3, NULL, 1, NULL, 'customer', '2024-05-11', 14800.00, 0.00, NULL, NULL, '2024-05-11 18:56:58', '2024-05-11 18:56:58'),
(30, 4, 3, NULL, 1, NULL, 'customer', '2024-05-13', 10000.00, 0.00, NULL, NULL, '2024-05-13 21:50:20', '2024-05-13 21:50:20'),
(31, 4, 3, NULL, 1, NULL, 'customer', '2024-05-14', 10000.00, 0.00, NULL, NULL, '2024-05-14 20:57:52', '2024-05-14 20:57:52'),
(32, 4, 3, NULL, 1, NULL, 'customer', '2024-05-16', 10000.00, 0.00, NULL, NULL, '2024-05-16 13:16:17', '2024-05-16 13:16:17'),
(33, 3, 3, NULL, 1, NULL, 'supplier', '2024-05-16', -20000.00, 0.00, NULL, NULL, '2024-05-16 20:24:35', '2024-05-16 20:24:35'),
(34, 4, 3, NULL, 1, NULL, 'customer', '2024-05-18', 10000.00, 0.00, NULL, NULL, '2024-05-18 12:40:41', '2024-05-18 12:40:41'),
(35, 4, 3, NULL, 1, NULL, 'customer', '2024-05-20', 9050.00, 0.00, NULL, NULL, '2024-05-20 18:54:22', '2024-05-20 18:54:22'),
(36, 4, 3, NULL, 1, NULL, 'customer', '2024-05-21', 10000.00, 0.00, NULL, NULL, '2024-05-21 18:39:40', '2024-05-21 18:39:40'),
(37, 4, 3, NULL, 1, NULL, 'customer', '2024-05-22', 10000.00, 0.00, NULL, NULL, '2024-05-22 19:31:20', '2024-05-22 19:31:20'),
(38, 7, 3, NULL, 1, NULL, 'supplier', '2024-05-22', -7660.00, 0.00, NULL, NULL, '2024-05-22 19:31:59', '2024-05-22 19:31:59'),
(39, 4, 3, NULL, 1, NULL, 'customer', '2024-05-26', 20000.00, 0.00, NULL, NULL, '2024-05-26 15:59:45', '2024-05-26 15:59:45'),
(41, 4, 3, NULL, 1, NULL, 'customer', '2024-05-31', 10000.00, 0.00, NULL, NULL, '2024-06-01 00:08:47', '2024-06-01 00:08:47'),
(42, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-03', -14950.00, 0.00, NULL, NULL, '2024-06-03 18:33:46', '2024-06-03 18:33:46'),
(43, 4, 3, NULL, 1, NULL, 'customer', '2024-06-04', 10000.00, 0.00, NULL, NULL, '2024-06-04 20:51:18', '2024-06-04 20:51:18'),
(44, 4, 3, NULL, 1, NULL, 'customer', '2024-06-08', 10000.00, 0.00, NULL, NULL, '2024-06-08 19:28:32', '2024-06-08 19:28:32'),
(45, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-08', -2000.00, 0.00, NULL, NULL, '2024-06-08 20:57:50', '2024-06-08 20:57:50'),
(46, 8, 3, NULL, 1, NULL, 'supplier', '2024-06-09', -2000.00, 0.00, NULL, NULL, '2024-06-09 08:11:48', '2024-06-09 08:11:48'),
(47, 8, 3, NULL, 1, NULL, 'supplier', '2024-06-09', -7000.00, 0.00, NULL, NULL, '2024-06-09 09:40:37', '2024-06-09 09:40:37'),
(48, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-14', -7000.00, 0.00, NULL, NULL, '2024-06-14 15:56:13', '2024-06-14 15:56:13'),
(49, 7, 3, NULL, 1, NULL, 'supplier', '2024-06-14', -64600.00, 0.00, NULL, NULL, '2024-06-14 15:56:46', '2024-06-14 15:56:46'),
(50, 8, 3, NULL, 1, NULL, 'supplier', '2024-06-14', -26190.00, 0.00, NULL, NULL, '2024-06-14 15:57:32', '2024-06-14 15:57:32'),
(51, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-15', -7000.00, 0.00, NULL, NULL, '2024-06-15 14:44:41', '2024-06-15 14:44:41'),
(52, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-15', -500.00, 0.00, NULL, NULL, '2024-06-15 18:52:32', '2024-06-15 18:52:32'),
(53, 4, 3, NULL, 1, NULL, 'customer', '2024-06-16', 100000.00, 0.00, NULL, NULL, '2024-06-16 20:32:51', '2024-06-16 20:32:51'),
(54, 8, 3, NULL, 1, NULL, 'supplier', '2024-06-16', -26000.00, 0.00, NULL, NULL, '2024-06-16 20:38:35', '2024-06-16 20:38:35'),
(55, 4, 3, NULL, 1, NULL, 'customer', '2024-06-20', 20000.00, 0.00, NULL, NULL, '2024-06-20 19:19:57', '2024-06-20 19:19:57'),
(56, 8, 3, NULL, 1, NULL, 'supplier', '2024-06-22', -10000.00, 0.00, NULL, NULL, '2024-06-22 19:50:46', '2024-06-22 19:50:46'),
(57, 4, 3, NULL, 1, NULL, 'customer', '2024-06-24', 10000.00, 0.00, NULL, NULL, '2024-06-24 20:00:36', '2024-06-24 20:00:36'),
(58, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-24', -10000.00, 0.00, NULL, NULL, '2024-06-24 20:00:59', '2024-06-24 20:00:59'),
(59, 4, 3, NULL, 1, NULL, 'customer', '2024-06-25', 10000.00, 0.00, NULL, NULL, '2024-06-25 19:21:26', '2024-06-25 19:21:26'),
(60, 4, 3, NULL, 1, NULL, 'customer', '2024-06-27', 5000.00, 0.00, NULL, NULL, '2024-06-27 11:09:26', '2024-06-27 11:09:26'),
(61, 4, 3, NULL, 1, NULL, 'customer', '2024-06-27', 10000.00, 0.00, NULL, NULL, '2024-06-27 22:32:12', '2024-06-27 22:32:12'),
(62, 4, 3, NULL, 1, NULL, 'customer', '2024-06-29', 10000.00, 0.00, NULL, NULL, '2024-06-29 22:07:33', '2024-06-29 22:07:33'),
(63, 3, 3, NULL, 1, NULL, 'supplier', '2024-06-29', -15000.00, 0.00, NULL, NULL, '2024-06-29 22:09:46', '2024-06-29 22:09:46'),
(64, 4, 3, NULL, 1, NULL, 'customer', '2024-06-30', 5000.00, 0.00, NULL, NULL, '2024-06-30 21:07:42', '2024-06-30 21:07:42'),
(65, 7, 3, NULL, 1, NULL, 'supplier', '2024-06-30', -5000.00, 0.00, NULL, NULL, '2024-06-30 21:08:07', '2024-06-30 21:08:07'),
(66, 4, 3, NULL, 1, NULL, 'customer', '2024-07-02', 9000.00, 0.00, NULL, NULL, '2024-07-02 20:51:24', '2024-07-02 20:51:24'),
(67, 7, 3, NULL, 1, NULL, 'supplier', '2024-07-02', -10000.00, 0.00, NULL, NULL, '2024-07-02 20:52:34', '2024-07-02 20:52:34'),
(68, 4, 3, NULL, 1, NULL, 'customer', '2024-07-03', 6000.00, 0.00, NULL, NULL, '2024-07-03 17:01:33', '2024-07-03 17:01:33'),
(69, 7, 3, NULL, 1, NULL, 'supplier', '2024-07-03', -6555.00, 0.00, NULL, NULL, '2024-07-03 17:02:52', '2024-07-03 17:02:52'),
(70, 4, 3, NULL, 1, NULL, 'customer', '2024-07-03', 45.00, 0.00, NULL, NULL, '2024-07-03 17:06:07', '2024-07-03 17:06:07'),
(71, 7, 3, NULL, 1, NULL, 'supplier', '2024-07-03', -45.00, 0.00, NULL, NULL, '2024-07-03 17:06:23', '2024-07-03 17:06:23'),
(72, 4, 3, NULL, 1, NULL, 'customer', '2024-07-04', 10000.00, 0.00, NULL, NULL, '2024-07-04 21:42:31', '2024-07-04 21:42:31'),
(73, 3, 3, NULL, 1, NULL, 'supplier', '2024-07-09', -800.00, 0.00, NULL, NULL, '2024-07-09 20:21:51', '2024-07-09 20:21:51'),
(74, 3, 3, NULL, 1, NULL, 'supplier', '2024-07-10', -1400.00, 0.00, NULL, NULL, '2024-07-10 21:56:41', '2024-07-10 21:56:41'),
(75, 4, 3, NULL, 1, NULL, 'customer', '2024-07-10', 7800.00, 0.00, NULL, NULL, '2024-07-10 22:00:50', '2024-07-10 22:00:50'),
(76, 4, 3, NULL, 1, NULL, 'customer', '2024-07-11', 15000.00, 0.00, NULL, NULL, '2024-07-11 17:35:03', '2024-07-11 17:35:03'),
(77, 4, 3, NULL, 1, NULL, 'customer', '2024-07-14', 10000.00, 0.00, NULL, NULL, '2024-07-14 22:13:26', '2024-07-14 22:13:26'),
(78, 4, 3, NULL, 1, NULL, 'customer', '2024-07-15', 10000.00, 0.00, NULL, NULL, '2024-07-15 19:26:02', '2024-07-15 19:26:02'),
(79, 4, 3, NULL, 1, NULL, 'customer', '2024-07-18', 10000.00, 0.00, NULL, NULL, '2024-07-18 14:52:04', '2024-07-18 14:52:04'),
(80, 3, 3, NULL, 1, NULL, 'supplier', '2024-07-18', -5000.00, 0.00, NULL, NULL, '2024-07-18 14:52:34', '2024-07-18 14:52:34'),
(81, 4, 3, NULL, 1, NULL, 'customer', '2024-07-24', 10000.00, 0.00, NULL, NULL, '2024-07-24 21:13:20', '2024-07-24 21:13:20'),
(82, 4, 3, NULL, 1, NULL, 'customer', '2024-07-25', 10000.00, 0.00, NULL, NULL, '2024-07-25 22:12:32', '2024-07-25 22:12:32'),
(83, 4, 3, NULL, 1, NULL, 'customer', '2024-07-27', 30000.00, 0.00, NULL, NULL, '2024-07-27 20:29:58', '2024-07-27 20:29:58'),
(84, 8, 3, NULL, 1, NULL, 'supplier', '2024-07-28', -50000.00, 0.00, NULL, NULL, '2024-07-29 00:18:08', '2024-07-29 00:18:08'),
(85, 4, 3, NULL, 1, NULL, 'customer', '2024-07-29', 16000.00, 0.00, NULL, NULL, '2024-07-29 18:38:48', '2024-07-29 18:38:48'),
(86, 8, 3, NULL, 1, NULL, 'supplier', '2024-07-29', -16000.00, 0.00, NULL, NULL, '2024-07-29 18:39:19', '2024-07-29 18:39:19'),
(88, 9, 3, NULL, 1, NULL, 'customer', '2024-07-31', 40000.00, 0.00, NULL, NULL, '2024-07-31 19:00:10', '2024-07-31 19:00:10'),
(89, 3, 3, NULL, 1, NULL, 'supplier', '2024-07-31', -40000.00, 0.00, NULL, NULL, '2024-07-31 19:01:10', '2024-07-31 19:01:10'),
(90, 4, 3, NULL, 1, NULL, 'customer', '2024-08-04', 15000.00, 0.00, NULL, NULL, '2024-08-04 10:47:41', '2024-08-04 10:47:41'),
(91, 4, 3, NULL, 1, NULL, 'customer', '2024-08-05', 10000.00, 0.00, NULL, NULL, '2024-08-05 09:16:31', '2024-08-05 09:16:31'),
(92, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-05', -10000.00, 0.00, NULL, NULL, '2024-08-05 09:17:06', '2024-08-05 09:17:06'),
(93, 9, 3, NULL, 1, NULL, 'customer', '2024-08-06', 114040.00, 0.00, NULL, NULL, '2024-08-06 11:02:49', '2024-08-06 11:02:49'),
(94, 10, 3, NULL, 1, NULL, 'supplier', '2024-08-06', -13000.00, 0.00, NULL, NULL, '2024-08-06 11:06:46', '2024-08-06 11:06:46'),
(95, 4, 3, NULL, 1, NULL, 'customer', '2024-08-06', 10000.00, 0.00, NULL, NULL, '2024-08-06 12:46:02', '2024-08-06 12:46:02'),
(96, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-07', -20000.00, 0.00, NULL, NULL, '2024-08-07 03:20:16', '2024-08-07 03:20:16'),
(97, 4, 3, NULL, 1, NULL, 'customer', '2024-08-07', 10000.00, 0.00, NULL, NULL, '2024-08-07 11:06:42', '2024-08-07 11:06:42'),
(98, 4, 3, NULL, 1, NULL, 'customer', '2024-08-09', 20000.00, 0.00, NULL, NULL, '2024-08-09 11:52:09', '2024-08-09 11:52:09'),
(99, 4, 3, NULL, 1, NULL, 'customer', '2024-08-10', 10000.00, 0.00, NULL, NULL, '2024-08-10 09:26:50', '2024-08-10 09:26:50'),
(100, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-10', -200000.00, 0.00, NULL, NULL, '2024-08-10 09:27:49', '2024-08-10 09:27:49'),
(101, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-10', -20000.00, 0.00, NULL, NULL, '2024-08-10 09:57:15', '2024-08-10 09:57:15'),
(102, 10, 3, NULL, 1, NULL, 'supplier', '2024-08-10', -77440.00, 0.00, NULL, NULL, '2024-08-10 10:54:51', '2024-08-10 10:54:51'),
(103, 9, 3, NULL, 1, NULL, 'customer', '2024-08-15', 250000.00, 0.00, NULL, NULL, '2024-08-15 03:03:44', '2024-08-15 03:03:44'),
(104, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-15', -50000.00, 0.00, NULL, NULL, '2024-08-15 06:23:49', '2024-08-15 06:23:49'),
(105, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-15', -70000.00, 0.00, NULL, NULL, '2024-08-15 06:24:50', '2024-08-15 06:24:50'),
(106, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-17', -20000.00, 0.00, NULL, NULL, '2024-08-17 06:19:13', '2024-08-17 06:19:13'),
(107, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-18', -50000.00, 0.00, NULL, NULL, '2024-08-18 06:57:39', '2024-08-18 06:57:39'),
(108, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-19', -10000.00, 0.00, NULL, NULL, '2024-08-19 10:57:59', '2024-08-19 10:57:59'),
(109, 4, 3, NULL, 1, NULL, 'customer', '2024-08-20', 300000.00, 0.00, NULL, NULL, '2024-08-20 08:21:30', '2024-08-20 08:21:30'),
(110, 4, 3, NULL, 1, NULL, 'customer', '2024-08-21', 15000.00, 0.00, NULL, NULL, '2024-08-21 11:23:23', '2024-08-21 11:23:23'),
(111, 4, 3, NULL, 1, NULL, 'customer', '2024-08-23', 15000.00, 0.00, NULL, NULL, '2024-08-23 13:24:20', '2024-08-23 13:24:20'),
(112, 4, 3, NULL, 1, NULL, 'customer', '2024-08-24', 40000.00, 0.00, NULL, NULL, '2024-08-24 11:31:03', '2024-08-24 11:31:03'),
(113, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-24', -100000.00, 0.00, NULL, NULL, '2024-08-24 11:34:18', '2024-08-24 11:34:18'),
(114, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-25', -15000.00, 0.00, NULL, NULL, '2024-08-25 12:34:45', '2024-08-25 12:34:45'),
(115, 4, 3, NULL, 1, NULL, 'customer', '2024-08-25', 15000.00, 0.00, NULL, NULL, '2024-08-25 12:55:10', '2024-08-25 12:55:10'),
(116, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-26', -944.00, 0.00, NULL, NULL, '2024-08-26 09:01:34', '2024-08-26 09:01:34'),
(117, 4, 3, NULL, 1, NULL, 'customer', '2024-08-26', 15000.00, 0.00, NULL, NULL, '2024-08-26 10:38:00', '2024-08-26 10:38:00'),
(118, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-27', -10000.00, 0.00, NULL, NULL, '2024-08-27 11:45:14', '2024-08-27 11:45:14'),
(119, 4, 3, NULL, 1, NULL, 'customer', '2024-08-27', 70000.00, 0.00, NULL, NULL, '2024-08-27 12:44:01', '2024-08-27 12:44:01'),
(120, 9, 3, NULL, 1, NULL, 'customer', '2024-08-30', 20000.00, 0.00, NULL, NULL, '2024-08-30 07:20:10', '2024-08-30 07:20:10'),
(121, 8, 3, NULL, 1, NULL, 'supplier', '2024-08-30', -20000.00, 0.00, NULL, NULL, '2024-08-30 07:20:39', '2024-08-30 07:20:39'),
(122, 3, 3, NULL, 1, NULL, 'supplier', '2024-08-30', -10000.00, 0.00, NULL, NULL, '2024-08-30 08:46:13', '2024-08-30 08:46:13'),
(123, 4, 3, NULL, 1, NULL, 'customer', '2024-09-01', 20000.00, 0.00, NULL, NULL, '2024-09-01 09:32:57', '2024-09-01 09:32:57'),
(124, 11, 3, NULL, 1, NULL, 'supplier', '2024-09-01', -20000.00, 0.00, NULL, NULL, '2024-09-01 11:58:38', '2024-09-01 11:58:38'),
(125, 4, 3, NULL, 1, NULL, 'customer', '2024-09-03', 10000.00, 0.00, NULL, NULL, '2024-09-03 10:49:13', '2024-09-03 10:49:13'),
(126, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-05', -15000.00, 0.00, NULL, NULL, '2024-09-05 11:13:15', '2024-09-05 11:13:15'),
(127, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-07', -53620.00, 0.00, NULL, NULL, '2024-09-07 04:29:40', '2024-09-07 04:29:40'),
(128, 11, 3, NULL, 1, NULL, 'supplier', '2024-09-07', -11000.00, 0.00, NULL, NULL, '2024-09-07 06:25:14', '2024-09-07 06:25:14'),
(129, 4, 3, NULL, 1, NULL, 'customer', '2024-09-07', 15000.00, 0.00, NULL, NULL, '2024-09-07 06:28:37', '2024-09-07 06:28:37'),
(130, 3, 3, NULL, 1, NULL, 'supplier', '2024-09-07', -15000.00, 0.00, NULL, NULL, '2024-09-07 11:20:49', '2024-09-07 11:20:49'),
(131, 9, 3, NULL, 1, NULL, 'customer', '2024-09-08', 38000.00, 0.00, NULL, NULL, '2024-09-08 04:17:46', '2024-09-08 04:17:46'),
(132, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-08', -20000.00, 0.00, NULL, NULL, '2024-09-08 04:18:32', '2024-09-08 04:18:32'),
(133, 3, 3, NULL, 1, NULL, 'supplier', '2024-09-08', -5000.00, 0.00, NULL, NULL, '2024-09-08 06:58:36', '2024-09-08 06:58:36'),
(134, 9, 3, NULL, 1, NULL, 'customer', '2024-09-09', 20000.00, 0.00, NULL, NULL, '2024-09-09 09:38:30', '2024-09-09 09:38:30'),
(135, 9, 3, NULL, 1, NULL, 'customer', '2024-09-11', 5000.00, 0.00, NULL, NULL, '2024-09-11 07:39:55', '2024-09-11 07:39:55'),
(136, 10, 3, NULL, 1, NULL, 'supplier', '2024-09-12', -16236.00, 0.00, NULL, NULL, '2024-09-12 04:24:20', '2024-09-12 04:24:20'),
(137, 3, 3, NULL, 1, NULL, 'supplier', '2024-09-17', -300.00, 0.00, NULL, NULL, '2024-09-17 09:09:00', '2024-09-17 09:09:00'),
(138, 4, 3, NULL, 1, NULL, 'customer', '2024-09-18', 50000.00, 0.00, NULL, NULL, '2024-09-18 06:54:35', '2024-09-18 06:54:35'),
(139, 11, 3, NULL, 1, NULL, 'supplier', '2024-09-18', -5000.00, 0.00, NULL, NULL, '2024-09-18 11:32:21', '2024-09-18 11:32:43'),
(140, 10, 3, NULL, 1, NULL, 'supplier', '2024-09-18', -40000.00, 0.00, NULL, NULL, '2024-09-18 11:32:58', '2024-09-18 11:32:58'),
(141, 4, 3, NULL, 1, NULL, 'customer', '2024-09-19', 10000.00, 0.00, NULL, NULL, '2024-09-19 10:30:34', '2024-09-19 10:30:34'),
(142, 3, 3, NULL, 1, NULL, 'supplier', '2024-09-19', -12000.00, 0.00, NULL, NULL, '2024-09-19 10:30:56', '2024-09-19 10:30:56'),
(143, 9, 3, NULL, 1, NULL, 'customer', '2024-09-20', 10000.00, 0.00, NULL, NULL, '2024-09-20 09:11:29', '2024-09-20 09:11:29'),
(144, 4, 3, NULL, 1, NULL, 'customer', '2024-09-21', 15000.00, 0.00, NULL, NULL, '2024-09-21 10:42:00', '2024-09-21 10:42:00'),
(145, 10, 3, NULL, 1, NULL, 'supplier', '2024-09-22', -14950.00, 0.00, NULL, NULL, '2024-09-22 05:48:30', '2024-09-22 05:48:30'),
(146, 4, 3, NULL, 1, NULL, 'customer', '2024-09-22', 10000.00, 0.00, NULL, NULL, '2024-09-22 11:00:25', '2024-09-22 11:00:25'),
(147, 10, 3, NULL, 1, NULL, 'supplier', '2024-09-22', -10000.00, 0.00, NULL, NULL, '2024-09-22 11:00:42', '2024-09-22 11:00:42'),
(148, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-24', -40000.00, 0.00, NULL, NULL, '2024-09-24 08:46:08', '2024-09-24 08:46:08'),
(149, 4, 3, NULL, 1, NULL, 'customer', '2024-09-25', 10000.00, 0.00, NULL, NULL, '2024-09-25 07:50:40', '2024-09-25 07:50:40'),
(150, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-25', -80000.00, 0.00, NULL, NULL, '2024-09-25 07:53:53', '2024-09-25 07:53:53'),
(151, 4, 3, NULL, 1, NULL, 'customer', '2024-09-26', 160000.00, 0.00, NULL, NULL, '2024-09-26 09:51:54', '2024-09-26 09:51:54'),
(152, 4, 3, NULL, 1, NULL, 'customer', '2024-09-27', 20000.00, 0.00, NULL, NULL, '2024-09-27 12:24:29', '2024-09-27 12:24:29'),
(153, 3, 3, NULL, 1, NULL, 'supplier', '2024-09-28', -6000.00, 0.00, NULL, NULL, '2024-09-28 11:37:30', '2024-09-28 11:37:30'),
(154, 4, 3, NULL, 1, NULL, 'customer', '2024-09-28', 20000.00, 0.00, NULL, NULL, '2024-09-28 11:43:39', '2024-09-28 11:43:39'),
(155, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-28', -27000.00, 0.00, NULL, NULL, '2024-09-28 11:55:58', '2024-09-28 11:55:58'),
(156, 4, 3, NULL, 1, NULL, 'customer', '2024-09-30', 20000.00, 0.00, NULL, NULL, '2024-09-30 10:32:42', '2024-09-30 10:32:42'),
(157, 8, 3, NULL, 1, NULL, 'supplier', '2024-09-30', -20000.00, 0.00, NULL, NULL, '2024-09-30 10:33:04', '2024-09-30 10:33:04'),
(158, 4, 3, NULL, 1, NULL, 'customer', '2024-10-01', 20000.00, 0.00, NULL, NULL, '2024-10-01 13:02:58', '2024-10-01 13:02:58'),
(159, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-01', -13000.00, 0.00, NULL, NULL, '2024-10-01 13:03:14', '2024-10-01 13:03:14'),
(160, 4, 3, NULL, 1, NULL, 'customer', '2024-10-02', 20000.00, 0.00, NULL, NULL, '2024-10-02 11:22:01', '2024-10-02 11:22:01'),
(161, 4, 3, NULL, 1, NULL, 'customer', '2024-10-04', 20000.00, 0.00, NULL, NULL, '2024-10-05 05:19:43', '2024-10-05 05:19:43'),
(162, 4, 3, NULL, 1, NULL, 'customer', '2024-10-05', 18000.00, 0.00, NULL, NULL, '2024-10-05 12:19:13', '2024-10-05 12:19:13'),
(163, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-07', -5000.00, 0.00, NULL, NULL, '2024-10-06 18:16:38', '2024-10-06 18:17:21'),
(164, 4, 3, NULL, 1, NULL, 'customer', '2024-10-07', 20000.00, 0.00, NULL, NULL, '2024-10-07 11:51:17', '2024-10-07 11:51:17'),
(165, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-07', -10000.00, 0.00, NULL, NULL, '2024-10-07 11:58:45', '2024-10-07 11:58:45'),
(166, 4, 3, NULL, 1, NULL, 'customer', '2024-10-08', 15000.00, 0.00, NULL, NULL, '2024-10-08 12:28:21', '2024-10-08 12:28:21'),
(167, 4, 3, NULL, 1, NULL, 'customer', '2024-10-09', 15000.00, 0.00, NULL, NULL, '2024-10-09 11:21:06', '2024-10-09 11:21:24'),
(168, 8, 3, NULL, 1, NULL, 'supplier', '2024-10-10', -15000.00, 0.00, NULL, NULL, '2024-10-09 18:50:02', '2024-10-09 18:50:02'),
(169, 9, 3, NULL, 1, NULL, 'customer', '2024-10-10', 10160.00, 0.00, NULL, NULL, '2024-10-10 11:27:07', '2024-10-10 11:27:07'),
(170, 4, 3, NULL, 1, NULL, 'customer', '2024-10-10', 20000.00, 0.00, NULL, NULL, '2024-10-10 11:34:33', '2024-10-10 11:34:33'),
(171, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-10', -11000.00, 0.00, NULL, NULL, '2024-10-10 11:35:06', '2024-10-10 11:36:52'),
(172, 4, 3, NULL, 1, NULL, 'customer', '2024-10-11', 15000.00, 0.00, NULL, NULL, '2024-10-11 12:08:19', '2024-10-11 12:08:19'),
(173, 4, 3, NULL, 1, NULL, 'customer', '2024-10-12', 10000.00, 0.00, NULL, NULL, '2024-10-12 11:28:17', '2024-10-12 11:28:17'),
(174, 4, 3, NULL, 1, NULL, 'customer', '2024-10-13', 15000.00, 0.00, NULL, NULL, '2024-10-13 12:01:42', '2024-10-13 12:01:42'),
(175, 8, 3, NULL, 1, NULL, 'supplier', '2024-10-14', -50000.00, 0.00, NULL, NULL, '2024-10-14 09:49:50', '2024-10-14 09:49:50'),
(176, 4, 3, NULL, 1, NULL, 'customer', '2024-10-14', 15000.00, 0.00, NULL, NULL, '2024-10-14 11:20:48', '2024-10-14 11:20:48'),
(177, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-15', -10000.00, 0.00, NULL, NULL, '2024-10-15 03:54:01', '2024-10-15 03:54:01'),
(178, 8, 3, NULL, 1, NULL, 'supplier', '2024-10-16', -1000.00, 0.00, NULL, NULL, '2024-10-16 09:16:27', '2024-10-16 09:16:27'),
(179, 4, 3, NULL, 1, NULL, 'customer', '2024-10-17', 20000.00, 0.00, NULL, NULL, '2024-10-17 11:33:03', '2024-10-17 11:33:03'),
(180, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-17', -20000.00, 0.00, NULL, NULL, '2024-10-17 11:33:30', '2024-10-17 11:33:30'),
(181, 4, 3, NULL, 1, NULL, 'customer', '2024-10-20', 42000.00, 0.00, NULL, NULL, '2024-10-20 06:55:15', '2024-10-20 06:55:15'),
(182, 8, 3, NULL, 1, NULL, 'supplier', '2024-10-20', -42000.00, 0.00, NULL, NULL, '2024-10-20 06:55:46', '2024-10-20 06:55:46'),
(183, 4, 3, NULL, 1, NULL, 'customer', '2024-10-20', 10000.00, 0.00, NULL, NULL, '2024-10-20 11:49:12', '2024-10-20 11:49:12'),
(184, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-20', -10000.00, 0.00, NULL, NULL, '2024-10-20 11:49:41', '2024-10-20 11:49:41'),
(185, 10, 3, NULL, 1, NULL, 'supplier', '2024-10-22', -20000.00, 0.00, NULL, NULL, '2024-10-22 03:30:07', '2024-10-22 03:30:07'),
(186, 4, 3, NULL, 1, NULL, 'customer', '2024-10-22', 40000.00, 0.00, NULL, NULL, '2024-10-22 13:10:42', '2024-10-22 13:10:42'),
(187, 10, 3, NULL, 1, NULL, 'supplier', '2024-10-22', -10000.00, 0.00, NULL, NULL, '2024-10-22 13:11:35', '2024-10-22 13:11:35'),
(188, 4, 3, NULL, 1, NULL, 'customer', '2024-10-23', 10000.00, 0.00, NULL, NULL, '2024-10-23 12:52:14', '2024-10-23 12:52:14'),
(189, 4, 3, NULL, 1, NULL, 'customer', '2024-10-24', 10000.00, 0.00, NULL, NULL, '2024-10-24 12:41:18', '2024-10-24 12:41:18'),
(190, 3, 3, NULL, 1, NULL, 'supplier', '2024-10-24', -20000.00, 0.00, NULL, NULL, '2024-10-24 12:41:42', '2024-10-24 12:41:42'),
(191, 9, 3, NULL, 1, NULL, 'customer', '2024-10-26', 10000.00, 0.00, NULL, NULL, '2024-10-26 10:15:52', '2024-10-26 10:15:52'),
(192, 4, 3, NULL, 1, NULL, 'customer', '2024-10-26', 20000.00, 0.00, NULL, NULL, '2024-10-26 11:31:40', '2024-10-26 11:31:40');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `expense_category_id` bigint UNSIGNED DEFAULT NULL,
  `expense_subcategory_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `date` date NOT NULL,
  `amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_category_id`, `expense_subcategory_id`, `branch_id`, `user_id`, `date`, `amount`, `transactionable_type`, `transactionable_id`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 1, '2024-04-02', 1100.00, 'App\\Models\\Cash', 2, NULL, NULL, '2024-04-04 14:35:15', '2024-04-04 14:35:15'),
(2, 2, NULL, 1, 1, '2024-03-31', 1000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-04-04 19:01:45', '2024-04-04 19:04:29'),
(3, 1, NULL, 1, 1, '2024-04-05', 5800.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-04-05 19:27:46', '2024-04-05 19:27:46'),
(4, 3, NULL, 1, 1, '2024-04-14', 500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-04-14 11:38:36', '2024-04-14 11:38:36'),
(5, 1, NULL, 1, 1, '2024-04-20', 250.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-04-20 20:55:42', '2024-04-20 20:55:42'),
(6, 1, NULL, 1, 1, '2024-04-23', 840.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-04-23 19:42:43', '2024-04-23 19:42:43'),
(7, 4, NULL, 1, 1, '2024-04-27', 3000.00, 'App\\Models\\Cash', 3, 'Fan', NULL, '2024-04-27 14:01:44', '2024-04-27 14:01:44'),
(8, 1, NULL, 1, 1, '2024-05-02', 1500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-02 12:03:54', '2024-05-02 12:03:54'),
(9, 4, NULL, 1, 1, '2024-05-06', 500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-06 14:26:52', '2024-05-06 14:26:52'),
(10, 3, NULL, 1, 1, '2024-05-06', 660.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-06 18:29:23', '2024-05-06 18:29:23'),
(11, 1, NULL, 1, 1, '2024-05-11', 2970.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-11 18:59:19', '2024-05-11 18:59:19'),
(12, 3, NULL, 1, 1, '2024-05-11', 620.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-11 18:59:39', '2024-05-11 18:59:39'),
(13, 1, NULL, 1, 1, '2024-05-14', 5040.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-14 20:59:05', '2024-05-14 20:59:05'),
(14, 3, NULL, 1, 1, '2024-05-21', 3500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-05-21 13:27:03', '2024-05-21 13:27:03'),
(15, 1, NULL, 1, 1, '2024-06-25', 1825.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-06-25 07:15:24', '2024-06-25 07:15:24'),
(16, 1, NULL, 1, 1, '2024-06-25', 900.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-06-25 07:39:58', '2024-06-25 07:39:58'),
(17, 1, NULL, 1, 1, '2024-06-26', 2360.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-06-26 15:30:04', '2024-06-26 15:30:04'),
(18, 1, NULL, 1, 1, '2024-07-01', 20000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-07-01 18:19:53', '2024-07-01 18:19:53'),
(19, 1, NULL, 1, 1, '2024-07-14', 9250.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-07-14 21:13:32', '2024-07-14 21:13:32'),
(20, 1, NULL, 1, 1, '2024-07-29', 5500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-07-29 15:25:23', '2024-07-29 15:25:23'),
(21, 1, NULL, 1, 1, '2024-07-29', 1000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-07-29 18:51:38', '2024-07-29 18:51:38'),
(22, 3, NULL, 1, 1, '2024-08-07', 550.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-07 09:48:39', '2024-08-07 09:48:39'),
(23, 1, NULL, 1, 1, '2024-08-09', 9760.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-09 03:37:33', '2024-08-09 03:37:33'),
(24, 5, NULL, 1, 1, '2024-08-09', 620.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-09 11:59:46', '2024-08-09 11:59:46'),
(25, 5, NULL, 1, 1, '2024-08-11', 3200.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-11 10:42:35', '2024-08-11 10:42:35'),
(26, 5, NULL, 1, 1, '2024-08-14', 700.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-14 03:05:44', '2024-08-14 03:05:44'),
(27, 5, NULL, 1, 1, '2024-08-21', 8440.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-21 03:29:06', '2024-08-21 03:29:06'),
(28, 1, NULL, 1, 1, '2024-08-25', 5400.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-24 23:06:40', '2024-08-24 23:06:40'),
(29, 1, NULL, 1, 1, '2024-08-25', 4190.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-08-25 00:36:55', '2024-08-25 00:36:55'),
(30, 5, NULL, 1, 1, '2024-09-09', 500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-09 09:50:19', '2024-09-09 09:50:19'),
(31, 6, NULL, 1, 1, '2024-09-21', 12000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-21 05:21:28', '2024-09-21 05:21:28'),
(32, 1, NULL, 1, 1, '2024-09-24', 8600.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-24 08:48:11', '2024-09-24 08:48:11'),
(33, 3, NULL, 1, 1, '2024-09-24', 1150.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-24 08:49:07', '2024-09-24 08:49:07'),
(34, 1, NULL, 1, 1, '2024-09-26', 1500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-26 10:18:36', '2024-09-26 10:18:36'),
(35, 5, NULL, 1, 1, '2024-09-30', 500.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-09-30 09:33:47', '2024-09-30 09:33:47'),
(36, 4, NULL, 1, 1, '2024-10-02', 320.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-10-02 07:52:37', '2024-10-02 07:52:37'),
(37, 4, NULL, 1, 1, '2024-10-05', 3000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-10-05 12:21:30', '2024-10-05 12:21:30'),
(38, 1, NULL, 1, 1, '2024-10-17', 3000.00, 'App\\Models\\Cash', 3, NULL, NULL, '2024-10-17 12:06:49', '2024-10-17 12:06:49');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'For availability value should be true',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `parent_id`, `name`, `user_id`, `active`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, 'packaging', 1, 1, NULL, NULL, '2024-04-03 20:56:17', '2024-04-03 20:56:17'),
(2, NULL, 'stationery', 1, 1, NULL, NULL, '2024-04-03 21:55:06', '2024-04-03 21:55:06'),
(3, NULL, 'Treat', 1, 1, NULL, NULL, '2024-04-14 11:37:57', '2024-04-14 11:37:57'),
(4, NULL, 'homesware', 1, 1, NULL, NULL, '2024-04-27 14:00:51', '2024-04-27 14:00:51'),
(5, NULL, 'Transport', 1, 1, NULL, NULL, '2024-08-09 11:59:21', '2024-08-09 11:59:21'),
(6, NULL, 'House Rent', 1, 1, NULL, NULL, '2024-09-21 05:20:54', '2024-09-21 05:20:54');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_records`
--

CREATE TABLE `income_records` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `branch_id` bigint UNSIGNED NOT NULL,
  `income_sector_id` bigint UNSIGNED NOT NULL,
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `income_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'who collect the income',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `income_records`
--

INSERT INTO `income_records` (`id`, `user_id`, `branch_id`, `income_sector_id`, `transactionable_type`, `transactionable_id`, `date`, `amount`, `income_by`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(8, 1, 1, 2, 'App\\Models\\Cash', 3, '2024-06-16', 26000.00, NULL, NULL, NULL, '2024-06-16 20:39:54', '2024-06-16 20:39:54');

-- --------------------------------------------------------

--
-- Table structure for table `income_sectors`
--

CREATE TABLE `income_sectors` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `income_sectors`
--

INSERT INTO `income_sectors` (`id`, `user_id`, `name`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Investment', NULL, NULL, '2024-04-04 14:20:56', '2024-04-04 14:20:56'),
(2, 1, 'Adjestment', NULL, NULL, '2024-06-16 20:39:30', '2024-06-16 20:39:30');

-- --------------------------------------------------------

--
-- Table structure for table `investors`
--

CREATE TABLE `investors` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `address` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `investors`
--

INSERT INTO `investors` (`id`, `user_id`, `name`, `phone`, `balance`, `address`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Torik-Nayem', '01795290732', 46300.00, 'n/a', 'n/a', NULL, '2024-04-28 10:21:17', '2024-05-22 12:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `invests`
--

CREATE TABLE `invests` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `branch_id` bigint UNSIGNED DEFAULT '1',
  `profit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `profit_type` enum('flat','percentage') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat',
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `investor_id` bigint UNSIGNED NOT NULL,
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `status` enum('open','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `isAutomatic` tinyint(1) NOT NULL DEFAULT '0',
  `profit_addition_date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invests`
--

INSERT INTO `invests` (`id`, `date`, `amount`, `branch_id`, `profit`, `profit_type`, `user_id`, `investor_id`, `transactionable_type`, `transactionable_id`, `status`, `isAutomatic`, `profit_addition_date`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-04-04', 46700.00, 1, 400.00, 'flat', 1, 1, 'App\\Models\\Cash', 3, 'open', 1, '2024-05-22', 'n/a', NULL, '2024-04-28 10:24:02', '2024-05-23 11:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `invest_withdraws`
--

CREATE TABLE `invest_withdraws` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `invest_id` bigint UNSIGNED NOT NULL,
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `branch_id` bigint UNSIGNED DEFAULT '1',
  `type` enum('profit_withdraw','profit_addition','invest_withdraw') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'profit_withdraw',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invest_withdraws`
--

INSERT INTO `invest_withdraws` (`id`, `user_id`, `invest_id`, `transactionable_type`, `transactionable_id`, `date`, `amount`, `branch_id`, `type`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 1, 1, 'App\\Models\\Cash', 3, '2024-05-22', 400.00, 1, 'profit_addition', NULL, NULL, '2024-05-23 11:55:03', '2024-05-23 11:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `loan_account_id` bigint UNSIGNED NOT NULL,
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `profit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `profit_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat',
  `expired_date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `user_id`, `loan_account_id`, `transactionable_type`, `transactionable_id`, `date`, `amount`, `profit`, `profit_type`, `expired_date`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 1, 2, 'App\\Models\\Cash', 3, '2024-06-14', 93790.00, 0.00, 'flat', '2024-06-30', NULL, NULL, '2024-06-14 15:52:08', '2024-06-15 18:52:00'),
(4, 1, 3, 'App\\Models\\Cash', 3, '2024-06-14', 15000.00, 0.00, 'flat', '2024-06-30', NULL, NULL, '2024-06-14 15:55:21', '2024-06-14 15:55:21'),
(6, 1, 2, 'App\\Models\\Cash', 3, '2024-07-01', 20000.00, 0.00, 'flat', '2026-02-02', NULL, NULL, '2024-07-01 18:18:56', '2024-07-01 18:18:56'),
(7, 1, 2, 'App\\Models\\Cash', 3, '2024-08-20', 150000.00, 0.00, 'flat', '2025-03-01', NULL, NULL, '2024-08-20 08:22:23', '2024-09-05 11:12:30'),
(8, 1, 4, 'App\\Models\\Cash', 3, '2024-08-24', 100000.00, 0.00, 'flat', '2025-06-30', NULL, NULL, '2024-08-24 11:32:53', '2024-08-24 11:32:53'),
(9, 1, 3, 'App\\Models\\Cash', 3, '2024-09-24', 40000.00, 0.00, 'flat', '2024-09-24', NULL, NULL, '2024-09-24 08:43:55', '2024-09-24 08:43:55'),
(11, 1, 2, 'App\\Models\\Cash', 3, '2024-09-24', 30000.00, 0.00, 'flat', '2024-09-24', NULL, NULL, '2024-09-24 08:44:28', '2024-09-25 07:53:29'),
(12, 1, 5, 'App\\Models\\Cash', 3, '2024-09-25', 50000.00, 0.00, 'flat', '2025-05-25', NULL, NULL, '2024-09-25 07:53:12', '2024-09-25 07:53:12'),
(13, 1, 1, 'App\\Models\\Cash', 3, '2024-10-21', 13000.00, 0.00, 'flat', '2024-10-21', NULL, NULL, '2024-10-21 02:27:09', '2024-10-22 03:29:34');

-- --------------------------------------------------------

--
-- Table structure for table `loan_accounts`
--

CREATE TABLE `loan_accounts` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_accounts`
--

INSERT INTO `loan_accounts` (`id`, `user_id`, `name`, `phone`, `address`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Rahat Waheed', '01795290732', NULL, NULL, NULL, '2024-04-04 14:15:58', '2024-04-04 14:15:58'),
(2, 1, 'MD Sir', '01710153118', NULL, NULL, NULL, '2024-06-14 15:51:06', '2024-06-14 15:51:06'),
(3, 1, 'Didarul Islam', '01742021463', NULL, NULL, NULL, '2024-06-14 15:54:39', '2024-06-14 15:54:39'),
(4, 1, 'Chairman Sir', '01753326721', NULL, NULL, NULL, '2024-08-24 11:32:10', '2024-08-24 11:32:10'),
(5, 1, 'Saiful Islam (GM of Almak group)', '01712418085', NULL, NULL, NULL, '2024-09-25 07:52:03', '2024-09-25 07:52:03');

-- --------------------------------------------------------

--
-- Table structure for table `loan_installments`
--

CREATE TABLE `loan_installments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `loan_id` bigint UNSIGNED NOT NULL,
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `adjustment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_installments`
--

INSERT INTO `loan_installments` (`id`, `user_id`, `loan_id`, `transactionable_type`, `transactionable_id`, `date`, `amount`, `adjustment`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 'App\\Models\\Cash', 3, '2024-06-16', -15000.00, 0.00, NULL, NULL, '2024-06-16 20:42:39', '2024-06-16 20:42:39'),
(2, 1, 3, 'App\\Models\\Cash', 3, '2024-06-16', -50000.00, 0.00, NULL, NULL, '2024-06-16 20:45:22', '2024-06-16 20:45:22'),
(3, 1, 6, 'App\\Models\\Cash', 3, '2024-08-17', -20000.00, 0.00, NULL, NULL, '2024-08-17 07:25:44', '2024-08-17 07:25:44'),
(4, 1, 3, 'App\\Models\\Cash', 3, '2024-08-17', -43790.00, 0.00, NULL, NULL, '2024-08-17 07:26:16', '2024-08-17 07:26:16'),
(5, 1, 8, 'App\\Models\\Cash', 3, '2024-08-26', -30000.00, 0.00, NULL, NULL, '2024-08-26 10:41:09', '2024-08-26 10:41:09'),
(6, 1, 8, 'App\\Models\\Cash', 3, '2024-08-27', -70000.00, 0.00, NULL, NULL, '2024-08-27 12:44:28', '2024-08-27 12:44:28'),
(7, 1, 7, 'App\\Models\\Cash', 3, '2024-09-09', -20000.00, 0.00, NULL, NULL, '2024-09-09 09:38:59', '2024-09-09 09:38:59'),
(8, 1, 11, 'App\\Models\\Cash', 3, '2024-09-26', -30000.00, 0.00, NULL, NULL, '2024-09-26 09:52:28', '2024-09-26 09:52:28'),
(9, 1, 7, 'App\\Models\\Cash', 3, '2024-09-26', -130000.00, 0.00, NULL, NULL, '2024-09-26 09:53:16', '2024-09-26 09:53:16'),
(10, 1, 9, 'App\\Models\\Cash', 3, '2024-10-04', -40000.00, 0.00, NULL, NULL, '2024-10-04 11:41:25', '2024-10-04 11:41:25'),
(11, 1, 12, 'App\\Models\\Cash', 3, '2024-10-14', -20000.00, 0.00, NULL, NULL, '2024-10-13 22:31:39', '2024-10-13 22:31:39'),
(12, 1, 12, 'App\\Models\\Cash', 3, '2024-10-22', -30000.00, 0.00, NULL, NULL, '2024-10-22 13:12:08', '2024-10-22 13:12:08'),
(13, 1, 13, 'App\\Models\\Cash', 3, '2024-10-26', -10000.00, 0.00, NULL, NULL, '2024-10-26 10:28:23', '2024-10-26 10:28:23');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2013_10_11_105818_create_branches_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_10_09_090600_create_permission_tables', 1),
(7, '2023_10_10_093535_create_units_table', 1),
(8, '2023_10_12_061425_create_cashes_table', 1),
(9, '2023_10_12_091509_create_brands_table', 1),
(10, '2023_10_12_105834_create_categories_table', 1),
(11, '2023_10_17_042039_create_products_table', 1),
(12, '2023_10_17_042336_create_parties_table', 1),
(13, '2023_10_17_042408_create_banks_table', 1),
(14, '2023_10_17_042443_create_bank_accounts_table', 1),
(15, '2023_10_17_043406_create_due_manages_table', 1),
(16, '2023_10_17_043501_create_stocks_table', 1),
(17, '2023_10_17_043507_create_purchases_table', 1),
(18, '2023_10_17_043510_create_purchase_costs_table', 1),
(19, '2023_10_17_043513_create_purchase_returns_table', 1),
(20, '2023_10_17_043601_create_sales_table', 1),
(21, '2023_10_17_043608_create_sale_returns_table', 1),
(22, '2023_10_17_043729_create_damages_table', 1),
(23, '2023_10_17_043838_create_details_table', 1),
(24, '2023_11_01_091642_create_payments_table', 1),
(25, '2023_11_27_055022_create_productions_table', 1),
(26, '2023_11_27_055028_create_production_details_table', 1),
(27, '2023_12_03_113632_create_product_transfers_table', 1),
(28, '2023_12_03_113639_create_product_transfer_details_table', 1),
(29, '2023_12_12_122949_create_expense_categories_table', 1),
(30, '2023_12_13_070818_create_expenses_table', 1),
(31, '2023_12_18_042309_create_transactions_table', 1),
(32, '2023_12_19_051429_create_salaries_table', 1),
(33, '2023_12_19_051445_create_salary_details_table', 1),
(34, '2023_12_19_071737_create_advanced_salaries_table', 1),
(35, '2023_12_21_060956_create_loan_accounts_table', 1),
(36, '2023_12_21_062208_create_loans_table', 1),
(37, '2023_12_21_062232_create_loan_installments_table', 1),
(38, '2023_12_28_050624_create_closing_balances_table', 1),
(39, '2024_01_14_091848_create_income_sectors_table', 1),
(40, '2024_01_14_091856_create_income_records_table', 1),
(41, '2024_04_15_050628_create_withdraws_table', 2),
(42, '2024_04_16_110217_add_columns_to_loans_table', 3),
(43, '2024_04_17_081523_create_investors_table', 3),
(44, '2024_04_17_100546_create_invests_table', 3),
(45, '2024_04_18_115342_create_invest_withdraws_table', 3),
(46, '2024_04_29_111026_add_branch_id_to_invests_table', 4),
(47, '2024_04_30_042806_add_branch_id_to_invest_withdraws_table', 5),
(48, '2024_05_12_045219_create_sms_templates_table', 6),
(49, '2024_05_13_051851_create_sms_table', 6),
(50, '2024_05_23_034809_add_is_automatic_and_profit_addition_date_to_invests_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(4, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 3),
(5, 'App\\Models\\User', 3),
(1, 'App\\Models\\User', 4),
(6, 'App\\Models\\User', 4),
(1, 'App\\Models\\User', 5);

-- --------------------------------------------------------

--
-- Table structure for table `parties`
--

CREATE TABLE `parties` (
  `id` bigint UNSIGNED NOT NULL,
  `genus` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'positive(+) balance means receivable and negative(-) is payable',
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parties`
--

INSERT INTO `parties` (`id`, `genus`, `name`, `company_name`, `phone`, `email`, `address`, `balance`, `user_id`, `active`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 'customer', 'Family Shop', NULL, '01710153118', NULL, NULL, -5035.00, 1, 1, NULL, '2024-04-04 18:33:14', '2024-04-04 14:13:40', '2024-04-04 18:33:14'),
(3, 'supplier', 'Munir vai', 'Munir vai', '01961667871', NULL, NULL, -82688.52, 1, 1, NULL, NULL, '2024-04-04 18:52:41', '2024-10-24 12:41:42'),
(4, 'customer', 'Family Shop', NULL, '01710153118', NULL, NULL, 866833.00, 1, 1, NULL, NULL, '2024-04-04 18:53:04', '2024-10-26 11:31:40'),
(5, 'supplier', 'Prodip Kumar Ghosh', 'Messrs Sudhir Chandra Ghosh', '01711687539', NULL, NULL, 0.00, 1, 1, NULL, NULL, '2024-04-15 16:40:56', '2024-08-25 12:33:29'),
(6, 'supplier', 'Lokkhi Narayana', 'Lokkhi Narayana Store', '01711619312', NULL, NULL, 0.00, 1, 1, NULL, NULL, '2024-04-15 17:29:26', '2024-04-20 21:01:34'),
(7, 'supplier', 'shahid khan', 'Khejur wala', '01676174668', NULL, NULL, 0.00, 1, 1, NULL, NULL, '2024-05-02 11:39:01', '2024-07-16 14:22:06'),
(8, 'supplier', 'Rafi vai', 'RV', '8801775591404', NULL, NULL, -379185.00, 1, 1, NULL, NULL, '2024-06-07 16:58:40', '2024-10-21 01:57:30'),
(9, 'customer', 'City Bazar', NULL, '1882112319', NULL, NULL, 13837.00, 1, 1, NULL, NULL, '2024-07-31 18:57:22', '2024-10-26 10:15:52'),
(10, 'supplier', 'Didarul Islam', 'Didarul Islam', '01742021463', NULL, NULL, -53900.00, 1, 1, NULL, NULL, '2024-08-04 02:42:24', '2024-10-25 09:19:04'),
(11, 'supplier', 'Rahat', 'Rahat', '01795290732', NULL, NULL, -100.00, 1, 1, NULL, NULL, '2024-08-21 03:11:26', '2024-09-30 07:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `paymentable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paymentable_id` bigint UNSIGNED NOT NULL,
  `cash_id` bigint UNSIGNED DEFAULT NULL,
  `bank_account_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `is_first_payment` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `paymentable_type`, `paymentable_id`, `cash_id`, `bank_account_id`, `user_id`, `date`, `amount`, `is_first_payment`, `created_at`, `updated_at`) VALUES
(6, 'App\\Models\\Purchase', 4, 3, NULL, 1, '2024-03-31', 20000.00, 1, '2024-04-04 18:55:48', '2024-04-04 19:03:18'),
(7, 'App\\Models\\Sale', 3, 3, NULL, 1, '2024-03-31', 4410.00, 1, '2024-04-04 18:58:02', '2024-04-04 19:02:53'),
(8, 'App\\Models\\Purchase', 5, 3, NULL, 1, '2024-04-04', 2500.00, 1, '2024-04-04 19:19:12', '2024-04-04 19:19:12'),
(9, 'App\\Models\\Sale', 4, 3, NULL, 1, '2024-04-04', 5000.00, 1, '2024-04-04 19:20:38', '2024-04-04 19:20:38'),
(10, 'App\\Models\\Purchase', 6, 3, NULL, 1, '2024-04-04', 5500.00, 1, '2024-04-04 19:23:27', '2024-04-04 19:23:27'),
(11, 'App\\Models\\Sale', 5, 3, NULL, 1, '2024-04-04', 5000.00, 1, '2024-04-04 19:25:25', '2024-04-04 19:29:18'),
(12, 'App\\Models\\Purchase', 7, 3, NULL, 1, '2024-04-04', 20000.00, 1, '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(13, 'App\\Models\\Sale', 6, 3, NULL, 1, '2024-04-04', 0.00, 1, '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(14, 'App\\Models\\Purchase', 8, 3, NULL, 1, '2024-04-05', 0.00, 1, '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(15, 'App\\Models\\Sale', 8, 3, NULL, 1, '2024-04-05', 0.00, 1, '2024-04-05 19:21:31', '2024-04-05 19:53:09'),
(17, 'App\\Models\\Purchase', 10, 3, NULL, 1, '2024-04-16', 360.00, 1, '2024-04-16 12:02:15', '2024-04-16 12:02:15'),
(18, 'App\\Models\\Purchase', 11, 3, NULL, 1, '2024-04-16', 18530.00, 1, '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(19, 'App\\Models\\Purchase', 12, 3, NULL, 1, '2024-04-16', 0.00, 1, '2024-04-16 12:21:43', '2024-04-16 12:25:14'),
(20, 'App\\Models\\Sale', 9, 3, NULL, 1, '2024-04-16', 0.00, 1, '2024-04-16 12:26:11', '2024-04-16 12:26:11'),
(21, 'App\\Models\\Sale', 10, 3, NULL, 1, '2024-04-17', 5000.00, 1, '2024-04-17 12:14:09', '2024-04-18 19:56:51'),
(22, 'App\\Models\\Purchase', 13, 3, NULL, 1, '2024-04-20', 2800.00, 1, '2024-04-20 20:55:07', '2024-04-20 21:01:34'),
(23, 'App\\Models\\Sale', 11, 3, NULL, 1, '2024-04-21', 0.00, 1, '2024-04-21 19:43:17', '2024-04-21 19:43:17'),
(24, 'App\\Models\\Sale', 12, 3, NULL, 1, '2024-04-23', 0.00, 1, '2024-04-23 11:47:14', '2024-04-23 11:49:01'),
(25, 'App\\Models\\Sale', 13, 3, NULL, 1, '2024-04-23', 0.00, 1, '2024-04-23 11:52:00', '2024-04-23 11:52:00'),
(26, 'App\\Models\\Sale', 14, 3, NULL, 1, '2024-04-23', 0.00, 1, '2024-04-23 17:34:41', '2024-04-23 17:34:41'),
(27, 'App\\Models\\Purchase', 14, 3, NULL, 1, '2024-04-23', 9160.00, 1, '2024-04-23 19:41:44', '2024-04-23 19:45:55'),
(28, 'App\\Models\\Purchase', 15, 3, NULL, 1, '2024-04-25', 0.00, 1, '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(29, 'App\\Models\\Purchase', 16, 3, NULL, 1, '2024-04-25', 0.00, 1, '2024-04-25 20:22:08', '2024-04-25 20:22:08'),
(30, 'App\\Models\\Sale', 15, 3, NULL, 1, '2024-04-25', 0.00, 1, '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(31, 'App\\Models\\Sale', 16, 3, NULL, 1, '2024-04-25', 0.00, 1, '2024-04-25 21:13:17', '2024-04-25 21:13:17'),
(32, 'App\\Models\\Purchase', 17, 3, NULL, 1, '2024-04-29', 25000.00, 1, '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(34, 'App\\Models\\Purchase', 18, 3, NULL, 1, '2024-05-02', 29020.00, 1, '2024-05-02 11:51:58', '2024-05-02 12:03:33'),
(35, 'App\\Models\\Sale', 28, 3, NULL, 1, '2024-05-02', 0.00, 1, '2024-05-02 13:38:53', '2024-05-06 19:48:31'),
(36, 'App\\Models\\Sale', 29, 3, NULL, 1, '2024-05-02', 0.00, 1, '2024-05-02 13:43:53', '2024-05-02 13:43:53'),
(37, 'App\\Models\\Purchase', 19, 3, NULL, 1, '2024-05-03', 0.00, 1, '2024-05-03 16:49:28', '2024-05-03 16:49:28'),
(38, 'App\\Models\\Sale', 30, 3, NULL, 1, '2024-05-03', 0.00, 1, '2024-05-03 16:50:29', '2024-05-03 18:59:27'),
(39, 'App\\Models\\Purchase', 20, 3, NULL, 1, '2024-05-04', 0.00, 1, '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(40, 'App\\Models\\Sale', 31, 3, NULL, 1, '2024-05-04', 0.00, 1, '2024-05-04 14:32:59', '2024-05-04 14:32:59'),
(41, 'App\\Models\\Sale', 32, 3, NULL, 1, '2024-05-04', 0.00, 1, '2024-05-04 14:38:10', '2024-05-04 14:38:10'),
(42, 'App\\Models\\Purchase', 21, 3, NULL, 1, '2024-05-05', 0.00, 1, '2024-05-05 19:57:17', '2024-05-06 13:55:40'),
(43, 'App\\Models\\Sale', 33, 3, NULL, 1, '2024-05-06', 0.00, 1, '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(44, 'App\\Models\\Purchase', 22, 3, NULL, 1, '2024-05-08', 10335.00, 1, '2024-05-08 21:10:35', '2024-05-08 21:10:35'),
(45, 'App\\Models\\Sale', 34, 3, NULL, 1, '2024-05-08', 10000.00, 1, '2024-05-08 21:15:47', '2024-05-08 21:15:47'),
(46, 'App\\Models\\Sale', 35, 3, NULL, 1, '2024-05-17', 0.00, 1, '2024-05-17 18:02:47', '2024-05-17 18:04:31'),
(47, 'App\\Models\\Purchase', 23, 3, NULL, 1, '2024-05-18', 18750.00, 1, '2024-05-18 14:12:42', '2024-05-18 14:12:42'),
(48, 'App\\Models\\Sale', 36, 3, NULL, 1, '2024-05-18', 0.00, 1, '2024-05-18 14:20:55', '2024-05-18 14:20:55'),
(49, 'App\\Models\\Purchase', 24, 3, NULL, 1, '2024-05-22', 0.00, 1, '2024-05-22 08:37:23', '2024-05-22 08:37:23'),
(50, 'App\\Models\\Sale', 37, 3, NULL, 1, '2024-05-22', 0.00, 1, '2024-05-22 08:38:31', '2024-05-22 08:38:31'),
(51, 'App\\Models\\Purchase', 25, 3, NULL, 1, '2024-05-26', 1250.00, 1, '2024-05-26 16:01:58', '2024-05-26 16:16:50'),
(52, 'App\\Models\\Purchase', 26, 3, NULL, 1, '2024-05-26', 20000.00, 1, '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(53, 'App\\Models\\Sale', 38, 3, NULL, 1, '2024-05-26', 0.00, 1, '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(54, 'App\\Models\\Purchase', 27, 3, NULL, 1, '2024-05-28', 2080.00, 1, '2024-05-28 19:34:23', '2024-05-28 19:34:23'),
(55, 'App\\Models\\Sale', 39, 3, NULL, 1, '2024-05-28', 0.00, 1, '2024-05-28 19:35:21', '2024-05-28 19:35:21'),
(56, 'App\\Models\\Purchase', 28, 3, NULL, 1, '2024-06-01', 3420.00, 1, '2024-06-01 20:10:17', '2024-06-01 20:10:17'),
(57, 'App\\Models\\Sale', 40, 3, NULL, 1, '2024-06-01', 10000.00, 1, '2024-06-01 20:12:32', '2024-06-01 20:12:32'),
(58, 'App\\Models\\Purchase', 29, 3, NULL, 1, '2024-06-04', 10000.00, 1, '2024-06-04 20:55:05', '2024-06-04 20:55:05'),
(59, 'App\\Models\\Purchase', 30, 3, NULL, 1, '2024-06-05', 0.00, 1, '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(60, 'App\\Models\\Purchase', 31, 3, NULL, 1, '2024-06-06', 0.00, 1, '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(61, 'App\\Models\\Sale', 41, 3, NULL, 1, '2024-06-06', 0.00, 1, '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(62, 'App\\Models\\Purchase', 32, 3, NULL, 1, '2024-06-07', 0.00, 1, '2024-06-07 17:04:16', '2024-06-07 17:04:16'),
(63, 'App\\Models\\Sale', 42, 3, NULL, 1, '2024-06-07', 0.00, 1, '2024-06-07 17:05:12', '2024-06-07 17:05:12'),
(64, 'App\\Models\\Purchase', 33, 3, NULL, 1, '2024-06-08', 0.00, 1, '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(65, 'App\\Models\\Sale', 43, 3, NULL, 1, '2024-06-08', 0.00, 1, '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(66, 'App\\Models\\Purchase', 34, 3, NULL, 1, '2024-06-08', 0.00, 1, '2024-06-08 21:07:07', '2024-06-08 21:07:40'),
(67, 'App\\Models\\Sale', 44, 3, NULL, 1, '2024-06-08', 0.00, 1, '2024-06-08 21:09:48', '2024-06-08 21:09:48'),
(68, 'App\\Models\\Purchase', 35, 3, NULL, 1, '2024-06-09', 0.00, 1, '2024-06-09 16:14:19', '2024-06-09 16:28:32'),
(69, 'App\\Models\\Purchase', 36, 3, NULL, 1, '2024-06-09', 0.00, 1, '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(70, 'App\\Models\\Sale', 45, 3, NULL, 1, '2024-06-09', 0.00, 1, '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(71, 'App\\Models\\Purchase', 37, 3, NULL, 1, '2024-06-09', 0.00, 1, '2024-06-09 16:47:22', '2024-06-09 16:47:22'),
(72, 'App\\Models\\Purchase', 38, 3, NULL, 1, '2024-06-10', 0.00, 1, '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(73, 'App\\Models\\Sale', 46, 3, NULL, 1, '2024-06-10', 0.00, 1, '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(74, 'App\\Models\\Sale', 47, 3, NULL, 1, '2024-06-11', 0.00, 1, '2024-06-11 21:55:48', '2024-06-11 21:55:48'),
(75, 'App\\Models\\Purchase', 39, 3, NULL, 1, '2024-06-13', 0.00, 1, '2024-06-13 17:47:37', '2024-06-13 17:50:17'),
(76, 'App\\Models\\Sale', 48, 3, NULL, 1, '2024-06-13', 0.00, 1, '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(77, 'App\\Models\\Purchase', 40, 3, NULL, 1, '2024-06-13', 0.00, 1, '2024-06-13 19:01:11', '2024-06-13 19:01:11'),
(78, 'App\\Models\\Purchase', 41, 3, NULL, 1, '2024-06-14', 0.00, 1, '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(79, 'App\\Models\\Sale', 49, 3, NULL, 1, '2024-06-14', 0.00, 1, '2024-06-14 13:51:59', '2024-06-14 13:51:59'),
(80, 'App\\Models\\Purchase', 42, 3, NULL, 1, '2024-06-14', 0.00, 1, '2024-06-14 15:16:29', '2024-06-14 20:23:58'),
(81, 'App\\Models\\Sale', 50, 3, NULL, 1, '2024-06-14', 0.00, 1, '2024-06-14 15:17:27', '2024-06-14 20:25:03'),
(82, 'App\\Models\\Purchase', 43, 3, NULL, 1, '2024-06-15', 0.00, 1, '2024-06-15 23:17:50', '2024-06-15 23:17:50'),
(83, 'App\\Models\\Sale', 51, 3, NULL, 1, '2024-06-15', 0.00, 1, '2024-06-15 23:18:34', '2024-06-15 23:18:34'),
(84, 'App\\Models\\Purchase', 44, 3, NULL, 1, '2024-06-24', 0.00, 1, '2024-06-24 20:18:47', '2024-06-24 20:22:37'),
(85, 'App\\Models\\Purchase', 45, 3, NULL, 1, '2024-06-25', 14610.00, 1, '2024-06-25 18:38:37', '2024-06-25 18:38:37'),
(86, 'App\\Models\\Sale', 52, 3, NULL, 1, '2024-06-25', 0.00, 1, '2024-06-25 18:46:15', '2024-06-25 18:46:15'),
(87, 'App\\Models\\Purchase', 46, 3, NULL, 1, '2024-06-25', 10000.00, 1, '2024-06-25 21:45:55', '2024-06-25 21:50:18'),
(88, 'App\\Models\\Purchase', 47, 3, NULL, 1, '2024-06-26', 0.00, 1, '2024-06-26 14:28:35', '2024-06-26 14:28:35'),
(89, 'App\\Models\\Sale', 53, 3, NULL, 1, '2024-06-26', 0.00, 1, '2024-06-26 14:29:24', '2024-06-26 14:29:24'),
(90, 'App\\Models\\Purchase', 48, 3, NULL, 1, '2024-06-27', 0.00, 1, '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(91, 'App\\Models\\Sale', 54, 3, NULL, 1, '2024-06-27', 0.00, 1, '2024-06-27 21:00:09', '2024-06-27 21:00:09'),
(92, 'App\\Models\\Purchase', 49, 3, NULL, 1, '2024-06-30', 10000.00, 1, '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(93, 'App\\Models\\Sale', 55, 3, NULL, 1, '2024-06-30', 0.00, 1, '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(94, 'App\\Models\\Purchase', 50, 3, NULL, 1, '2024-07-04', 0.00, 1, '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(95, 'App\\Models\\Sale', 56, 3, NULL, 1, '2024-07-04', 0.00, 1, '2024-07-04 16:15:17', '2024-07-06 19:43:52'),
(96, 'App\\Models\\Purchase', 51, 3, NULL, 1, '2024-07-11', 9900.00, 1, '2024-07-11 20:34:16', '2024-07-11 20:44:53'),
(97, 'App\\Models\\Sale', 57, 3, NULL, 1, '2024-07-11', 0.00, 1, '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(98, 'App\\Models\\Purchase', 52, 3, NULL, 1, '2024-07-11', 0.00, 1, '2024-07-11 20:57:37', '2024-07-11 20:57:37'),
(99, 'App\\Models\\Sale', 58, 3, NULL, 1, '2024-07-11', 0.00, 1, '2024-07-11 20:58:27', '2024-07-11 20:58:27'),
(100, 'App\\Models\\Purchase', 53, 3, NULL, 1, '2024-07-16', 23500.00, 1, '2024-07-16 14:22:06', '2024-07-16 14:22:06'),
(101, 'App\\Models\\Sale', 59, 3, NULL, 1, '2024-07-16', 0.00, 1, '2024-07-16 14:22:51', '2024-07-16 14:22:51'),
(102, 'App\\Models\\Purchase', 54, 3, NULL, 1, '2024-07-24', 0.00, 1, '2024-07-24 15:03:27', '2024-07-24 15:11:38'),
(103, 'App\\Models\\Sale', 60, 3, NULL, 1, '2024-07-24', 0.00, 1, '2024-07-24 15:15:11', '2024-07-24 15:15:11'),
(104, 'App\\Models\\Purchase', 55, 3, NULL, 1, '2024-07-30', 0.00, 1, '2024-07-31 00:27:17', '2024-07-31 00:27:17'),
(105, 'App\\Models\\Sale', 61, 3, NULL, 1, '2024-07-30', 0.00, 1, '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(106, 'App\\Models\\Purchase', 56, 3, NULL, 1, '2024-07-31', 0.00, 1, '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(107, 'App\\Models\\Sale', 62, 3, NULL, 1, '2024-07-31', 0.00, 1, '2024-07-31 21:29:09', '2024-07-31 21:29:09'),
(108, 'App\\Models\\Purchase', 57, 3, NULL, 1, '2024-08-02', 0.00, 1, '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(109, 'App\\Models\\Purchase', 58, 3, NULL, 1, '2024-08-04', 0.00, 1, '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(110, 'App\\Models\\Purchase', 59, 3, NULL, 1, '2024-08-04', 0.00, 1, '2024-08-04 02:46:37', '2024-08-04 02:46:37'),
(111, 'App\\Models\\Sale', 63, 3, NULL, 1, '2024-08-04', 0.00, 1, '2024-08-04 04:22:04', '2024-08-04 04:24:26'),
(112, 'App\\Models\\Purchase', 60, 3, NULL, 1, '2024-08-04', 0.00, 1, '2024-08-04 04:32:41', '2024-08-04 04:35:14'),
(114, 'App\\Models\\Sale', 69, 3, NULL, 1, '2024-08-04', 0.00, 1, '2024-08-04 04:46:17', '2024-08-04 04:46:17'),
(115, 'App\\Models\\Sale', 70, 3, NULL, 1, '2024-08-05', 0.00, 1, '2024-08-05 09:11:39', '2024-08-05 09:11:39'),
(116, 'App\\Models\\Purchase', 61, 3, NULL, 1, '2024-08-06', 0.00, 1, '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(117, 'App\\Models\\Sale', 71, 3, NULL, 1, '2024-08-06', 0.00, 1, '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(118, 'App\\Models\\Purchase', 62, 3, NULL, 1, '2024-08-09', 0.00, 1, '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(119, 'App\\Models\\Purchase', 63, 3, NULL, 1, '2024-08-10', 0.00, 1, '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(120, 'App\\Models\\Purchase', 64, 3, NULL, 1, '2024-08-10', 0.00, 1, '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(121, 'App\\Models\\Purchase', 65, 3, NULL, 1, '2024-08-10', 0.00, 1, '2024-08-10 04:15:14', '2024-08-10 04:15:14'),
(122, 'App\\Models\\Sale', 72, 3, NULL, 1, '2024-08-10', 148069.00, 1, '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(123, 'App\\Models\\Sale', 73, 3, NULL, 1, '2024-08-10', 40000.00, 1, '2024-08-10 04:41:54', '2024-08-10 04:57:19'),
(124, 'App\\Models\\Purchase', 66, 3, NULL, 1, '2024-08-10', 0.00, 1, '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(125, 'App\\Models\\Sale', 75, 3, NULL, 1, '2024-08-10', 78395.00, 1, '2024-08-10 05:49:32', '2024-08-10 09:52:36'),
(126, 'App\\Models\\Sale', 76, 3, NULL, 1, '2024-08-10', 0.00, 1, '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(127, 'App\\Models\\Purchase', 67, 3, NULL, 1, '2024-08-14', 0.00, 1, '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(128, 'App\\Models\\Purchase', 68, 3, NULL, 1, '2024-08-14', 0.00, 1, '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(129, 'App\\Models\\Purchase', 69, 3, NULL, 1, '2024-08-14', 0.00, 1, '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(130, 'App\\Models\\Sale', 77, 3, NULL, 1, '2024-08-14', 0.00, 1, '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(131, 'App\\Models\\Purchase', 70, 3, NULL, 1, '2024-08-15', 0.00, 1, '2024-08-15 02:46:14', '2024-08-15 02:46:14'),
(132, 'App\\Models\\Sale', 78, 3, NULL, 1, '2024-08-15', 0.00, 1, '2024-08-15 02:47:05', '2024-08-15 02:47:05'),
(133, 'App\\Models\\Purchase', 71, 3, NULL, 1, '2024-08-15', 0.00, 1, '2024-08-15 07:55:51', '2024-08-16 08:13:03'),
(134, 'App\\Models\\Sale', 79, 3, NULL, 1, '2024-08-16', 0.00, 1, '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(135, 'App\\Models\\Purchase', 72, 3, NULL, 1, '2024-08-16', 0.00, 1, '2024-08-16 08:26:56', '2024-08-16 08:26:56'),
(136, 'App\\Models\\Purchase', 73, 3, NULL, 1, '2024-08-21', 371290.00, 1, '2024-08-21 03:09:54', '2024-08-21 03:11:43'),
(137, 'App\\Models\\Sale', 80, 3, NULL, 1, '2024-08-21', 0.00, 1, '2024-08-21 03:13:03', '2024-08-21 11:12:15'),
(138, 'App\\Models\\Purchase', 74, 3, NULL, 1, '2024-08-21', 910.00, 1, '2024-08-21 03:27:01', '2024-08-21 03:27:01'),
(139, 'App\\Models\\Purchase', 75, 3, NULL, 1, '2024-08-23', 0.00, 1, '2024-08-23 03:27:30', '2024-08-23 03:27:30'),
(140, 'App\\Models\\Sale', 81, 3, NULL, 1, '2024-08-23', 0.00, 1, '2024-08-23 03:30:52', '2024-08-23 03:31:23'),
(141, 'App\\Models\\Purchase', 76, 3, NULL, 1, '2024-08-25', 39050.00, 1, '2024-08-25 12:33:29', '2024-08-25 12:33:29'),
(142, 'App\\Models\\Sale', 82, 3, NULL, 1, '2024-08-25', 0.00, 1, '2024-08-25 12:33:59', '2024-08-25 12:33:59'),
(143, 'App\\Models\\Purchase', 77, 3, NULL, 1, '2024-08-25', 0.00, 1, '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(144, 'App\\Models\\Purchase', 78, 3, NULL, 1, '2024-08-26', 0.00, 1, '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(145, 'App\\Models\\Sale', 83, 3, NULL, 1, '2024-08-26', 0.00, 1, '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(146, 'App\\Models\\Purchase', 79, 3, NULL, 1, '2024-08-26', 0.00, 1, '2024-08-26 06:12:28', '2024-08-26 06:13:35'),
(147, 'App\\Models\\Sale', 84, 3, NULL, 1, '2024-08-26', 0.00, 1, '2024-08-26 06:18:44', '2024-08-26 06:18:44'),
(148, 'App\\Models\\Purchase', 80, 3, NULL, 1, '2024-08-27', 0.00, 1, '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(149, 'App\\Models\\Sale', 85, 3, NULL, 1, '2024-08-28', 0.00, 1, '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(150, 'App\\Models\\Purchase', 81, 3, NULL, 1, '2024-08-30', 0.00, 1, '2024-08-30 07:13:50', '2024-08-30 07:17:25'),
(151, 'App\\Models\\Purchase', 82, 3, NULL, 1, '2024-08-31', 0.00, 1, '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(152, 'App\\Models\\Purchase', 83, 3, NULL, 1, '2024-08-31', 0.00, 1, '2024-08-31 02:43:22', '2024-08-31 02:43:22'),
(153, 'App\\Models\\Sale', 86, 3, NULL, 1, '2024-08-31', 0.00, 1, '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(154, 'App\\Models\\Sale', 87, 3, NULL, 1, '2024-08-31', 0.00, 1, '2024-08-31 04:20:27', '2024-08-31 04:20:27'),
(155, 'App\\Models\\Purchase', 84, 3, NULL, 1, '2024-09-07', 0.00, 1, '2024-09-07 04:10:46', '2024-09-07 04:10:46'),
(156, 'App\\Models\\Purchase', 85, 3, NULL, 1, '2024-09-07', 0.00, 1, '2024-09-07 04:18:37', '2024-09-07 04:18:37'),
(157, 'App\\Models\\Purchase', 86, 3, NULL, 1, '2024-09-07', 0.00, 1, '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(158, 'App\\Models\\Sale', 88, 3, NULL, 1, '2024-09-07', 0.00, 1, '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(159, 'App\\Models\\Purchase', 87, 3, NULL, 1, '2024-09-07', 0.00, 1, '2024-09-07 06:14:36', '2024-09-07 06:14:36'),
(160, 'App\\Models\\Sale', 89, 3, NULL, 1, '2024-09-08', 0.00, 1, '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(161, 'App\\Models\\Purchase', 88, 3, NULL, 1, '2024-09-08', 0.00, 1, '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(162, 'App\\Models\\Purchase', 89, 3, NULL, 1, '2024-09-11', 0.00, 1, '2024-09-11 03:53:16', '2024-09-11 03:53:16'),
(163, 'App\\Models\\Sale', 90, 3, NULL, 1, '2024-09-11', 0.00, 1, '2024-09-11 03:53:43', '2024-09-11 03:53:43'),
(164, 'App\\Models\\Purchase', 90, 3, NULL, 1, '2024-09-17', 0.00, 1, '2024-09-17 09:08:33', '2024-09-17 09:08:33'),
(165, 'App\\Models\\Purchase', 91, 3, NULL, 1, '2024-09-17', 0.00, 1, '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(166, 'App\\Models\\Sale', 91, 3, NULL, 1, '2024-09-17', 0.00, 1, '2024-09-17 09:20:06', '2024-09-17 09:21:56'),
(167, 'App\\Models\\Purchase', 92, 3, NULL, 1, '2024-09-17', 0.00, 1, '2024-09-17 09:21:22', '2024-09-17 09:21:22'),
(168, 'App\\Models\\Purchase', 93, 3, NULL, 1, '2024-09-25', 0.00, 1, '2024-09-25 04:58:11', '2024-09-25 07:46:40'),
(169, 'App\\Models\\Sale', 92, 3, NULL, 1, '2024-09-25', 0.00, 1, '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(170, 'App\\Models\\Purchase', 94, 3, NULL, 1, '2024-09-28', 0.00, 1, '2024-09-28 11:40:05', '2024-09-28 11:40:05'),
(171, 'App\\Models\\Purchase', 95, 3, NULL, 1, '2024-09-29', 0.00, 1, '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(172, 'App\\Models\\Sale', 93, 3, NULL, 1, '2024-09-30', 0.00, 1, '2024-09-30 03:28:03', '2024-09-30 08:58:54'),
(173, 'App\\Models\\Purchase', 96, 3, NULL, 1, '2024-09-30', 0.00, 1, '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(174, 'App\\Models\\Purchase', 97, 3, NULL, 1, '2024-10-06', 0.00, 1, '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(175, 'App\\Models\\Sale', 94, 3, NULL, 1, '2024-10-06', 0.00, 1, '2024-10-06 06:15:53', '2024-10-06 06:28:22'),
(176, 'App\\Models\\Sale', 95, 3, NULL, 1, '2024-10-07', 0.00, 1, '2024-10-07 03:13:25', '2024-10-07 03:13:25'),
(177, 'App\\Models\\Purchase', 98, 3, NULL, 1, '2024-10-08', 0.00, 1, '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(178, 'App\\Models\\Sale', 96, 3, NULL, 1, '2024-10-09', 0.00, 1, '2024-10-09 07:06:28', '2024-10-12 06:23:53'),
(179, 'App\\Models\\Sale', 98, 3, NULL, 1, '2024-10-10', 0.00, 1, '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(180, 'App\\Models\\Purchase', 99, 3, NULL, 1, '2024-10-12', 0.00, 1, '2024-10-12 06:22:37', '2024-10-12 06:22:37'),
(181, 'App\\Models\\SaleReturn', 7, 3, NULL, 1, '2024-10-16', 0.00, 1, '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(182, 'App\\Models\\Purchase', 100, 3, NULL, 1, '2024-10-16', 0.00, 1, '2024-10-15 22:37:30', '2024-10-15 22:37:30'),
(183, 'App\\Models\\Sale', 99, 3, NULL, 1, '2024-10-16', 0.00, 1, '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(184, 'App\\Models\\Purchase', 101, 3, NULL, 1, '2024-10-16', 0.00, 1, '2024-10-16 06:42:41', '2024-10-16 07:43:49'),
(185, 'App\\Models\\Sale', 100, 3, NULL, 1, '2024-10-16', 0.00, 1, '2024-10-16 06:50:45', '2024-10-16 07:43:21'),
(186, 'App\\Models\\Purchase', 102, 3, NULL, 1, '2024-10-19', 0.00, 1, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(187, 'App\\Models\\Sale', 101, 3, NULL, 1, '2024-10-19', 0.00, 1, '2024-10-19 05:42:14', '2024-10-19 05:42:14'),
(188, 'App\\Models\\Purchase', 103, 3, NULL, 1, '2024-10-21', 0.00, 1, '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(189, 'App\\Models\\Sale', 102, 3, NULL, 1, '2024-10-21', 0.00, 1, '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(190, 'App\\Models\\Sale', 103, 3, NULL, 1, '2024-10-22', 0.00, 1, '2024-10-22 02:47:06', '2024-10-22 03:08:40'),
(191, 'App\\Models\\Sale', 104, 3, NULL, 1, '2024-10-23', 0.00, 1, '2024-10-23 03:11:27', '2024-10-23 03:11:27'),
(192, 'App\\Models\\Purchase', 104, 3, NULL, 1, '2024-10-25', 0.00, 1, '2024-10-25 09:19:04', '2024-10-25 09:19:04'),
(193, 'App\\Models\\Sale', 105, 3, NULL, 1, '2024-10-25', 0.00, 1, '2024-10-25 09:19:30', '2024-10-25 09:19:30');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'role.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(2, 'role.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(3, 'role.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(4, 'role.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(5, 'role.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(6, 'role.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(7, 'role.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(8, 'user.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(9, 'user.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(10, 'user.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(11, 'user.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(12, 'user.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(13, 'user.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(14, 'user.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(15, 'unit.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(16, 'unit.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(17, 'unit.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(18, 'unit.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(19, 'unit.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(20, 'unit.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(21, 'unit.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(22, 'unit.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(23, 'unit.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(24, 'unit.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(25, 'branch.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(26, 'branch.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(27, 'branch.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(28, 'branch.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(29, 'branch.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(30, 'branch.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(31, 'branch.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(32, 'branch.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(33, 'branch.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(34, 'branch.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(35, 'cash.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(36, 'cash.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(37, 'cash.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(38, 'cash.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(39, 'cash.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(40, 'cash.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(41, 'cash.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(42, 'cash.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(43, 'cash.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(44, 'cash.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(45, 'brand.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(46, 'brand.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(47, 'brand.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(48, 'brand.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(49, 'brand.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(50, 'brand.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(51, 'brand.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(52, 'brand.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(53, 'brand.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(54, 'brand.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(55, 'category.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(56, 'category.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(57, 'category.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(58, 'category.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(59, 'category.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(60, 'category.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(61, 'category.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(62, 'category.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(63, 'category.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(64, 'category.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(65, 'supplier.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(66, 'supplier.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(67, 'supplier.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(68, 'supplier.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(69, 'supplier.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(70, 'supplier.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(71, 'supplier.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(72, 'supplier.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(73, 'supplier.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(74, 'supplier.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(75, 'customer.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(76, 'customer.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(77, 'customer.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(78, 'customer.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(79, 'customer.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(80, 'customer.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(81, 'customer.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(82, 'customer.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(83, 'customer.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(84, 'customer.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(85, 'product.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(86, 'product.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(87, 'product.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(88, 'product.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(89, 'product.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(90, 'product.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(91, 'product.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(92, 'product.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(93, 'product.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(94, 'product.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(95, 'bank.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(96, 'bank.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(97, 'bank.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(98, 'bank.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(99, 'bank.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(100, 'bank.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(101, 'bank.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(102, 'bank.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(103, 'bank.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(104, 'bank.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(105, 'bank-account.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(106, 'bank-account.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(107, 'bank-account.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(108, 'bank-account.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(109, 'bank-account.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(110, 'bank-account.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(111, 'bank-account.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(112, 'bank-account.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(113, 'bank-account.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(114, 'bank-account.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(115, 'purchase.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(116, 'purchase.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(117, 'purchase.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(118, 'purchase.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(119, 'purchase.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(120, 'purchase.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(121, 'purchase.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(122, 'purchase.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(123, 'purchase.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(124, 'purchase.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(125, 'stock.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(126, 'stock.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(127, 'stock.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(128, 'stock.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(129, 'stock.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(130, 'stock.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(131, 'stock.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(132, 'purchase-return.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(133, 'purchase-return.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(134, 'purchase-return.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(135, 'purchase-return.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(136, 'purchase-return.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(137, 'purchase-return.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(138, 'purchase-return.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(139, 'purchase-return.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(140, 'purchase-return.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(141, 'purchase-return.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(142, 'sale.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(143, 'sale.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(144, 'sale.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(145, 'sale.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(146, 'sale.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(147, 'sale.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(148, 'sale.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(149, 'sale.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(150, 'sale.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(151, 'sale.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(152, 'sale-return.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(153, 'sale-return.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(154, 'sale-return.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(155, 'sale-return.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(156, 'sale-return.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(157, 'sale-return.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(158, 'sale-return.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(159, 'sale-return.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(160, 'sale-return.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(161, 'sale-return.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(162, 'damage.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(163, 'damage.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(164, 'damage.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(165, 'damage.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(166, 'damage.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(167, 'damage.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(168, 'damage.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(169, 'damage.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(170, 'damage.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(171, 'damage.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(172, 'supplier-due.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(173, 'supplier-due.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(174, 'supplier-due.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(175, 'supplier-due.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(176, 'supplier-due.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(177, 'supplier-due.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(178, 'supplier-due.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(179, 'supplier-due.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(180, 'supplier-due.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(181, 'supplier-due.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(182, 'customer-due.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(183, 'customer-due.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(184, 'customer-due.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(185, 'customer-due.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(186, 'customer-due.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(187, 'customer-due.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(188, 'customer-due.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(189, 'customer-due.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(190, 'customer-due.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(191, 'customer-due.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(192, 'production.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(193, 'production.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(194, 'production.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(195, 'production.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(196, 'production.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(197, 'production.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(198, 'production.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(199, 'production.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(200, 'production.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(201, 'production.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(202, 'product-transfer.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(203, 'product-transfer.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(204, 'product-transfer.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(205, 'product-transfer.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(206, 'product-transfer.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(207, 'product-transfer.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(208, 'product-transfer.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(209, 'product-transfer.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(210, 'product-transfer.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(211, 'product-transfer.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(212, 'expense-category.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(213, 'expense-category.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(214, 'expense-category.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(215, 'expense-category.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(216, 'expense-category.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(217, 'expense-category.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(218, 'expense-category.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(219, 'expense-category.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(220, 'expense-category.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(221, 'expense-category.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(222, 'expense.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(223, 'expense.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(224, 'expense.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(225, 'expense.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(226, 'expense.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(227, 'expense.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(228, 'expense.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(229, 'expense.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(230, 'expense.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(231, 'expense.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(232, 'withdraw.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(233, 'withdraw.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(234, 'withdraw.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(235, 'withdraw.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(236, 'withdraw.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(237, 'withdraw.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(238, 'withdraw.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(239, 'withdraw.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(240, 'withdraw.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(241, 'withdraw.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(242, 'investor.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(243, 'investor.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(244, 'investor.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(245, 'investor.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(246, 'investor.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(247, 'investor.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(248, 'investor.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(249, 'investor.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(250, 'investor.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(251, 'investor.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(252, 'invest.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(253, 'invest.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(254, 'invest.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(255, 'invest.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(256, 'invest.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(257, 'invest.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(258, 'invest.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(259, 'invest.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(260, 'invest.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(261, 'invest.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(262, 'invest-withdraw.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(263, 'invest-withdraw.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(264, 'invest-withdraw.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(265, 'invest-withdraw.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(266, 'invest-withdraw.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(267, 'invest-withdraw.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(268, 'invest-withdraw.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(269, 'invest-withdraw.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(270, 'invest-withdraw.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(271, 'invest-withdraw.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(272, 'transaction.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(273, 'transaction.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(274, 'transaction.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(275, 'transaction.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(276, 'transaction.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(277, 'transaction.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(278, 'transaction.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(279, 'transaction.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(280, 'transaction.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(281, 'transaction.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(282, 'advanced-salary.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(283, 'advanced-salary.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(284, 'advanced-salary.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(285, 'advanced-salary.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(286, 'advanced-salary.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(287, 'advanced-salary.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(288, 'advanced-salary.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(289, 'advanced-salary.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(290, 'advanced-salary.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(291, 'advanced-salary.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(292, 'salary.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(293, 'salary.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(294, 'salary.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(295, 'salary.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(296, 'salary.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(297, 'salary.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(298, 'salary.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(299, 'salary.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(300, 'salary.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(301, 'salary.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(302, 'loan-account.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(303, 'loan-account.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(304, 'loan-account.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(305, 'loan-account.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(306, 'loan-account.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(307, 'loan-account.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(308, 'loan-account.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(309, 'loan-account.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(310, 'loan-account.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(311, 'loan-account.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(312, 'loan.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(313, 'loan.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(314, 'loan.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(315, 'loan.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(316, 'loan.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(317, 'loan.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(318, 'loan.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(319, 'loan.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(320, 'loan.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(321, 'loan.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(322, 'loan-installment.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(323, 'loan-installment.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(324, 'loan-installment.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(325, 'loan-installment.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(326, 'loan-installment.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(327, 'loan-installment.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(328, 'loan-installment.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(329, 'loan-installment.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(330, 'loan-installment.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(331, 'loan-installment.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(332, 'income-sector.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(333, 'income-sector.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(334, 'income-sector.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(335, 'income-sector.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(336, 'income-sector.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(337, 'income-sector.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(338, 'income-sector.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(339, 'income-sector.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(340, 'income-sector.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(341, 'income-sector.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(342, 'income-record.trash', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(343, 'income-record.restore', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(344, 'income-record.permanentDelete', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(345, 'income-record.index', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(346, 'income-record.create', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(347, 'income-record.store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(348, 'income-record.show', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(349, 'income-record.edit', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(350, 'income-record.update', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(351, 'income-record.destroy', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(352, 'report.cash-book', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(353, 'report.cash-book-date-data', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(354, 'report.closing-balance-store', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(355, 'report.purchase-qty-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(356, 'report.purchase-voucher-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(357, 'report.sale-qty-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(358, 'report.sale-invoice-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(359, 'report.stock-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(360, 'report.production-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(361, 'report.expense-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(362, 'report.expense-yearly-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(363, 'report.expense-details-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(364, 'report.income-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(365, 'report.profit-loss-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(366, 'report.net-profit-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(367, 'report.salary-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(368, 'report.salary-details-report', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(369, 'ledger.customer-ledger', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(370, 'ledger.supplier-ledger', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(371, 'ledger.product-ledger', 'web', '2024-05-21 17:31:39', '2024-05-21 17:31:39');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productions`
--

CREATE TABLE `productions` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `production_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productions`
--

INSERT INTO `productions` (`id`, `date`, `production_no`, `branch_id`, `user_id`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-04-04', 'PROD-000001', 1, 1, 'null', NULL, '2024-04-04 21:55:15', '2024-04-04 21:55:15'),
(2, '2024-04-04', 'PROD-000002', 1, 1, 'null', NULL, '2024-04-04 21:57:26', '2024-04-04 21:57:26'),
(3, '2024-04-04', 'PROD-000003', 1, 1, 'null', NULL, '2024-04-04 21:58:14', '2024-04-04 21:58:14'),
(4, '2024-04-04', 'PROD-000004', 1, 1, 'null', NULL, '2024-04-04 21:59:13', '2024-04-04 21:59:13'),
(5, '2024-04-05', 'PROD-000005', 1, 1, 'null', NULL, '2024-04-05 18:39:10', '2024-04-05 18:39:10'),
(6, '2024-04-05', 'PROD-000006', 1, 1, NULL, NULL, '2024-04-05 18:41:55', '2024-04-05 18:51:30'),
(7, '2024-04-05', 'PROD-000007', 1, 1, 'null', NULL, '2024-04-05 18:43:56', '2024-04-05 18:43:56'),
(8, '2024-04-05', 'PROD-000008', 1, 1, 'null', NULL, '2024-04-05 18:45:35', '2024-04-05 18:45:35'),
(9, '2024-04-05', 'PROD-000009', 1, 1, 'null', NULL, '2024-04-05 18:46:17', '2024-04-05 18:46:17'),
(10, '2024-04-17', 'PROD-000010', 1, 1, 'null', NULL, '2024-04-17 11:41:40', '2024-04-17 11:41:40'),
(11, '2024-04-17', 'PROD-000011', 1, 1, 'null', NULL, '2024-04-17 11:42:45', '2024-04-17 11:42:45'),
(12, '2024-04-17', 'PROD-000012', 1, 1, 'null', NULL, '2024-04-17 11:43:37', '2024-04-17 11:43:37'),
(13, '2024-04-17', 'PROD-000013', 1, 1, 'null', NULL, '2024-04-17 11:44:40', '2024-04-17 11:44:40'),
(14, '2024-04-17', 'PROD-000014', 1, 1, 'null', NULL, '2024-04-17 11:45:41', '2024-04-17 11:45:41'),
(15, '2024-04-17', 'PROD-000015', 1, 1, 'null', NULL, '2024-04-17 11:46:38', '2024-04-17 11:46:38'),
(16, '2024-04-17', 'PROD-000016', 1, 1, 'null', NULL, '2024-04-17 11:47:29', '2024-04-17 11:47:29'),
(17, '2024-04-17', 'PROD-000017', 1, 1, 'null', NULL, '2024-04-17 11:48:42', '2024-04-17 11:48:42'),
(18, '2024-04-17', 'PROD-000018', 1, 1, 'null', NULL, '2024-04-17 11:49:21', '2024-04-17 11:49:21'),
(19, '2024-04-17', 'PROD-000019', 1, 1, 'null', NULL, '2024-04-17 11:50:03', '2024-04-17 11:50:03'),
(20, '2024-04-17', 'PROD-000020', 1, 1, 'null', NULL, '2024-04-17 11:54:35', '2024-04-17 11:54:35'),
(21, '2024-04-17', 'PROD-000021', 1, 1, 'null', NULL, '2024-04-17 11:59:25', '2024-04-17 11:59:25'),
(22, '2024-04-17', 'PROD-000022', 1, 1, 'null', NULL, '2024-04-17 12:04:09', '2024-04-17 12:04:09'),
(23, '2024-04-23', 'PROD-000023', 1, 1, 'null', NULL, '2024-04-23 17:33:21', '2024-04-23 17:33:21'),
(24, '2024-04-25', 'PROD-000024', 1, 1, 'null', NULL, '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(25, '2024-04-25', 'PROD-000025', 1, 1, 'null', NULL, '2024-04-25 20:34:28', '2024-04-25 20:34:28'),
(26, '2024-04-25', 'PROD-000026', 1, 1, 'null', NULL, '2024-04-25 20:35:01', '2024-04-25 20:35:01'),
(27, '2024-04-25', 'PROD-000027', 1, 1, 'null', NULL, '2024-04-25 20:36:44', '2024-04-25 20:36:44'),
(28, '2024-04-25', 'PROD-000028', 1, 1, 'null', NULL, '2024-04-25 20:38:25', '2024-04-25 20:38:25'),
(29, '2024-04-25', 'PROD-000029', 1, 1, 'null', NULL, '2024-04-25 20:39:09', '2024-04-25 20:39:09'),
(30, '2024-04-30', 'PROD-000030', 1, 1, 'null', NULL, '2024-04-30 13:18:54', '2024-04-30 13:18:54'),
(31, '2024-04-30', 'PROD-000031', 1, 1, 'null', NULL, '2024-04-30 13:20:08', '2024-04-30 13:20:08'),
(32, '2024-04-30', 'PROD-000032', 1, 1, 'null', NULL, '2024-04-30 13:20:47', '2024-04-30 13:20:47'),
(33, '2024-04-30', 'PROD-000033', 1, 1, 'null', NULL, '2024-04-30 13:21:39', '2024-04-30 13:21:39'),
(34, '2024-04-30', 'PROD-000034', 1, 1, 'null', NULL, '2024-04-30 13:22:30', '2024-04-30 13:22:30'),
(35, '2024-04-30', 'PROD-000035', 1, 1, 'null', NULL, '2024-04-30 13:22:57', '2024-04-30 13:22:57'),
(36, '2024-04-30', 'PROD-000036', 1, 1, 'null', NULL, '2024-04-30 13:23:23', '2024-04-30 13:23:23'),
(37, '2024-04-30', 'PROD-000037', 1, 1, 'null', NULL, '2024-04-30 13:24:19', '2024-04-30 13:24:19'),
(38, '2024-04-30', 'PROD-000038', 1, 1, 'null', NULL, '2024-04-30 13:24:50', '2024-04-30 13:24:50'),
(39, '2024-04-30', 'PROD-000039', 1, 1, 'null', NULL, '2024-04-30 13:25:27', '2024-04-30 13:25:27'),
(40, '2024-04-30', 'PROD-000040', 1, 1, 'null', NULL, '2024-04-30 13:26:48', '2024-04-30 13:26:48'),
(41, '2024-04-30', 'PROD-000041', 1, 1, 'null', NULL, '2024-04-30 13:29:40', '2024-04-30 13:29:40'),
(42, '2024-04-30', 'PROD-000042', 1, 1, 'null', NULL, '2024-04-30 13:31:40', '2024-04-30 13:31:40'),
(43, '2024-04-30', 'PROD-000043', 1, 1, 'null', NULL, '2024-04-30 13:32:27', '2024-04-30 13:32:27'),
(44, '2024-04-30', 'PROD-000044', 1, 1, 'null', NULL, '2024-04-30 13:33:10', '2024-04-30 13:33:10'),
(45, '2024-04-30', 'PROD-000045', 1, 1, 'null', NULL, '2024-04-30 13:33:47', '2024-04-30 13:33:47'),
(46, '2024-04-30', 'PROD-000046', 1, 1, 'null', NULL, '2024-04-30 13:34:45', '2024-04-30 13:34:45'),
(47, '2024-04-30', 'PROD-000047', 1, 1, 'null', NULL, '2024-04-30 13:35:13', '2024-04-30 13:35:13'),
(48, '2024-04-30', 'PROD-000048', 1, 1, 'null', NULL, '2024-04-30 17:44:53', '2024-04-30 17:44:53'),
(49, '2024-05-02', 'PROD-000049', 1, 1, 'null', NULL, '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(50, '2024-05-02', 'PROD-000050', 1, 1, 'null', NULL, '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(51, '2024-05-04', 'PROD-000051', 1, 1, 'null', NULL, '2024-05-04 14:20:39', '2024-05-04 14:20:39'),
(52, '2024-05-04', 'PROD-000052', 1, 1, 'null', NULL, '2024-05-04 14:21:09', '2024-05-04 14:21:09'),
(53, '2024-05-04', 'PROD-000053', 1, 1, 'null', NULL, '2024-05-04 14:26:06', '2024-05-04 14:26:06'),
(54, '2024-05-06', 'PROD-000054', 1, 1, 'null', NULL, '2024-05-06 13:56:40', '2024-05-06 13:56:40'),
(55, '2024-05-17', 'PROD-000055', 1, 1, 'null', NULL, '2024-05-17 17:56:33', '2024-05-17 17:56:33'),
(56, '2024-05-17', 'PROD-000056', 1, 1, 'null', NULL, '2024-05-17 17:58:12', '2024-05-17 17:58:12'),
(57, '2024-05-26', 'PROD-000057', 1, 1, 'null', NULL, '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(58, '2024-06-27', 'PROD-000058', 1, 1, NULL, NULL, '2024-06-27 20:49:35', '2024-06-27 20:51:20'),
(59, '2024-06-27', 'PROD-000059', 1, 1, 'null', NULL, '2024-06-27 20:52:12', '2024-06-27 20:52:12'),
(60, '2024-07-11', 'PROD-000060', 1, 1, 'null', NULL, '2024-07-11 20:35:51', '2024-07-11 20:35:51'),
(61, '2024-08-04', 'PROD-000061', 1, 1, 'null', NULL, '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(62, '2024-08-05', 'PROD-000062', 1, 1, 'null', NULL, '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(63, '2024-08-06', 'PROD-000063', 1, 1, 'null', NULL, '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(64, '2024-08-14', 'PROD-000064', 1, 1, 'null', NULL, '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(65, '2024-08-23', 'PROD-000065', 1, 1, 'null', NULL, '2024-08-23 03:29:22', '2024-08-23 03:29:22'),
(66, '2024-08-28', 'PROD-000066', 1, 1, NULL, NULL, '2024-08-28 10:27:02', '2024-08-28 10:27:35'),
(67, '2024-08-31', 'PROD-000067', 1, 1, NULL, NULL, '2024-08-31 02:57:46', '2024-08-31 03:03:20'),
(68, '2024-09-30', 'PROD-000068', 1, 1, 'null', NULL, '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(69, '2024-10-01', 'PROD-000069', 1, 1, 'null', NULL, '2024-10-01 10:32:40', '2024-10-01 10:32:40'),
(70, '2024-10-06', 'PROD-000070', 1, 1, 'null', NULL, '2024-10-06 06:17:01', '2024-10-06 06:17:01'),
(71, '2024-10-09', 'PROD-000071', 1, 1, 'null', NULL, '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(72, '2024-10-12', 'PROD-000072', 1, 1, 'null', NULL, '2024-10-12 06:15:26', '2024-10-12 06:15:26'),
(73, '2024-10-19', 'PROD-000073', 1, 1, 'null', NULL, '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(74, '2024-10-22', 'PROD-000074', 1, 1, 'null', NULL, '2024-10-22 02:45:58', '2024-10-22 02:45:58'),
(75, '2024-10-23', 'PROD-000075', 1, 1, 'null', NULL, '2024-10-23 03:10:33', '2024-10-23 03:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `production_details`
--

CREATE TABLE `production_details` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `purchase_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `quantity_in_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `production_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_details`
--

INSERT INTO `production_details` (`id`, `date`, `production_id`, `product_id`, `quantity`, `purchase_price`, `quantity_in_unit`, `production_type`, `created_at`, `updated_at`) VALUES
(1, '2024-04-04', 1, 1, 2000.00, 1050.00, '[null,\"2\",null]', 'raw_product', '2024-04-04 21:55:15', '2024-04-04 21:55:15'),
(2, '2024-04-04', 1, 54, 11.00, 105.00, '[null,null,\"11\"]', 'finish_product', '2024-04-04 21:55:15', '2024-04-04 21:55:15'),
(3, '2024-04-04', 1, 55, 10.00, 52.50, '[null,null,\"10\"]', 'finish_product', '2024-04-04 21:55:15', '2024-04-04 21:55:15'),
(4, '2024-04-04', 2, 2, 2000.00, 1250.00, '[null,\"2\",null]', 'raw_product', '2024-04-04 21:57:26', '2024-04-04 21:57:26'),
(5, '2024-04-04', 2, 57, 16.00, 62.50, '[null,null,\"16\"]', 'finish_product', '2024-04-04 21:57:26', '2024-04-04 21:57:26'),
(6, '2024-04-04', 2, 56, 7.00, 125.00, '[null,null,\"7\"]', 'finish_product', '2024-04-04 21:57:26', '2024-04-04 21:57:26'),
(7, '2024-04-04', 3, 4, 2000.00, 170.00, '[null,\"2\",null]', 'raw_product', '2024-04-04 21:58:14', '2024-04-04 21:58:14'),
(8, '2024-04-04', 3, 60, 15.00, 17.00, '[null,null,\"15\"]', 'finish_product', '2024-04-04 21:58:14', '2024-04-04 21:58:14'),
(9, '2024-04-04', 4, 3, 1000.00, 2800.00, '[null,\"1\",null]', 'raw_product', '2024-04-04 21:59:13', '2024-04-04 21:59:13'),
(10, '2024-04-04', 4, 59, 6.00, 140.00, '[null,null,\"6\"]', 'finish_product', '2024-04-04 21:59:13', '2024-04-04 21:59:13'),
(11, '2024-04-04', 4, 58, 6.00, 280.00, '[null,null,\"6\"]', 'finish_product', '2024-04-04 21:59:13', '2024-04-04 21:59:13'),
(12, '2024-04-05', 5, 4, 3000.00, 170.00, '[null,\"3\",null]', 'raw_product', '2024-04-05 18:39:10', '2024-04-05 18:39:10'),
(13, '2024-04-05', 5, 60, 30.00, 17.00, '[null,null,\"30\"]', 'finish_product', '2024-04-05 18:39:10', '2024-04-05 18:39:10'),
(17, '2024-04-05', 7, 8, 1000.00, 2650.00, '[null,\"1\",null]', 'raw_product', '2024-04-05 18:43:56', '2024-04-05 18:43:56'),
(18, '2024-04-05', 7, 67, 20.00, 132.50, '[null,null,\"20\"]', 'finish_product', '2024-04-05 18:43:56', '2024-04-05 18:43:56'),
(19, '2024-04-05', 8, 7, 1000.00, 2100.00, '[null,\"1\",null]', 'raw_product', '2024-04-05 18:45:35', '2024-04-05 18:45:35'),
(20, '2024-04-05', 8, 66, 14.00, 105.00, '[null,null,\"14\"]', 'finish_product', '2024-04-05 18:45:35', '2024-04-05 18:45:35'),
(21, '2024-04-05', 8, 65, 3.00, 210.00, '[null,null,\"3\"]', 'finish_product', '2024-04-05 18:45:35', '2024-04-05 18:45:35'),
(22, '2024-04-05', 9, 6, 2000.00, 1150.00, '[null,\"2\",null]', 'raw_product', '2024-04-05 18:46:17', '2024-04-05 18:46:17'),
(23, '2024-04-05', 9, 64, 20.00, 57.50, '[null,null,\"20\"]', 'finish_product', '2024-04-05 18:46:17', '2024-04-05 18:46:17'),
(24, '2024-04-05', 9, 63, 10.00, 115.00, '[null,null,\"10\"]', 'finish_product', '2024-04-05 18:46:17', '2024-04-05 18:46:17'),
(25, '2024-04-05', 6, 5, 5000.00, 560.00, '[null,\"5\",null]', 'raw_product', '2024-04-05 18:51:30', '2024-04-05 18:51:30'),
(26, '2024-04-05', 6, 34, 30.00, 14.00, '[null,null,\"30\"]', 'finish_product', '2024-04-05 18:51:30', '2024-04-05 18:51:30'),
(27, '2024-04-05', 6, 33, 35.00, 27.00, '[null,null,\"35\"]', 'finish_product', '2024-04-05 18:51:30', '2024-04-05 18:51:30'),
(28, '2024-04-17', 10, 1, 2500.00, 1070.00, '[null,\"2.5\",null]', 'raw_product', '2024-04-17 11:41:40', '2024-04-17 11:41:40'),
(29, '2024-04-17', 10, 55, 17.00, 52.50, '[null,null,\"17\"]', 'finish_product', '2024-04-17 11:41:40', '2024-04-17 11:41:40'),
(30, '2024-04-17', 10, 54, 15.00, 115.50, '[null,null,\"15\"]', 'finish_product', '2024-04-17 11:41:40', '2024-04-17 11:41:40'),
(31, '2024-04-17', 11, 2, 2500.00, 1250.00, '[null,\"2.5\",null]', 'raw_product', '2024-04-17 11:42:45', '2024-04-17 11:42:45'),
(32, '2024-04-17', 11, 57, 18.00, 68.75, '[null,null,\"18\"]', 'finish_product', '2024-04-17 11:42:45', '2024-04-17 11:42:45'),
(33, '2024-04-17', 11, 56, 14.00, 137.50, '[null,null,\"14\"]', 'finish_product', '2024-04-17 11:42:45', '2024-04-17 11:42:45'),
(34, '2024-04-17', 12, 3, 1000.00, 2800.00, '[null,\"1\",null]', 'raw_product', '2024-04-17 11:43:37', '2024-04-17 11:43:37'),
(35, '2024-04-17', 12, 59, 6.00, 140.00, '[null,null,\"6\"]', 'finish_product', '2024-04-17 11:43:37', '2024-04-17 11:43:37'),
(36, '2024-04-17', 12, 58, 7.00, 280.00, '[null,null,\"7\"]', 'finish_product', '2024-04-17 11:43:37', '2024-04-17 11:43:37'),
(37, '2024-04-17', 13, 7, 1000.00, 2050.00, '[null,\"1\",null]', 'raw_product', '2024-04-17 11:44:40', '2024-04-17 11:44:40'),
(38, '2024-04-17', 13, 153, 18.00, 54.60, '[null,null,\"18\"]', 'finish_product', '2024-04-17 11:44:40', '2024-04-17 11:44:40'),
(39, '2024-04-17', 13, 66, 9.00, 115.50, '[null,null,\"9\"]', 'finish_product', '2024-04-17 11:44:40', '2024-04-17 11:44:40'),
(40, '2024-04-17', 14, 135, 2500.00, 1920.00, '[null,\"2.5\",null]', 'raw_product', '2024-04-17 11:45:41', '2024-04-17 11:45:41'),
(41, '2024-04-17', 14, 137, 17.00, 105.60, '[null,null,\"17\"]', 'finish_product', '2024-04-17 11:45:41', '2024-04-17 11:45:41'),
(42, '2024-04-17', 14, 136, 14.00, 211.20, '[null,null,\"14\"]', 'finish_product', '2024-04-17 11:45:41', '2024-04-17 11:45:41'),
(43, '2024-04-17', 15, 118, 2500.00, 80.00, '[null,\"2.5\",null]', 'raw_product', '2024-04-17 11:46:38', '2024-04-17 11:46:38'),
(44, '2024-04-17', 15, 120, 14.00, 18.70, '[null,null,\"14\"]', 'finish_product', '2024-04-17 11:46:38', '2024-04-17 11:46:38'),
(45, '2024-04-17', 15, 121, 18.00, 9.82, '[null,null,\"18\"]', 'finish_product', '2024-04-17 11:46:38', '2024-04-17 11:46:38'),
(46, '2024-04-17', 16, 140, 3000.00, 50.00, '[null,\"3\",null]', 'raw_product', '2024-04-17 11:47:29', '2024-04-17 11:47:29'),
(47, '2024-04-17', 16, 141, 29.00, 5.00, '[null,null,\"29\"]', 'finish_product', '2024-04-17 11:47:29', '2024-04-17 11:47:29'),
(48, '2024-04-17', 17, 142, 1100.00, 70.00, '[null,\"1.1\",null]', 'raw_product', '2024-04-17 11:48:42', '2024-04-17 11:48:42'),
(49, '2024-04-17', 17, 143, 10.00, 7.70, '[null,null,\"10\"]', 'finish_product', '2024-04-17 11:48:42', '2024-04-17 11:48:42'),
(50, '2024-04-17', 18, 144, 900.00, 140.00, '[null,\".9\",null]', 'raw_product', '2024-04-17 11:49:21', '2024-04-17 11:49:21'),
(51, '2024-04-17', 18, 145, 8.00, 14.00, '[null,null,\"8\"]', 'finish_product', '2024-04-17 11:49:21', '2024-04-17 11:49:21'),
(52, '2024-04-17', 19, 4, 2500.00, 170.00, '[null,\"2.5\",null]', 'raw_product', '2024-04-17 11:50:03', '2024-04-17 11:50:03'),
(53, '2024-04-17', 19, 60, 23.00, 18.10, '[null,null,\"23\"]', 'finish_product', '2024-04-17 11:50:03', '2024-04-17 11:50:03'),
(54, '2024-04-17', 20, 100, 3000.00, 400.00, '[null,\"3\",null]', 'raw_product', '2024-04-17 11:54:35', '2024-04-17 11:54:35'),
(55, '2024-04-17', 20, 154, 19.00, 22.50, '[null,null,\"19\"]', 'finish_product', '2024-04-17 11:54:35', '2024-04-17 11:54:35'),
(56, '2024-04-17', 20, 103, 15.00, 49.50, '[null,null,\"15\"]', 'finish_product', '2024-04-17 11:54:35', '2024-04-17 11:54:35'),
(57, '2024-04-17', 20, 102, 2.00, 90.00, '[null,null,\"2\"]', 'finish_product', '2024-04-17 11:54:35', '2024-04-17 11:54:35'),
(58, '2024-04-17', 21, 149, 1000.00, 800.00, '[null,\"1\",null]', 'raw_product', '2024-04-17 11:59:25', '2024-04-17 11:59:25'),
(59, '2024-04-17', 21, 155, 8.00, 40.00, '[null,null,\"8\"]', 'finish_product', '2024-04-17 11:59:25', '2024-04-17 11:59:25'),
(60, '2024-04-17', 21, 150, 6.00, 80.00, '[null,null,\"6\"]', 'finish_product', '2024-04-17 11:59:25', '2024-04-17 11:59:25'),
(61, '2024-04-17', 22, 133, 1500.00, 240.00, '[null,\"1.5\",null]', 'raw_product', '2024-04-17 12:04:09', '2024-04-17 12:04:09'),
(62, '2024-04-17', 22, 134, 1.00, 24.00, '[null,null,\"1\"]', 'finish_product', '2024-04-17 12:04:09', '2024-04-17 12:04:09'),
(63, '2024-04-17', 22, 156, 7.00, 48.00, '[null,null,\"7\"]', 'finish_product', '2024-04-17 12:04:09', '2024-04-17 12:04:09'),
(64, '2024-04-23', 23, 158, 1000.00, 220.00, '[null,\"1\",null]', 'raw_product', '2024-04-23 17:33:21', '2024-04-23 17:33:21'),
(65, '2024-04-23', 23, 159, 10.00, 22.00, '[null,null,\"10\"]', 'finish_product', '2024-04-23 17:33:21', '2024-04-23 17:33:21'),
(66, '2024-04-25', 24, 98, 700.00, 120.00, '[null,\".7\",null]', 'raw_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(67, '2024-04-25', 24, 8, 70.00, 3400.00, '[null,\".07\",null]', 'raw_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(68, '2024-04-25', 24, 114, 900.00, 440.00, '[null,\".9\",null]', 'raw_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(69, '2024-04-25', 24, 165, 450.00, 1550.00, '[null,\".45\",null]', 'raw_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(70, '2024-04-25', 24, 89, 1000.00, 640.00, '[null,\"1\",null]', 'raw_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(71, '2024-04-25', 24, 172, 136.00, 15.11, '[null,null,\"136\"]', 'finish_product', '2024-04-25 20:25:10', '2024-04-25 20:25:10'),
(72, '2024-04-25', 25, 164, 1000.00, 320.00, '[null,\"1\",null]', 'raw_product', '2024-04-25 20:34:28', '2024-04-25 20:34:28'),
(73, '2024-04-25', 25, 175, 12.00, 32.00, '[null,null,\"12\"]', 'finish_product', '2024-04-25 20:34:28', '2024-04-25 20:34:28'),
(74, '2024-04-25', 26, 160, 700.00, 320.00, '[null,\".7\",null]', 'raw_product', '2024-04-25 20:35:01', '2024-04-25 20:35:01'),
(75, '2024-04-25', 26, 161, 7.00, 32.00, '[null,null,\"7\"]', 'finish_product', '2024-04-25 20:35:01', '2024-04-25 20:35:01'),
(76, '2024-04-25', 27, 167, 5000.00, 320.00, '[null,\"5\",null]', 'raw_product', '2024-04-25 20:36:44', '2024-04-25 20:36:44'),
(77, '2024-04-25', 27, 169, 13.00, 32.00, '[null,null,\"13\"]', 'finish_product', '2024-04-25 20:36:44', '2024-04-25 20:36:44'),
(78, '2024-04-25', 27, 174, 10.00, 128.00, '[null,null,\"10\"]', 'finish_product', '2024-04-25 20:36:44', '2024-04-25 20:36:44'),
(79, '2024-04-25', 28, 166, 5000.00, 90.00, '[null,\"5\",null]', 'raw_product', '2024-04-25 20:38:25', '2024-04-25 20:38:25'),
(80, '2024-04-25', 28, 173, 9.00, 36.00, '[null,null,\"9\"]', 'finish_product', '2024-04-25 20:38:25', '2024-04-25 20:38:25'),
(81, '2024-04-25', 28, 168, 12.00, 9.00, '[null,null,\"12\"]', 'finish_product', '2024-04-25 20:38:25', '2024-04-25 20:38:25'),
(82, '2024-04-25', 29, 162, 700.00, 200.00, '[null,\".7\",null]', 'raw_product', '2024-04-25 20:39:09', '2024-04-25 20:39:09'),
(83, '2024-04-25', 29, 163, 7.00, 20.00, '[null,null,\"7\"]', 'finish_product', '2024-04-25 20:39:09', '2024-04-25 20:39:09'),
(84, '2024-04-30', 30, 89, 4000.00, 620.00, '[null,\"4\",null]', 'raw_product', '2024-04-30 13:18:54', '2024-04-30 13:18:54'),
(85, '2024-04-30', 30, 91, 20.00, 50.00, '[null,null,\"20\"]', 'finish_product', '2024-04-30 13:18:54', '2024-04-30 13:18:54'),
(86, '2024-04-30', 30, 90, 19.00, 100.00, '[null,null,\"19\"]', 'finish_product', '2024-04-30 13:18:54', '2024-04-30 13:18:54'),
(87, '2024-04-30', 31, 26, 1000.00, 3800.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:20:08', '2024-04-30 13:20:08'),
(88, '2024-04-30', 31, 28, 13.00, 80.00, '[null,null,\"13\"]', 'finish_product', '2024-04-30 13:20:08', '2024-04-30 13:20:08'),
(89, '2024-04-30', 31, 27, 6.00, 160.00, '[null,null,\"6\"]', 'finish_product', '2024-04-30 13:20:08', '2024-04-30 13:20:08'),
(90, '2024-04-30', 32, 38, 1000.00, 110.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:20:47', '2024-04-30 13:20:47'),
(91, '2024-04-30', 32, 39, 10.00, 12.00, '[null,null,\"10\"]', 'finish_product', '2024-04-30 13:20:47', '2024-04-30 13:20:47'),
(92, '2024-04-30', 33, 35, 1000.00, 100.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:21:39', '2024-04-30 13:21:39'),
(93, '2024-04-30', 33, 36, 10.00, 12.00, '[null,null,\"10\"]', 'finish_product', '2024-04-30 13:21:39', '2024-04-30 13:21:39'),
(94, '2024-04-30', 33, 37, 1.00, 6.00, '[null,null,\"1\"]', 'finish_product', '2024-04-30 13:21:39', '2024-04-30 13:21:39'),
(95, '2024-04-30', 34, 15, 1000.00, 200.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:22:30', '2024-04-30 13:22:30'),
(96, '2024-04-30', 34, 16, 11.00, 19.00, '[null,null,\"11\"]', 'finish_product', '2024-04-30 13:22:30', '2024-04-30 13:22:30'),
(97, '2024-04-30', 35, 17, 1000.00, 200.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:22:57', '2024-04-30 13:22:57'),
(98, '2024-04-30', 35, 18, 11.00, 19.00, '[null,null,\"11\"]', 'finish_product', '2024-04-30 13:22:57', '2024-04-30 13:22:57'),
(99, '2024-04-30', 36, 19, 1000.00, 200.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:23:23', '2024-04-30 13:23:23'),
(100, '2024-04-30', 36, 20, 9.00, 19.00, '[null,null,\"9\"]', 'finish_product', '2024-04-30 13:23:23', '2024-04-30 13:23:23'),
(101, '2024-04-30', 37, 100, 5000.00, 450.00, '[null,\"5\",null]', 'raw_product', '2024-04-30 13:24:19', '2024-04-30 13:24:19'),
(102, '2024-04-30', 37, 102, 6.00, 90.00, '[null,null,\"6\"]', 'finish_product', '2024-04-30 13:24:19', '2024-04-30 13:24:19'),
(103, '2024-04-30', 37, 101, 10.00, 225.00, '[null,null,\"10\"]', 'finish_product', '2024-04-30 13:24:19', '2024-04-30 13:24:19'),
(104, '2024-04-30', 38, 140, 2000.00, 60.00, '[null,\"2\",null]', 'raw_product', '2024-04-30 13:24:50', '2024-04-30 13:24:50'),
(105, '2024-04-30', 38, 141, 19.00, 5.00, '[null,null,\"19\"]', 'finish_product', '2024-04-30 13:24:50', '2024-04-30 13:24:50'),
(106, '2024-04-30', 39, 128, 500.00, 3000.00, '[null,\".5\",null]', 'raw_product', '2024-04-30 13:25:27', '2024-04-30 13:25:27'),
(107, '2024-04-30', 39, 130, 12.00, 150.00, '[null,null,\"12\"]', 'finish_product', '2024-04-30 13:25:27', '2024-04-30 13:25:27'),
(108, '2024-04-30', 40, 95, 2000.00, 820.00, '[null,\"2\",null]', 'raw_product', '2024-04-30 13:26:48', '2024-04-30 13:26:48'),
(109, '2024-04-30', 40, 96, 31.00, 60.00, '[null,null,\"31\"]', 'finish_product', '2024-04-30 13:26:48', '2024-04-30 13:26:48'),
(110, '2024-04-30', 41, 180, 1000.00, 140.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:29:40', '2024-04-30 13:29:40'),
(111, '2024-04-30', 41, 181, 11.00, 14.00, '[null,null,\"11\"]', 'finish_product', '2024-04-30 13:29:40', '2024-04-30 13:29:40'),
(112, '2024-04-30', 42, 179, 500.00, 2600.00, '[null,\".5\",null]', 'raw_product', '2024-04-30 13:31:40', '2024-04-30 13:31:40'),
(113, '2024-04-30', 42, 182, 11.00, 260.00, '[null,null,\"11\"]', 'finish_product', '2024-04-30 13:31:40', '2024-04-30 13:31:40'),
(114, '2024-04-30', 43, 86, 1000.00, 320.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:32:27', '2024-04-30 13:32:27'),
(115, '2024-04-30', 43, 87, 12.00, 31.00, '[null,null,\"12\"]', 'finish_product', '2024-04-30 13:32:27', '2024-04-30 13:32:27'),
(116, '2024-04-30', 44, 107, 1000.00, 1400.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:33:10', '2024-04-30 13:33:10'),
(117, '2024-04-30', 44, 109, 20.00, 60.00, '[null,null,\"20\"]', 'finish_product', '2024-04-30 13:33:10', '2024-04-30 13:33:10'),
(118, '2024-04-30', 45, 6, 1000.00, 1200.00, '[null,\"1\",null]', 'raw_product', '2024-04-30 13:33:47', '2024-04-30 13:33:47'),
(119, '2024-04-30', 45, 6, 12.00, 1200.00, '[null,null,\"12\"]', 'finish_product', '2024-04-30 13:33:47', '2024-04-30 13:33:47'),
(120, '2024-04-30', 46, 176, 3000.00, 960.00, '[null,\"3\",null]', 'raw_product', '2024-04-30 13:34:45', '2024-04-30 13:34:45'),
(121, '2024-04-30', 46, 177, 36.00, 76.80, '[null,null,\"36\"]', 'finish_product', '2024-04-30 13:34:45', '2024-04-30 13:34:45'),
(122, '2024-04-30', 47, 110, 25000.00, 140.00, '[null,\"25\",null]', 'raw_product', '2024-04-30 13:35:13', '2024-04-30 13:35:13'),
(123, '2024-04-30', 47, 111, 50.00, 200.00, '[null,null,\"50\"]', 'finish_product', '2024-04-30 13:35:13', '2024-04-30 13:35:13'),
(124, '2024-04-30', 48, 6, 12.00, 1200.00, '[null,null,\"12\"]', 'raw_product', '2024-04-30 17:44:53', '2024-04-30 17:44:53'),
(125, '2024-04-30', 48, 63, 12.00, 115.00, '[null,null,\"12\"]', 'finish_product', '2024-04-30 17:44:53', '2024-04-30 17:44:53'),
(126, '2024-05-02', 49, 191, 1000.00, 940.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(127, '2024-05-02', 49, 183, 1000.00, 940.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(128, '2024-05-02', 49, 192, 1000.00, 940.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(129, '2024-05-02', 49, 185, 1000.00, 940.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(130, '2024-05-02', 49, 189, 1000.00, 940.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(131, '2024-05-02', 49, 186, 1000.00, 1090.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(132, '2024-05-02', 49, 184, 1000.00, 950.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(133, '2024-05-02', 49, 196, 40.00, 193.00, '[null,null,\"40\"]', 'finish_product', '2024-05-02 11:54:07', '2024-05-02 11:54:07'),
(134, '2024-05-02', 50, 1, 1000.00, 1060.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(135, '2024-05-02', 50, 2, 1000.00, 1260.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(136, '2024-05-02', 50, 193, 1000.00, 350.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(137, '2024-05-02', 50, 194, 2000.00, 250.00, '[null,\"2\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(138, '2024-05-02', 50, 149, 1000.00, 720.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(139, '2024-05-02', 50, 190, 500.00, 880.00, '[null,\".5\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(140, '2024-05-02', 50, 188, 500.00, 640.00, '[null,\".5\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(141, '2024-05-02', 50, 32, 2000.00, 660.00, '[null,\"2\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(142, '2024-05-02', 50, 167, 1000.00, 350.00, '[null,\"1\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(143, '2024-05-02', 50, 3, 200.00, 2750.00, '[null,\".2\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(144, '2024-05-02', 50, 187, 3000.00, 270.00, '[null,\"3\",null]', 'raw_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(145, '2024-05-02', 50, 197, 10.00, 125.00, '[null,null,\"10\"]', 'finish_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(146, '2024-05-02', 50, 195, 51.00, 156.00, '[null,null,\"51\"]', 'finish_product', '2024-05-02 11:58:21', '2024-05-02 11:58:21'),
(147, '2024-05-04', 51, 188, 500.00, 640.00, '[null,\".5\",null]', 'raw_product', '2024-05-04 14:20:39', '2024-05-04 14:20:39'),
(148, '2024-05-04', 51, 190, 500.00, 880.00, '[null,\".5\",null]', 'raw_product', '2024-05-04 14:20:39', '2024-05-04 14:20:39'),
(149, '2024-05-04', 51, 201, 12.00, 32.00, '[null,null,\"12\"]', 'finish_product', '2024-05-04 14:20:39', '2024-05-04 14:20:39'),
(150, '2024-05-04', 51, 200, 6.00, 88.00, '[null,null,\"6\"]', 'finish_product', '2024-05-04 14:20:39', '2024-05-04 14:20:39'),
(151, '2024-05-04', 52, 165, 550.00, 1550.00, '[null,\".550\",null]', 'raw_product', '2024-05-04 14:21:09', '2024-05-04 14:21:09'),
(152, '2024-05-04', 52, 71, 6.00, 155.00, '[null,null,\"6\"]', 'finish_product', '2024-05-04 14:21:09', '2024-05-04 14:21:09'),
(153, '2024-05-04', 53, 8, 930.00, 3400.00, '[null,\".930\",null]', 'raw_product', '2024-05-04 14:26:06', '2024-05-04 14:26:06'),
(154, '2024-05-04', 53, 67, 6.00, 170.00, '[null,null,\"6\"]', 'finish_product', '2024-05-04 14:26:06', '2024-05-04 14:26:06'),
(155, '2024-05-04', 53, 9, 16.00, 340.00, '[null,null,\"16\"]', 'finish_product', '2024-05-04 14:26:06', '2024-05-04 14:26:06'),
(156, '2024-05-06', 54, 140, 3000.00, 60.00, '[null,\"3\",null]', 'raw_product', '2024-05-06 13:56:40', '2024-05-06 13:56:40'),
(157, '2024-05-06', 54, 141, 32.00, 6.00, '[null,null,\"32\"]', 'finish_product', '2024-05-06 13:56:40', '2024-05-06 13:56:40'),
(158, '2024-05-17', 55, 178, 2000.00, 400.00, '[null,\"2\",null]', 'raw_product', '2024-05-17 17:56:33', '2024-05-17 17:56:33'),
(159, '2024-05-17', 55, 208, 76.00, 10.00, '[null,null,\"76\"]', 'finish_product', '2024-05-17 17:56:33', '2024-05-17 17:56:33'),
(160, '2024-05-17', 56, 100, 1000.00, 400.00, '[null,\"1\",null]', 'raw_product', '2024-05-17 17:58:12', '2024-05-17 17:58:12'),
(161, '2024-05-17', 56, 102, 5.00, 80.00, '[null,null,\"5\"]', 'finish_product', '2024-05-17 17:58:12', '2024-05-17 17:58:12'),
(162, '2024-05-26', 57, 86, 2000.00, 320.00, '[null,\"2\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(163, '2024-05-26', 57, 149, 3000.00, 720.00, '[null,\"3\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(164, '2024-05-26', 57, 164, 1000.00, 288.00, '[null,\"1\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(165, '2024-05-26', 57, 104, 1000.00, 140.00, '[null,\"1\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(166, '2024-05-26', 57, 165, 2000.00, 1460.00, '[null,\"2\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(167, '2024-05-26', 57, 158, 2000.00, 240.00, '[null,\"2\",null]', 'raw_product', '2024-05-26 16:36:20', '2024-05-26 16:36:20'),
(168, '2024-05-26', 57, 144, 2000.00, 160.00, '[null,\"2\",null]', 'raw_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(169, '2024-05-26', 57, 211, 1000.00, 110.00, '[null,\"1\",null]', 'raw_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(170, '2024-05-26', 57, 106, 12.00, 11.67, '[null,null,\"12\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(171, '2024-05-26', 57, 155, 14.00, 60.00, '[null,null,\"14\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(172, '2024-05-26', 57, 150, 15.00, 90.00, '[null,null,\"15\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(173, '2024-05-26', 57, 71, 23.00, 127.00, '[null,null,\"23\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(174, '2024-05-26', 57, 175, 12.00, 24.00, '[null,null,\"12\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(175, '2024-05-26', 57, 87, 21.00, 31.00, '[null,null,\"21\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(176, '2024-05-26', 57, 159, 20.00, 24.00, '[null,null,\"20\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(177, '2024-05-26', 57, 145, 19.00, 16.85, '[null,null,\"19\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(178, '2024-05-26', 57, 212, 13.00, 8.47, '[null,null,\"13\"]', 'finish_product', '2024-05-26 16:36:21', '2024-05-26 16:36:21'),
(182, '2024-06-27', 58, 8, 1000.00, 3600.00, '[null,\"1\",null]', 'raw_product', '2024-06-27 20:51:20', '2024-06-27 20:51:20'),
(183, '2024-06-27', 58, 284, 20.00, 90.00, '[null,null,\"020\"]', 'finish_product', '2024-06-27 20:51:20', '2024-06-27 20:51:20'),
(184, '2024-06-27', 58, 28, 15.00, 180.00, '[null,null,\"015\"]', 'finish_product', '2024-06-27 20:51:20', '2024-06-27 20:51:20'),
(185, '2024-06-27', 59, 160, 5000.00, 280.00, '[null,\"5\",null]', 'raw_product', '2024-06-27 20:52:12', '2024-06-27 20:52:12'),
(186, '2024-06-27', 59, 161, 41.00, 28.00, '[null,null,\"041\"]', 'finish_product', '2024-06-27 20:52:12', '2024-06-27 20:52:12'),
(187, '2024-07-11', 60, 140, 5000.00, 50.00, '[\"5000\"]', 'raw_product', '2024-07-11 20:35:51', '2024-07-11 20:35:51'),
(188, '2024-07-11', 60, 141, 50.00, 6.00, '[\"50\"]', 'finish_product', '2024-07-11 20:35:51', '2024-07-11 20:35:51'),
(189, '2024-08-04', 61, 110, 25.00, 142.00, '[\"25\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(190, '2024-08-04', 61, 23, 3.00, 700.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(191, '2024-08-04', 61, 160, 5.00, 270.00, '[\"5\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(192, '2024-08-04', 61, 144, 3.00, 150.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(193, '2024-08-04', 61, 89, 5.00, 680.00, '[\"5\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(194, '2024-08-04', 61, 176, 3.00, 960.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(195, '2024-08-04', 61, 26, 3.00, 3300.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(196, '2024-08-04', 61, 8, 2.00, 3600.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(197, '2024-08-04', 61, 95, 2.00, 820.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:09', '2024-08-04 04:13:09'),
(198, '2024-08-04', 61, 72, 2.00, 310.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(199, '2024-08-04', 61, 128, 1.00, 3000.00, '[\"1\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(200, '2024-08-04', 61, 100, 3.00, 370.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(201, '2024-08-04', 61, 165, 2.00, 1460.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(202, '2024-08-04', 61, 107, 1.00, 1400.00, '[\"1\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(203, '2024-08-04', 61, 29, 2.00, 2700.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(204, '2024-08-04', 61, 140, 5.00, 50.00, '[\"5\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(205, '2024-08-04', 61, 164, 6.00, 340.00, '[\"6\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(206, '2024-08-04', 61, 6, 2.00, 1200.00, '[\"2\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(207, '2024-08-04', 61, 86, 5.00, 330.00, '[\"5\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(208, '2024-08-04', 61, 104, 4.21, 140.00, '[\"4.21\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(209, '2024-08-04', 61, 21, 5.00, 470.00, '[\"5\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(210, '2024-08-04', 61, 167, 3.00, 320.00, '[\"3\"]', 'raw_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(211, '2024-08-04', 61, 111, 23.00, 87.60, '[\"23\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(212, '2024-08-04', 61, 113, 70.00, 21.75, '[\"70\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(213, '2024-08-04', 61, 24, 135.00, 18.89, '[\"135\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(214, '2024-08-04', 61, 161, 25.00, 58.00, '[\"25\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(215, '2024-08-04', 61, 145, 29.00, 11.72, '[\"29\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(216, '2024-08-04', 61, 90, 37.00, 60.00, '[\"37\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(217, '2024-08-04', 61, 284, 68.00, 82.50, '[\"68\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(218, '2024-08-04', 61, 344, 53.00, 100.00, '[\"53\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(219, '2024-08-04', 61, 69, 24.00, 93.33, '[\"24\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(220, '2024-08-04', 61, 73, 24.00, 24.17, '[\"24\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(221, '2024-08-04', 61, 130, 32.00, 96.88, '[\"32\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(222, '2024-08-04', 61, 101, 8.00, 142.50, '[\"8\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(223, '2024-08-04', 61, 71, 36.00, 78.89, '[\"36\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(224, '2024-08-04', 61, 109, 17.00, 67.50, '[\"17\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(225, '2024-08-04', 61, 31, 54.00, 101.86, '[\"54\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(226, '2024-08-04', 61, 141, 57.00, 6.00, '[\"57\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(227, '2024-08-04', 61, 175, 49.00, 41.63, '[\"49\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(228, '2024-08-04', 61, 28, 34.00, 165.00, '[\"34\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(229, '2024-08-04', 61, 67, 13.00, 160.00, '[\"13\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(230, '2024-08-04', 61, 63, 23.00, 118.27, '[\"23\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(231, '2024-08-04', 61, 87, 49.00, 36.73, '[\"49\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(232, '2024-08-04', 61, 105, 50.00, 12.80, '[\"50\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(233, '2024-08-04', 61, 177, 40.00, 66.00, '[\"40\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(234, '2024-08-04', 61, 22, 48.00, 50.00, '[\"48\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(235, '2024-08-04', 61, 169, 30.00, 33.00, '[\"30\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(236, '2024-08-04', 61, 121, 12.00, 0.00, '[\"12\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(237, '2024-08-04', 61, 181, 22.00, 0.00, '[\"22\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(238, '2024-08-04', 61, 65, 13.00, 0.00, '[\"13\"]', 'finish_product', '2024-08-04 04:13:10', '2024-08-04 04:13:10'),
(239, '2024-08-05', 62, 114, 4.00, 420.00, '[\"4\"]', 'raw_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(240, '2024-08-05', 62, 98, 3.00, 140.00, '[\"3\"]', 'raw_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(241, '2024-08-05', 62, 115, 60.00, 28.00, '[\"60\"]', 'finish_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(242, '2024-08-05', 62, 99, 38.00, 11.05, '[\"38\"]', 'finish_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(243, '2024-08-05', 62, 42, 19.00, 0.00, '[\"19\"]', 'finish_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(244, '2024-08-05', 62, 48, 11.00, 0.00, '[\"11\"]', 'finish_product', '2024-08-05 09:56:12', '2024-08-05 09:56:12'),
(245, '2024-08-06', 63, 1, 10.00, 950.00, '[\"10\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(246, '2024-08-06', 63, 2, 4.00, 1400.00, '[\"4\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(247, '2024-08-06', 63, 3, 2.00, 2750.00, '[\"2\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(248, '2024-08-06', 63, 5, 1.00, 620.00, '[\"1\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(249, '2024-08-06', 63, 149, 3.00, 740.00, '[\"3\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(250, '2024-08-06', 63, 38, 5.00, 105.00, '[\"5\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(251, '2024-08-06', 63, 193, 3.00, 380.00, '[\"3\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(252, '2024-08-06', 63, 67, 0.50, 0.00, '[\".5\"]', 'raw_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(253, '2024-08-06', 63, 58, 16.00, 171.88, '[\"16\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(254, '2024-08-06', 63, 36, 30.00, 15.75, '[\"30\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(255, '2024-08-06', 63, 56, 20.00, 280.00, '[\"20\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(256, '2024-08-06', 63, 345, 15.00, 76.00, '[\"15\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(257, '2024-08-06', 63, 150, 15.00, 148.00, '[\"15\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(258, '2024-08-06', 63, 54, 50.00, 190.00, '[\"50\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(259, '2024-08-06', 63, 59, 21.00, 130.96, '[\"21\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(260, '2024-08-06', 63, 61, 10.00, 62.00, '[\"10\"]', 'finish_product', '2024-08-06 05:21:47', '2024-08-06 05:21:47'),
(261, '2024-08-14', 64, 75, 5.00, 290.00, '[\"5\"]', 'raw_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(262, '2024-08-14', 64, 216, 10.00, 260.00, '[\"10\"]', 'raw_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(263, '2024-08-14', 64, 213, 10.00, 260.00, '[\"10\"]', 'raw_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(264, '2024-08-14', 64, 176, 7.00, 960.00, '[\"7\"]', 'raw_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(265, '2024-08-14', 64, 392, 32.00, 132.00, '[\"32\"]', 'finish_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(266, '2024-08-14', 64, 389, 47.00, 52.00, '[\"47\"]', 'finish_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(267, '2024-08-14', 64, 390, 46.00, 52.00, '[\"46\"]', 'finish_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(268, '2024-08-14', 64, 391, 23.00, 58.00, '[\"23\"]', 'finish_product', '2024-08-14 12:15:57', '2024-08-14 12:15:57'),
(269, '2024-08-23', 65, 402, 3.00, 93.34, '[\"3\"]', 'raw_product', '2024-08-23 03:29:22', '2024-08-23 03:29:22'),
(270, '2024-08-23', 65, 401, 1.00, 210.00, '[\"1\"]', 'raw_product', '2024-08-23 03:29:22', '2024-08-23 03:29:22'),
(271, '2024-08-23', 65, 404, 16.00, 17.50, '[\"16\"]', 'finish_product', '2024-08-23 03:29:22', '2024-08-23 03:29:22'),
(272, '2024-08-23', 65, 405, 10.00, 21.00, '[\"10\"]', 'finish_product', '2024-08-23 03:29:22', '2024-08-23 03:29:22'),
(281, '2024-08-28', 66, 100, 5.00, 360.00, '[\"5\"]', 'raw_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(282, '2024-08-28', 66, 140, 5.00, 50.00, '[\"5\"]', 'raw_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(283, '2024-08-28', 66, 144, 10.00, 140.00, '[\"10\"]', 'raw_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(284, '2024-08-28', 66, 1, 3.00, 1020.00, '[\"3\"]', 'raw_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(285, '2024-08-28', 66, 2, 3.00, 1540.00, '[\"3\"]', 'raw_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(286, '2024-08-28', 66, 145, 44.00, 11.72, '[\"44\"]', 'finish_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(287, '2024-08-28', 66, 141, 99.00, 6.00, '[\"99\"]', 'finish_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(288, '2024-08-28', 66, 102, 25.00, 80.00, '[\"25\"]', 'finish_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(289, '2024-08-28', 66, 55, 36.00, 85.00, '[\"36\"]', 'finish_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(290, '2024-08-28', 66, 57, 35.00, 132.00, '[\"35\"]', 'finish_product', '2024-08-28 10:27:35', '2024-08-28 10:27:35'),
(306, '2024-08-31', 67, 100, 10.00, 360.00, '[\"10\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(307, '2024-08-31', 67, 38, 5.00, 100.00, '[\"5\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(308, '2024-08-31', 67, 149, 2.00, 850.00, '[\"2\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(309, '2024-08-31', 67, 23, 1.00, 1050.00, '[\"1\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(310, '2024-08-31', 67, 158, 6.00, 230.00, '[\"6\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(311, '2024-08-31', 67, 86, 5.00, 360.00, '[\"5\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(312, '2024-08-31', 67, 140, 10.00, 50.00, '[\"10\"]', 'raw_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(313, '2024-08-31', 67, 102, 52.00, 69.23, '[\"52\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(314, '2024-08-31', 67, 39, 46.00, 10.87, '[\"46\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(315, '2024-08-31', 67, 24, 48.00, 21.89, '[\"48\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(316, '2024-08-31', 67, 159, 98.00, 14.09, '[\"98\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(317, '2024-08-31', 67, 87, 46.00, 39.13, '[\"46\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(318, '2024-08-31', 67, 141, 42.00, 5.96, '[\"42\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(319, '2024-08-31', 67, 145, 45.00, 11.72, '[\"45\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(320, '2024-08-31', 67, 155, 18.00, 85.00, '[\"18\"]', 'finish_product', '2024-08-31 03:03:20', '2024-08-31 03:03:20'),
(321, '2024-09-30', 68, 72, 2.00, 260.00, '[\"2\"]', 'raw_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(322, '2024-09-30', 68, 104, 6.00, 140.00, '[\"6\"]', 'raw_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(323, '2024-09-30', 68, 73, 65.00, 6.00, '[\"65\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(324, '2024-09-30', 68, 141, 28.00, 5.96, '[\"28\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(325, '2024-09-30', 68, 417, 22.00, 20.00, '[\"22\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(326, '2024-09-30', 68, 105, 53.00, 12.80, '[\"53\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(327, '2024-09-30', 68, 153, 41.00, 52.00, '[\"41\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(328, '2024-09-30', 68, 65, 10.00, 220.00, '[\"10\"]', 'finish_product', '2024-09-30 03:22:39', '2024-09-30 03:22:39'),
(329, '2024-10-01', 69, 193, 12.00, 340.00, '[\"12\"]', 'raw_product', '2024-10-01 10:32:40', '2024-10-01 10:32:40'),
(330, '2024-10-01', 69, 345, 60.00, 68.00, '[\"60\"]', 'finish_product', '2024-10-01 10:32:40', '2024-10-01 10:32:40'),
(331, '2024-10-06', 70, 23, 1.00, 1050.00, '[\"1\"]', 'raw_product', '2024-10-06 06:17:01', '2024-10-06 06:17:01'),
(332, '2024-10-06', 70, 24, 41.00, 21.89, '[\"41\"]', 'finish_product', '2024-10-06 06:17:01', '2024-10-06 06:17:01'),
(333, '2024-10-09', 71, 165, 3500.00, 1400.00, '[null,\"3\",\"500\"]', 'raw_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(334, '2024-10-09', 71, 114, 10.00, 450.00, '[\"10\"]', 'raw_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(335, '2024-10-09', 71, 92, 3.00, 1660.00, '[\"3\"]', 'raw_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(336, '2024-10-09', 71, 89, 10.00, 660.00, '[\"10\"]', 'raw_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(337, '2024-10-09', 71, 8, 3.00, 3200.00, '[\"3\"]', 'raw_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(338, '2024-10-09', 71, 71, 52.00, 94.23, '[\"52\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(339, '2024-10-09', 71, 115, 100.00, 45.00, '[\"100\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(340, '2024-10-09', 71, 93, 42.00, 118.58, '[\"42\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(341, '2024-10-09', 71, 90, 41.00, 65.34, '[\"41\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(342, '2024-10-09', 71, 91, 30.00, 130.69, '[\"30\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(343, '2024-10-09', 71, 67, 40.00, 160.00, '[\"40\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(344, '2024-10-09', 71, 344, 45.00, 71.11, '[\"45\"]', 'finish_product', '2024-10-09 07:02:47', '2024-10-09 07:02:47'),
(345, '2024-10-12', 72, 160, 3.00, 280.00, '[\"3\"]', 'raw_product', '2024-10-12 06:15:26', '2024-10-12 06:15:26'),
(346, '2024-10-12', 72, 161, 29.00, 28.00, '[\"29\"]', 'finish_product', '2024-10-12 06:15:26', '2024-10-12 06:15:26'),
(347, '2024-10-19', 73, 2, 10.00, 1720.00, '[\"10\"]', 'raw_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(348, '2024-10-19', 73, 167, 5.00, 320.00, '[\"5\"]', 'raw_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(349, '2024-10-19', 73, 100, 13.00, 520.00, '[\"13\"]', 'raw_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(350, '2024-10-19', 73, 169, 56.00, 28.58, '[\"56\"]', 'finish_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(351, '2024-10-19', 73, 102, 38.00, 104.00, '[\"38\"]', 'finish_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(352, '2024-10-19', 73, 57, 51.00, 172.00, '[\"51\"]', 'finish_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(353, '2024-10-19', 73, 56, 21.00, 344.00, '[\"21\"]', 'finish_product', '2024-10-19 05:40:43', '2024-10-19 05:40:43'),
(354, '2024-10-22', 74, 26, 2.00, 4100.00, '[\"2\"]', 'raw_product', '2024-10-22 02:45:58', '2024-10-22 02:45:58'),
(355, '2024-10-22', 74, 284, 45.00, 102.50, '[\"45\"]', 'finish_product', '2024-10-22 02:45:58', '2024-10-22 02:45:58'),
(356, '2024-10-22', 74, 28, 20.00, 205.00, '[\"20\"]', 'finish_product', '2024-10-22 02:45:58', '2024-10-22 02:45:58'),
(357, '2024-10-23', 75, 32, 10.00, 640.00, '[\"10\"]', 'raw_product', '2024-10-23 03:10:33', '2024-10-23 03:10:33'),
(358, '2024-10-23', 75, 286, 12.00, 320.00, '[\"12\"]', 'finish_product', '2024-10-23 03:10:33', '2024-10-23 03:10:33'),
(359, '2024-10-23', 75, 33, 39.00, 64.00, '[\"39\"]', 'finish_product', '2024-10-23 03:10:33', '2024-10-23 03:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_type` enum('raw_material','finish_product') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'finish_product',
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `subcategory_id` bigint UNSIGNED DEFAULT NULL,
  `brand_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `price_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sale_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wholesale_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock_alert` decimal(10,2) NOT NULL DEFAULT '0.00',
  `divisor_number` decimal(10,2) NOT NULL,
  `quantity_in_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `product_type`, `barcode`, `unit_id`, `category_id`, `subcategory_id`, `brand_id`, `branch_id`, `user_id`, `price_type`, `purchase_price`, `sale_price`, `wholesale_price`, `stock_alert`, `divisor_number`, `quantity_in_unit`, `status`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Almond-1kg কাটবাদাম', 'finish_product', '00000001', 2, 1, 2, 1, 1, 1, '0', 1050.00, 1200.00, 1400.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 14:21:06', '2024-09-17 09:13:45'),
(2, 'Cashew-1kg কাজু বাদাম', 'finish_product', '00000002', 2, 1, 2, 1, 1, 1, '0', 1720.00, 1700.00, 2000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 14:24:41', '2024-10-19 05:34:48'),
(3, 'Pistachio-1kg-পেস্তা বাদাম', 'finish_product', 'Pistachio-1kg', 2, 1, 2, 1, 1, 1, '0', 2700.00, 3800.00, 4400.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 14:27:51', '2024-09-17 09:13:45'),
(4, 'peanuts-1kg-চিনা বাদাম', 'finish_product', 'peanuts-1kg', 2, 1, 2, 1, 1, 1, '0', 165.00, 250.00, 380.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 14:31:42', '2024-07-24 15:03:27'),
(5, 'Raisins-1kg-কিশমিশ', 'finish_product', 'Raisins-1kg', 2, 1, 2, 1, 1, 1, '0', 620.00, 790.00, 1000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 14:34:37', '2024-08-06 05:00:31'),
(6, 'Imperial Cumin-1kg শাহী জিরা', 'finish_product', 'Imperial Cumin-1kg', 2, 3, NULL, 1, 1, 1, '0', 1220.00, 1750.00, 2300.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-03 15:14:52', '2024-10-19 05:34:48'),
(7, 'poppy seeds-1kg-পোস্ত দানা', 'finish_product', 'poppy seeds-1kg', 2, 3, NULL, 1, 1, 1, '0', 2050.00, 2900.00, 3500.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-03 15:19:11', '2024-04-16 12:07:09'),
(8, 'Cordamom-1kg- এলাচ', 'finish_product', 'Cordamom-1kg', 2, 3, NULL, 1, 1, 1, '0', 3200.00, 4400.00, 5400.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-03 15:23:02', '2024-10-07 23:50:55'),
(9, 'Cordamom-25gm- এলাচ', 'finish_product', 'Cordamom-100gm', 2, 3, NULL, 1, 1, 1, '0', 340.00, 430.00, 500.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-03 15:35:53', '2024-10-09 06:47:38'),
(15, 'Corn Flour-1Kg', 'finish_product', '00000015', 2, 4, NULL, 2, 1, 1, '0', 200.00, 450.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 11:50:23', '2024-04-29 13:57:45'),
(16, 'Corn Flour-100gm', 'finish_product', '00000016', 2, 4, NULL, 1, 1, 1, '0', 20.00, 45.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 11:57:24', '2024-04-30 17:16:17'),
(17, 'Custard-1kg', 'finish_product', '00000017', 2, 4, NULL, 2, 1, 1, '0', 185.00, 450.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:22:29', '2024-05-05 19:57:17'),
(18, 'Custard-100gm', 'finish_product', '00000018', 2, 4, NULL, 1, 1, 1, '0', 20.00, 45.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:23:17', '2024-04-30 17:16:47'),
(19, 'Baking-1kg', 'finish_product', '00000019', 2, 4, NULL, 2, 1, 1, '0', 170.00, 450.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:26:17', '2024-08-25 12:49:34'),
(20, 'Baking-100gm', 'finish_product', '00000020', 2, 4, NULL, 1, 1, 1, '0', 20.00, 45.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:26:52', '2024-04-30 17:17:07'),
(21, 'Alu Bukhara-1kg', 'finish_product', '00000021', 2, 3, NULL, 2, 1, 1, '0', 480.00, 7500.00, 9500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:30:00', '2024-10-06 06:07:01'),
(22, 'Alu Bukhara-100gm', 'finish_product', '00000022', 2, 3, NULL, 1, 1, 1, '0', 50.00, 75.00, 95.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 12:32:00', '2024-08-04 03:49:19'),
(23, 'Nutmeg-1kg-জায়ফল', 'finish_product', '00000023', 2, 3, NULL, 2, 1, 1, '0', 1150.00, 1150.00, 1600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:42:50', '2024-10-19 05:34:48'),
(24, 'Nutmeg-4pcs-জায়ফল', 'finish_product', '00000024', 2, 3, NULL, 1, 1, 1, '0', 21.89, 35.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 12:46:18', '2024-08-31 02:57:46'),
(26, 'Green Cardamom-1kg-সবুজ এলাচ', 'finish_product', '00000025', 2, 3, NULL, 2, 1, 1, '0', 4100.00, 4100.00, 4800.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:48:28', '2024-10-19 05:34:48'),
(27, 'Green Cardamom-100gm-সবুজ এলাচ', 'finish_product', '00000027', 2, 3, NULL, 1, 1, 1, '0', 380.00, 500.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:51:35', '2024-04-30 17:11:34'),
(28, 'Green Cardamom-50gm-সবুজ এলাচ', 'finish_product', '00000028', 2, 3, NULL, 1, 1, 1, '0', 205.00, 255.00, 295.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 12:54:58', '2024-10-22 02:45:58'),
(29, 'Black Cardamom-1kg-কালো এলাচ', 'finish_product', '00000029', 2, 3, NULL, 2, 1, 1, '0', 2600.00, 3400.00, 4000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:56:06', '2024-10-19 05:34:48'),
(30, 'Black Cardamom-100gm-কালো এলাচ', 'finish_product', '00000030', 2, 3, NULL, 1, 1, 1, '0', 30.00, 43.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 12:57:44', '2024-04-16 12:40:01'),
(31, 'Black Cardamom-50gm-কালো এলাচ', 'finish_product', '00000031', 2, 3, NULL, 1, 1, 1, '0', 101.86, 150.00, 190.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 12:58:53', '2024-08-04 03:33:41'),
(32, 'Raisin-1kg-কিশমিশ', 'finish_product', '00000032', 2, 3, NULL, 2, 1, 1, '0', 640.00, 800.00, 950.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:39:25', '2024-10-19 05:34:48'),
(33, 'Raisin-100gm-কিশমিশ', 'finish_product', '00000033', 2, 3, NULL, 1, 1, 1, '0', 64.00, 80.00, 100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:40:37', '2024-10-23 03:10:33'),
(34, 'Raisin-50gm-কিশমিশ', 'finish_product', '00000034', 2, 3, NULL, 1, 1, 1, '0', 14.00, 20.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:41:49', '2024-04-16 12:40:01'),
(35, 'Black Mustard-1kg-কালো সরিষা', 'finish_product', '00000035', 2, 3, NULL, 2, 1, 1, '0', 100.00, 400.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:45:18', '2024-04-29 13:57:45'),
(36, 'Black Mustard-150gm-কালো সরিষা', 'finish_product', '00000036', 2, 3, NULL, 1, 1, 1, '0', 15.75, 35.00, 55.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 13:46:32', '2024-08-06 05:08:12'),
(37, 'Black Mustard-50gm-কালো সরিষা', 'finish_product', '00000037', 2, 3, NULL, 1, 1, 1, '0', 5.00, 20.00, 30.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:47:22', '2024-04-30 17:14:49'),
(38, 'Mustard-1kg-সরিষা', 'finish_product', '00000038', 2, 3, NULL, 2, 1, 1, '0', 120.00, 400.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:48:16', '2024-10-19 05:34:48'),
(39, 'Mustard-100gm-সরিষা', 'finish_product', '00000039', 2, 3, NULL, 1, 1, 1, '0', 10.87, 40.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:49:01', '2024-08-31 02:57:46'),
(40, 'Mustard-50gm-সরিষা', 'finish_product', '00000040', 2, 3, NULL, 1, 1, 1, '0', 6.00, 20.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:49:26', '2024-04-16 12:40:01'),
(41, 'Talmakhana-1kg', 'finish_product', '00000041', 2, 1, NULL, 2, 1, 1, '0', 400.00, 800.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:51:08', '2024-04-16 12:40:01'),
(42, 'Talmakhana-100gm', 'finish_product', '00000042', 2, 1, NULL, 1, 1, 1, '0', 0.00, 70.00, 90.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:52:04', '2024-08-05 09:56:12'),
(43, 'Talmakhana-50gm', 'finish_product', '00000043', 2, 1, NULL, 1, 1, 1, '0', 20.00, 40.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:53:53', '2024-04-16 12:40:01'),
(44, 'Walnut-1kg-আখরোট', 'finish_product', '00000044', 2, 3, NULL, 2, 1, 1, '0', 1000.00, 1600.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:55:40', '2024-04-16 12:40:01'),
(45, 'Walnut-100gm-আখরোট', 'finish_product', '00000045', 2, 3, NULL, 1, 1, 1, '0', 100.00, 160.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 13:56:26', '2024-04-16 12:40:01'),
(46, 'Walnut-50gm-আখরোট', 'finish_product', '00000046', 2, 3, NULL, 1, 1, 1, '0', 50.00, 80.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 14:00:13', '2024-04-16 12:40:01'),
(47, 'Katila Gum-1kg', 'finish_product', '00000047', 2, 3, NULL, 2, 1, 1, '0', 150.00, 500.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 14:01:21', '2024-04-16 12:40:01'),
(48, 'Katila Gum-100gm', 'finish_product', '00000048', 2, 3, NULL, NULL, 1, 1, '0', 0.00, 75.00, 105.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 14:02:48', '2024-08-05 09:56:12'),
(49, 'Katila Gum-50gm', 'finish_product', '00000049', 2, 3, NULL, 1, 1, 1, '0', 8.00, 25.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 14:03:25', '2024-04-16 12:40:01'),
(51, 'mar-24', 'finish_product', '00000051', 2, 3, NULL, NULL, 1, 1, '0', 71854.00, 98244.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 15:32:17', '2024-04-16 12:40:01'),
(52, '1a', 'finish_product', '00000052', 2, 3, NULL, 2, 1, 1, '0', 373810.00, 412000.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 18:51:09', '2024-08-21 03:09:54'),
(53, '2v', 'finish_product', '00000053', 2, 3, NULL, NULL, 1, 1, '0', 45.00, 50.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 19:22:21', '2024-08-15 07:55:51'),
(54, 'Almond-200gm কাটবাদাম', 'finish_product', '00000054', 2, 1, 2, 1, 1, 1, '0', 190.00, 245.00, 280.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:45:25', '2024-08-06 05:16:24'),
(55, 'Almond-90gm কাটবাদাম', 'finish_product', '00000055', 2, 1, 2, 1, 1, 1, '0', 85.00, 120.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:46:22', '2024-08-28 10:25:28'),
(56, 'Cashew-200gm কাজু বাদাম', 'finish_product', '00000056', 2, 1, 2, 1, 1, 1, '0', 344.00, 420.00, 480.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:47:17', '2024-10-19 05:40:43'),
(57, 'Cashew-90gm কাজু বাদাম', 'finish_product', '00000057', 2, 1, 2, 1, 1, 1, '0', 172.00, 210.00, 240.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:48:59', '2024-10-19 05:40:43'),
(58, 'Pistachio-80gm-পেস্তা বাদাম', 'finish_product', '00000058', 2, 1, 2, 1, 1, 1, '0', 171.88, 260.00, 335.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:50:33', '2024-08-06 05:06:50'),
(59, 'Pistachio-50gm-পেস্তা বাদাম', 'finish_product', '00000059', 2, 1, 2, 1, 1, 1, '0', 130.96, 190.00, 220.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-04 21:51:40', '2024-08-06 05:14:55'),
(60, 'peanuts-110gm-চিনা বাদাম', 'finish_product', '00000060', 2, 1, 2, 1, 1, 1, '0', 18.10, 35.00, 50.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-04 21:53:12', '2024-04-17 11:15:17'),
(61, 'Raisins-100gm-কিশমিশ', 'finish_product', '00000061', 2, 1, NULL, 1, 1, 1, '0', 62.00, 75.00, 90.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 17:59:38', '2024-08-06 05:21:47'),
(62, 'Raisins-50gm-কিশমিশ', 'finish_product', '00000062', 2, 1, NULL, 1, 1, 1, '0', 28.00, 40.00, 50.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 18:01:00', '2024-04-16 12:40:01'),
(63, 'Imperial Cumin-100gm শাহী জিরা', 'finish_product', '00000063', 2, 3, NULL, 1, 1, 1, '0', 84.38, 140.00, 200.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-05 18:03:42', '2024-10-06 06:07:01'),
(64, 'Imperial Cumin-50gm শাহী জিরা', 'finish_product', '00000064', 2, 3, NULL, 1, 1, 1, '0', 0.00, 88.00, 115.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 18:05:07', '2024-05-04 14:28:12'),
(65, 'poppy seeds-200gm-পোস্ত দানা', 'finish_product', '00000065', 2, 3, NULL, 1, 1, 1, '0', 220.00, 290.00, 380.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-05 18:06:16', '2024-09-30 03:14:48'),
(66, 'poppy seeds-55gm-পোস্ত দানা', 'finish_product', '00000066', 2, 3, NULL, 1, 1, 1, '0', 115.50, 155.00, 175.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 18:07:05', '2024-04-17 11:26:39'),
(67, 'Cordamom-50gm- এলাচ', 'finish_product', '00000067', 2, 3, NULL, 1, 1, 1, '0', 160.00, 210.00, 260.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-05 18:09:41', '2024-10-09 07:02:47'),
(68, 'White Pepper Whole-50gm-সাদা গোল মরিচ', 'finish_product', '00000068', 2, 3, NULL, 1, 1, 1, '0', 0.00, 85.00, 90.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 18:27:40', '2024-04-16 12:40:01'),
(69, 'black Pepper Whole-80gm-কালো গোল মরিচ', 'finish_product', '00000069', 2, 3, NULL, 1, 1, 1, '0', 93.33, 130.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-05 18:30:26', '2024-08-04 03:16:36'),
(70, 'black Pepper Whole-50gm-কালো গোল মরিচ', 'finish_product', '00000070', 2, 3, NULL, 1, 1, 1, '0', 0.00, 85.00, 100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-05 18:31:50', '2024-04-16 12:40:01'),
(71, 'Clove-80gm-লবঙ্গ', 'finish_product', '00000071', 2, 3, NULL, 1, 1, 1, '0', 94.23, 140.00, 195.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-05 18:34:36', '2024-10-09 07:02:47'),
(72, 'Panch phoron-1kg-পাঁচ ফোড়ন', 'finish_product', '00000072', 2, 3, NULL, 2, 1, 1, '0', 320.00, 800.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 08:51:27', '2024-10-19 05:34:48'),
(73, 'Panch phoron-25gm-পাঁচ ফোড়ন', 'finish_product', '00000073', 2, 3, NULL, 1, 1, 1, '0', 6.00, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 09:01:49', '2024-09-30 03:16:51'),
(74, 'Panch phoron-50gm-পাঁচ ফোড়ন', 'finish_product', '00000074', 2, 3, NULL, 1, 1, 1, '0', 15.50, 40.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:02:18', '2024-04-16 12:40:01'),
(75, 'Coriander-1kg-ধনে', 'finish_product', '00000075', 2, 3, NULL, 2, 1, 1, '0', 290.00, 650.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:03:39', '2024-04-16 12:40:01'),
(76, 'Coriander-100gm-ধনে', 'finish_product', '00000076', 2, 3, NULL, 1, 1, 1, '0', 29.00, 65.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:05:28', '2024-04-16 12:40:01'),
(77, 'Coriander-50gm-ধনে', 'finish_product', '00000077', 2, 3, NULL, 1, 1, 1, '0', 15.00, 33.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:06:45', '2024-04-16 12:40:01'),
(81, 'Soda-1kg', 'finish_product', '00000081', 2, 4, NULL, 2, 1, 1, '0', 75.00, 250.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:37:40', '2024-08-25 12:49:34'),
(82, 'Soda-100gm', 'finish_product', '00000082', 2, 4, NULL, 1, 1, 1, '0', 5.00, 25.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:38:49', '2024-04-16 12:40:01'),
(83, 'Fennel-1kg-মৌরি', 'finish_product', '00000083', 2, 3, NULL, 2, 1, 1, '0', 160.00, 340.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:40:03', '2024-06-25 21:50:18'),
(84, 'Fennel-100gm-মৌরি', 'finish_product', '00000084', 2, 3, NULL, 1, 1, 1, '0', 10.40, 40.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:41:03', '2024-07-24 15:03:27'),
(85, 'Fennel-50gm-মৌরি', 'finish_product', '00000085', 2, 3, NULL, 1, 1, 1, '0', 13.00, 30.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:41:47', '2024-04-16 12:40:01'),
(86, 'Black Seeds-1kg-কালো বীজ', 'finish_product', '00000086', 2, 3, NULL, 2, 1, 1, '0', 360.00, 700.00, 1100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:46:47', '2024-08-25 12:49:34'),
(87, 'Black Seeds-110gm-কালো বীজ', 'finish_product', '00000087', 2, 3, NULL, 1, 1, 1, '0', 40.91, 70.00, 95.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 09:47:30', '2024-10-06 06:07:01'),
(88, 'Black Seeds-50gm-কালো বীজ', 'finish_product', '00000088', 2, 3, NULL, 1, 1, 1, '0', 16.00, 35.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:48:03', '2024-04-16 12:40:01'),
(89, 'Cumin-1kg-জিরা', 'finish_product', '00000089', 2, 3, NULL, 2, 1, 1, '0', 660.00, 850.00, 1000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:49:00', '2024-10-07 23:50:55'),
(90, 'Cumin-100gm-জিরা', 'finish_product', '00000090', 2, 3, NULL, 1, 1, 1, '0', 65.34, 80.00, 105.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 09:49:30', '2024-10-09 07:02:47'),
(91, 'Cumin-200gm-জিরা', 'finish_product', '00000091', 2, 3, NULL, 1, 1, 1, '0', 130.69, 160.00, 210.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 09:49:59', '2024-10-09 07:02:47'),
(92, 'White pepper-1kg-সাদা গোলমরিচ', 'finish_product', '00000092', 2, 3, NULL, 2, 1, 1, '0', 1660.00, 2200.00, 2600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:54:05', '2024-10-07 23:50:55'),
(93, 'White pepper-80gm-সাদা গোলমরিচ', 'finish_product', '00000093', 2, 3, NULL, 1, 1, 1, '0', 118.58, 145.00, 185.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 09:54:45', '2024-10-09 07:02:47'),
(94, 'White pepper-50gm-সাদা গোলমরিচ', 'finish_product', '00000094', 2, 3, NULL, 1, 1, 1, '0', 30.00, 45.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:55:18', '2024-04-16 12:40:01'),
(95, 'Black Pepper-1kg-কালো গুলমরিচ', 'finish_product', '00000095', 2, 3, NULL, 2, 1, 1, '0', 1050.00, 1300.00, 1600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:56:45', '2024-10-19 05:34:48'),
(96, 'Black Pepper-100gm-কালো গুলমরিচ', 'finish_product', '00000096', 2, 3, NULL, 1, 1, 1, '0', 105.00, 90.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:57:05', '2024-08-31 02:39:26'),
(97, 'Black Pepper-50gm-কালো গুলমরিচ', 'finish_product', '00000097', 2, 3, NULL, 1, 1, 1, '0', 30.00, 45.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 09:57:54', '2024-04-16 12:40:01'),
(98, 'Bay Leaf-1kg-তেজপাতা', 'finish_product', '00000098', 2, 3, NULL, 2, 1, 1, '0', 140.00, 250.00, 350.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:06:46', '2024-06-27 11:05:18'),
(99, 'Bay Leaf-80gm-তেজপাতা', 'finish_product', '00000099', 2, 3, NULL, 1, 1, 1, '0', 9.33, 20.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:08:28', '2024-10-06 06:07:01'),
(100, 'Chia Seeds-1kg', 'finish_product', '00000100', 2, 1, NULL, 2, 1, 1, '0', 520.00, 800.00, 1100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:09:27', '2024-10-19 05:34:48'),
(101, 'Chia Seeds-350gm', 'finish_product', '00000101', 2, 1, NULL, 1, 1, 1, '0', 142.50, 250.00, 340.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:10:25', '2024-08-04 03:24:24'),
(102, 'Chia Seeds-200gm', 'finish_product', '00000102', 2, 1, NULL, 1, 1, 1, '0', 104.00, 160.00, 220.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:11:22', '2024-10-19 05:40:43'),
(103, 'Chia Seeds-110gm', 'finish_product', '00000103', 2, 1, NULL, 1, 1, 1, '0', 49.50, 88.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:12:06', '2024-04-17 11:14:05'),
(104, 'Fenugreek-1kg-মেথি', 'finish_product', '00000104', 1, 1, NULL, 2, 1, 1, '1', 130.00, 400.00, 0.00, 0.00, 1000.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:16:47', '2024-10-19 05:34:48'),
(105, 'Fenugreek-100gm-মেথি', 'finish_product', '00000105', 2, 1, NULL, 1, 1, 1, '0', 12.80, 30.00, 45.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:17:24', '2024-08-04 03:45:01'),
(106, 'Fenugreek-50gm-মেথি', 'finish_product', '00000106', 2, 1, NULL, 1, 1, 1, '0', 11.67, 20.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:17:58', '2024-05-26 16:36:21'),
(107, 'Star Masala-1kg', 'finish_product', '00000107', 2, 3, NULL, 2, 1, 1, '0', 1300.00, 2800.00, 3500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:19:03', '2024-10-19 05:34:48'),
(108, 'Star Masala-100gm', 'finish_product', '00000108', 2, 3, NULL, 1, 1, 1, '0', 0.00, 140.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:19:36', '2024-08-04 04:32:41'),
(109, 'Star Masala-50gm', 'finish_product', '00000109', 2, 3, NULL, 1, 1, 1, '0', 67.50, 110.00, 140.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:20:09', '2024-08-04 03:29:11'),
(110, 'Sabudana-1kg', 'finish_product', '00000110', 2, 1, NULL, 2, 1, 1, '0', 146.00, 240.00, 350.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:25:36', '2024-09-08 09:59:15'),
(111, 'Sabudana-600gm', 'finish_product', '00000111', 2, 1, NULL, 1, 1, 1, '0', 87.60, 160.00, 210.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:26:17', '2024-08-04 02:56:41'),
(112, 'Sabudana-200gm', 'finish_product', '00000112', 2, 1, NULL, 1, 1, 1, '0', 36.50, 70.00, 110.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:27:11', '2024-10-06 06:07:01'),
(113, 'Sabudana-150gm', 'finish_product', '00000113', 2, 1, NULL, 1, 1, 1, '0', 21.75, 40.00, 55.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 10:28:13', '2024-08-04 02:58:30'),
(114, 'Cinnamon-1kg-দারুচিনি', 'finish_product', '00000114', 2, 3, NULL, 2, 1, 1, '0', 450.00, 700.00, 950.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:56:54', '2024-10-07 23:50:55'),
(115, 'Cinnamon-100gm-দারুচিনি', 'finish_product', '00000115', 2, 3, NULL, 1, 1, 1, '0', 45.00, 65.00, 85.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:58:39', '2024-10-09 07:02:47'),
(116, 'Cinnamon-50gm-দারুচিনি', 'finish_product', '00000116', 2, 3, NULL, 1, 1, 1, '0', 50.00, 65.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 10:59:24', '2024-04-16 12:40:01'),
(117, 'Cinnamon-25gm-দারুচিনি', 'finish_product', '00000117', 2, 3, NULL, 1, 1, 1, '0', 25.00, 33.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:00:29', '2024-04-16 12:40:01'),
(118, 'Tokma-1kg', 'finish_product', '00000118', 2, 1, NULL, 2, 1, 1, '0', 80.00, 520.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:02:32', '2024-04-16 12:40:01'),
(119, 'Tokma-200gm', 'finish_product', '00000119', 2, 1, NULL, 1, 1, 1, '0', 34.00, 104.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:03:36', '2024-04-16 12:40:01'),
(120, 'Tokma-110gm', 'finish_product', '00000120', 2, 1, NULL, 1, 1, 1, '0', 18.70, 52.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:04:51', '2024-04-17 11:17:58'),
(121, 'Tokma-80gm', 'finish_product', '00000121', 2, 1, NULL, 1, 1, 1, '0', 0.00, 26.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 11:05:47', '2024-08-04 03:52:03'),
(125, 'Sesame-1kg-তিল', 'finish_product', '00000125', 2, 3, NULL, 2, 1, 1, '0', 350.00, 750.00, 1000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:29:04', '2024-04-19 00:30:12'),
(126, 'Sesame-100gm-তিল', 'finish_product', '00000126', 2, 3, NULL, 1, 1, 1, '0', 35.00, 70.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:29:42', '2024-04-16 12:40:01'),
(127, 'Sesame-50gm-তিল', 'finish_product', '00000127', 2, 3, NULL, 1, 1, 1, '0', 18.00, 35.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 11:30:20', '2024-04-16 12:40:01'),
(128, 'Jatrik-1kg', 'finish_product', '00000128', 2, 3, NULL, 2, 1, 1, '0', 2900.00, 4000.00, 5000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 12:40:55', '2024-10-19 05:34:48'),
(129, 'Jatrik-100gm', 'finish_product', '00000129', 2, 3, NULL, 1, 1, 1, '0', 300.00, 450.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 12:41:37', '2024-04-16 12:40:01'),
(130, 'Jatrik-30gm', 'finish_product', '00000130', 2, 3, NULL, 1, 1, 1, '0', 96.88, 120.00, 145.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-06 12:42:14', '2024-08-04 03:22:06'),
(131, 'Jhali-1kg', 'finish_product', '00000131', 2, 3, NULL, 2, 1, 1, '0', 60.00, 200.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 12:48:29', '2024-04-16 12:40:01'),
(132, 'Jhali-100gm', 'finish_product', '00000132', 2, 3, NULL, 1, 1, 1, '0', 6.00, 20.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-06 12:49:06', '2024-04-16 12:40:01'),
(133, 'Sugar Candy -1kg-তাল মিস্রি', 'finish_product', '00000133', 2, 1, NULL, 2, 1, 1, '0', 240.00, 400.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 16:33:13', '2024-04-16 12:40:01'),
(134, 'Sugar Candy -100gm-তাল মিস্রি', 'finish_product', '00000134', 2, 1, NULL, 1, 1, 1, '0', 24.00, 40.00, 50.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 16:37:17', '2024-04-16 12:40:01'),
(135, 'Psyllium Husk-1kg-ইসুবগুলের ভুষি', 'finish_product', '00000135', 2, 1, NULL, 2, 1, 1, '0', 1920.00, 2100.00, 2250.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:04:16', '2024-04-16 12:40:01'),
(136, 'Psyllium Husk-110gm-ইসুবগুলের ভুষি', 'finish_product', '00000136', 2, 1, NULL, 1, 1, 1, '0', 211.20, 232.00, 250.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:06:01', '2024-04-17 11:22:03'),
(137, 'Psyllium Husk-55gm-ইসুবগুলের ভুষি', 'finish_product', '00000137', 2, 1, NULL, 1, 1, 1, '0', 105.60, 116.00, 125.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:07:41', '2024-04-17 11:23:55'),
(140, 'Rock Salt-1kg-বিট লবণ', 'finish_product', '00000140', 2, 3, NULL, 2, 1, 1, '0', 55.00, 350.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:13:07', '2024-09-08 09:59:15'),
(141, 'Rock Salt-100gm-বিট লবণ', 'finish_product', '00000141', 2, 3, NULL, 1, 1, 1, '0', 5.96, 35.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-15 17:14:17', '2024-08-31 02:57:46'),
(142, 'Black Salt-1kg', 'finish_product', '00000142', 2, 3, NULL, 2, 1, 1, '0', 70.00, 400.00, 550.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:16:48', '2024-04-16 12:40:01'),
(143, 'Black Salt-110gm', 'finish_product', '00000143', 2, 3, NULL, 1, 1, 1, '0', 7.70, 40.00, 55.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:17:33', '2024-04-17 11:16:35'),
(144, 'Pink Salt-1kg', 'finish_product', '00000144', 2, 3, NULL, 2, 1, 1, '0', 200.00, 750.00, 1000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:19:48', '2024-10-19 05:34:48'),
(145, 'Pink Salt-100gm', 'finish_product', '00000145', 2, 3, NULL, 1, 1, 1, '0', 11.72, 55.00, 85.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-15 17:20:54', '2024-08-04 03:07:28'),
(149, 'Pumkin Seeds-1kg', 'finish_product', '00000149', 2, 1, 2, 2, 1, 1, '0', 850.00, 1150.00, 1500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-15 17:26:37', '2024-08-31 02:39:26'),
(150, 'Pumkin Seeds-200gm', 'finish_product', '00000150', 2, 1, 2, 1, 1, 1, '0', 148.00, 220.00, 280.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-15 17:27:37', '2024-08-06 05:14:04'),
(151, 'Pipe Bottle', 'finish_product', '00000151', 2, 4, NULL, 2, 1, 1, '0', 0.00, 80.00, 120.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-16 12:19:42', '2024-04-16 12:40:01'),
(152, 'Baby Bottle', 'finish_product', '00000152', 2, 4, NULL, 2, 1, 1, '0', 0.00, 60.00, 90.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-16 12:20:48', '2024-04-16 12:40:01'),
(153, 'poppy seeds-25gm-পোস্ত দানা', 'finish_product', '00000153', 2, 3, NULL, 1, 1, 1, '0', 52.00, 75.00, 105.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-17 11:30:01', '2024-09-30 03:15:32'),
(154, 'Chia Seeds-50gm', 'finish_product', '00000154', 2, 1, NULL, 1, 1, 1, '0', 22.50, 40.00, 55.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-17 11:53:43', '2024-04-17 11:53:43'),
(155, 'Pumkin Seeds-100gm', 'finish_product', '00000155', 2, 1, 2, 1, 1, 1, '0', 85.00, 115.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-17 11:57:19', '2024-08-31 02:59:08'),
(156, 'Sugar Candy -200gm-তাল মিস্রি', 'finish_product', '00000156', 2, 1, NULL, 1, 1, 1, '0', 48.00, 80.00, 100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-17 12:03:28', '2024-04-17 12:03:28'),
(157, 'Irani Saffron-0.2gm', 'finish_product', '00000157', 2, 3, NULL, 1, 1, 1, '0', 72.00, 100.00, 150.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-20 20:40:27', '2024-10-19 05:34:48'),
(158, 'Yeast-0.5kg', 'finish_product', '00000158', 2, 4, NULL, 2, 1, 1, '0', 260.00, 400.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-20 20:43:08', '2024-10-19 05:34:48'),
(159, 'Yeast-30gm', 'finish_product', '00000159', 2, 4, NULL, 1, 1, 1, '0', 14.09, 40.00, 65.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-20 20:44:09', '2024-08-31 03:01:53'),
(160, 'Cherry-1kg', 'finish_product', '00000160', 2, 1, NULL, 2, 1, 1, '0', 280.00, 420.00, 1000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-23 19:15:23', '2024-08-31 02:39:25'),
(161, 'Cherry-100gm', 'finish_product', '00000161', 2, 1, NULL, 1, 1, 1, '0', 28.00, 60.00, 85.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-23 19:17:02', '2024-10-12 06:14:47'),
(162, 'Morobba-1kg', 'finish_product', '00000162', 2, 1, NULL, 2, 1, 1, '0', 180.00, 400.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-23 19:20:26', '2024-04-29 13:57:45'),
(163, 'Morobba-100gm', 'finish_product', '00000163', 2, 1, NULL, 1, 1, 1, '0', 20.00, 40.00, 50.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-23 19:20:58', '2024-04-23 19:20:58'),
(164, 'Pan Masala-1kg', 'finish_product', '00000164', 2, 3, NULL, 2, 1, 1, '0', 340.00, 700.00, 950.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-23 19:25:22', '2024-08-04 02:41:30'),
(165, 'Clove-1kg', 'finish_product', '00000165', 1, 3, NULL, 2, 1, 1, '1', 1310.00, 2100.00, 2500.00, 0.00, 1000.00, '[null,null,null]', 1, NULL, NULL, '2024-04-23 19:32:57', '2024-10-19 05:34:48'),
(166, 'Bali-1kg', 'finish_product', '00000166', 2, 4, NULL, 2, 1, 1, '0', 72.00, 300.00, 500.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 12:15:45', '2024-08-25 12:49:34'),
(167, 'White sesame-1kg', 'finish_product', '00000167', 2, 1, NULL, 2, 1, 1, '0', 320.00, 750.00, 1100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 14:34:41', '2024-05-05 19:57:17'),
(168, 'Bali-100gm', 'finish_product', '00000168', 2, 4, NULL, 1, 1, 1, '0', 9.00, 30.00, 50.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 14:38:02', '2024-04-25 14:38:02'),
(169, 'White sesame-100gm', 'finish_product', '00000169', 2, 1, NULL, 1, 1, 1, '0', 28.58, 60.00, 85.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-25 14:39:22', '2024-10-19 05:40:43'),
(170, 'Cinnamon Powder', 'finish_product', '00000170', 2, 3, NULL, 1, 1, 1, '0', 0.00, 200.00, 250.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 20:14:49', '2024-04-25 20:22:08'),
(171, 'Clove Powder', 'finish_product', '00000171', 2, 3, NULL, 1, 1, 1, '0', 0.00, 200.00, 250.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 20:15:24', '2024-04-25 20:22:08'),
(172, 'Mixed Masala (Asto)', 'finish_product', '00000172', 2, 3, NULL, 1, 1, 1, '0', 15.11, 30.00, 40.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 20:21:07', '2024-04-25 20:21:07'),
(173, 'Barley 400gm', 'finish_product', '00000173', 2, 4, NULL, 1, 1, 1, '0', 36.00, 90.00, 120.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 20:28:14', '2024-04-25 20:28:14'),
(174, 'white seasame 400gm', 'finish_product', '00000174', 2, 4, NULL, 1, 1, 1, '0', 128.00, 220.00, 300.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-25 20:29:52', '2024-04-25 20:29:52'),
(175, 'Pan Masala-150gm', 'finish_product', '00000175', 2, 3, NULL, 1, 1, 1, '0', 41.63, 85.00, 125.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-25 20:34:01', '2024-08-04 03:36:21'),
(176, 'Irani Cumin-1kg', 'finish_product', '00000176', 2, 3, NULL, 2, 1, 1, '0', 820.00, 1200.00, 1400.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-29 13:23:21', '2024-10-19 05:34:48'),
(177, 'Irani Cumin-100gm', 'finish_product', '00000177', 2, 3, NULL, 1, 1, 1, '0', 66.00, 95.00, 120.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-29 13:26:19', '2024-08-04 03:47:24'),
(178, 'Jorda Color-1kg', 'finish_product', '00000178', 2, 4, NULL, 2, 1, 1, '0', 400.00, 1700.00, 2300.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-29 13:31:35', '2024-05-17 17:53:39'),
(179, 'Cubeb-1kg-কাবাব চিনি', 'finish_product', '00000179', 2, 3, NULL, 2, 1, 1, '0', 2800.00, 4000.00, 5000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-29 13:35:48', '2024-05-05 19:57:17'),
(180, 'Black seasame-1kg', 'finish_product', '00000180', 2, 1, NULL, 2, 1, 1, '0', 140.00, 300.00, 400.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-04-29 13:39:36', '2024-04-29 13:39:36'),
(181, 'Black seasame-80gm', 'finish_product', '00000181', 2, 1, NULL, 1, 1, 1, '0', 0.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-30 13:29:06', '2024-08-04 03:53:09'),
(182, 'Cubeb-40gm', 'finish_product', '00000182', 2, 3, NULL, 1, 1, 1, '0', 104.00, 155.00, 200.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-04-30 13:31:06', '2024-09-30 07:01:35'),
(183, 'Dry mango-1kg', 'finish_product', '00000183', 2, 1, 6, 2, 1, 1, '0', 940.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:03:24', '2024-05-02 09:03:24'),
(184, 'Green Apricots-1kg', 'finish_product', '00000184', 2, 1, 6, 2, 1, 1, '0', 950.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:04:38', '2024-05-02 09:04:38'),
(185, 'Red shakura Plam-1kg', 'finish_product', '00000185', 2, 1, 6, 2, 1, 1, '0', 940.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:05:40', '2024-05-02 09:05:40'),
(186, 'Apricots-1kg', 'finish_product', '00000186', 2, 1, 6, 2, 1, 1, '0', 1090.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:07:24', '2024-05-02 09:07:24'),
(187, 'Khurma Date-1kg', 'finish_product', '00000187', 2, 1, 6, 2, 1, 1, '0', 6800.00, 7850.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:08:25', '2024-08-10 02:01:39'),
(188, 'Sunflower Seeds-1kg', 'finish_product', '00000188', 2, 1, 2, 2, 1, 1, '0', 640.00, 950.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:09:15', '2024-05-02 09:09:15'),
(189, 'Black Shakura Plam-1kg', 'finish_product', '00000189', 2, 1, 6, 2, 1, 1, '0', 940.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:10:22', '2024-05-02 09:10:22'),
(190, 'Water Melon Seeds-1kg', 'finish_product', '00000190', 2, 1, 2, 2, 1, 1, '0', 880.00, 1200.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:11:03', '2024-05-02 09:11:03'),
(191, 'Dry Apple-1kg', 'finish_product', '00000191', 2, 1, 6, 2, 1, 1, '0', 530.00, 580.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:11:59', '2024-08-14 11:55:57'),
(192, 'Dry Zambura-1kg', 'finish_product', '00000192', 2, 1, 6, 2, 1, 1, '0', 940.00, 1300.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:12:43', '2024-05-02 09:12:43'),
(193, 'Thai Nut-1kg', 'finish_product', '00000193', 2, 1, 2, 2, 1, 1, '0', 340.00, 500.00, 700.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:14:01', '2024-08-10 02:01:39'),
(194, 'Roasted Peanut-1kg', 'finish_product', '00000194', 2, 1, 2, 2, 1, 1, '0', 230.00, 360.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:15:21', '2024-08-10 02:01:39'),
(195, 'Mix Nuts-250gm', 'finish_product', '00000195', 2, 1, NULL, 1, 1, 1, '0', 156.00, 270.00, 350.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:17:08', '2024-05-02 09:17:08'),
(196, 'Mix Dry Fruits-200gm', 'finish_product', '00000196', 2, 1, NULL, 1, 1, 1, '0', 193.00, 270.00, 330.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 09:20:51', '2024-05-02 09:20:51'),
(197, 'Mix Nuts-200gm', 'finish_product', '00000197', 2, 1, 2, 1, 1, 1, '0', 125.00, 220.00, 270.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-02 11:36:36', '2024-05-02 11:36:36'),
(198, 'Mariyam Date-1kg', 'finish_product', '00000198', 2, 1, NULL, 1, 1, 1, '0', 37700.00, 42000.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-03 16:47:08', '2024-10-25 09:19:04'),
(199, 'Dabbas Date-1kg', 'finish_product', '00000199', 2, 1, NULL, 1, 1, 1, '0', 2200.00, 2500.00, 0.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-03 16:47:45', '2024-09-17 09:13:45'),
(200, 'Water Melon Seeds-100gm', 'finish_product', '00000200', 2, 1, NULL, 1, 1, 1, '0', 88.00, 120.00, 150.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-04 14:09:19', '2024-05-04 14:09:19'),
(201, 'Sunflower Seeds-50gm', 'finish_product', '00000201', 2, 1, NULL, 1, 1, 1, '0', 32.00, 48.00, 65.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-04 14:11:41', '2024-05-04 14:11:41'),
(202, 'Black pepper Powder-50gm', 'finish_product', '00000202', 2, 3, NULL, 1, 1, 1, '0', 0.00, 70.00, 100.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-04 14:15:02', '2024-05-04 14:28:12'),
(204, 'Dulal bhar\'s talmisri-1kg', 'finish_product', '00000203', 2, 1, NULL, 1, 1, 1, '0', 265.00, 290.00, 475.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-05 19:38:56', '2024-06-27 11:05:18'),
(205, 'Dulal bhar\'s talmisri-500gm', 'finish_product', '00000205', 2, 1, NULL, 1, 1, 1, '0', 150.00, 190.00, 275.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-05 19:39:46', '2024-06-27 11:05:18'),
(206, 'Ekangi Natural Herbs-1kg', 'finish_product', '00000206', 2, 3, NULL, 1, 1, 1, '0', 600.00, 900.00, 1200.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-05 19:42:05', '2024-05-05 19:42:05'),
(207, 'bos-1kg', 'finish_product', '00000207', 2, 3, NULL, 1, 1, 1, '0', 980.00, 1400.00, 2000.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-05 19:43:12', '2024-05-05 19:43:12'),
(208, 'Jorda Color-25gm', 'finish_product', '00000208', 2, 4, NULL, 1, 1, 1, '0', 10.00, 43.00, 60.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-17 17:55:28', '2024-05-17 17:55:28'),
(209, 'Gawa Ghee-', 'finish_product', '00000209', 2, 5, NULL, 1, 1, 1, '0', 976.25, 1250.00, 1550.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-18 14:09:50', '2024-08-25 12:33:29'),
(210, 'Gawa Ghee-500gm', 'finish_product', '00000210', 2, 5, NULL, 1, 1, 1, '0', 475.00, 625.00, 775.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-18 14:10:57', '2024-10-15 22:37:30'),
(211, 'Tishi-1kg', 'finish_product', '00000211', 2, 1, NULL, 2, 1, 1, '0', 110.00, 230.00, 350.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-26 16:10:06', '2024-05-26 16:10:06'),
(212, 'Tishi-100gm', 'finish_product', '00000212', 2, 1, NULL, 1, 1, 1, '0', 9.23, 25.00, 35.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-05-26 16:11:41', '2024-10-06 06:07:01'),
(213, 'Chilli Powder-1kg', 'finish_product', '00000213', 2, 3, NULL, 2, 1, 1, '0', 200.00, 490.00, 660.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-05 13:54:21', '2024-08-31 02:43:22'),
(214, 'Coriander Powder-1kg', 'finish_product', '00000214', 2, 3, NULL, 2, 1, 1, '0', 230.00, 450.00, 600.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-05 13:55:52', '2024-06-05 13:55:52'),
(215, 'Cumin Powder-1kg', 'finish_product', '00000215', 2, 3, NULL, 2, 1, 1, '0', 730.00, 1400.00, 1800.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-05 13:57:18', '2024-06-25 21:45:55'),
(216, 'Tarmeric Powder-1kg', 'finish_product', '00000216', 2, 3, NULL, 2, 1, 1, '0', 260.00, 480.00, 650.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-05 13:59:47', '2024-08-02 12:10:41'),
(217, 'Cosmetics', 'finish_product', '00000217', 2, 1, NULL, 1, 1, 1, '0', 9720.00, 10440.00, 13950.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-07 17:03:34', '2024-06-07 17:03:34'),
(218, 'Clean & Clear-50ml', 'finish_product', '00000218', 2, 7, NULL, 3, 1, 1, '0', 85.00, 100.00, 165.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:02:42', '2024-06-08 16:02:42'),
(219, 'Moov-15gm', 'finish_product', '00000219', 2, 7, NULL, 3, 1, 1, '0', 75.00, 100.00, 180.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:04:45', '2024-06-08 16:04:45'),
(220, 'Veet-25', 'finish_product', '00000220', 2, 7, NULL, 3, 1, 1, '0', 55.00, 70.00, 110.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:06:20', '2024-06-08 16:14:45'),
(221, 'Emami 7 oil - 100ml', 'finish_product', '00000221', 2, 7, NULL, 3, 1, 1, '0', 90.00, 100.00, 140.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:08:30', '2024-06-08 16:14:45'),
(222, 'Navaratna -100ml', 'finish_product', '00000222', 2, 7, NULL, 3, 1, 1, '0', 85.00, 100.00, 140.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:09:37', '2024-06-08 16:09:37'),
(223, 'Navaratna-200', 'finish_product', '00000223', 2, 7, NULL, 3, 1, 1, '0', 150.00, 185.00, 265.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-08 16:11:05', '2024-06-08 16:11:05'),
(224, 'Dabur Amla Hair Oil-180ml', 'finish_product', '00000224', 2, 7, NULL, 3, 1, 1, '0', 135.00, 170.00, 220.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 15:49:55', '2024-06-09 15:49:55'),
(225, 'Dabur Amla Hair Oil-275ml', 'finish_product', '00000225', 2, 7, NULL, 3, 1, 1, '0', 180.00, 230.00, 295.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 15:51:51', '2024-06-09 15:51:51'),
(226, 'Vatika Coconut Oil-150ml', 'finish_product', '00000226', 2, 7, NULL, 3, 1, 1, '0', 115.00, 145.00, 180.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 15:54:32', '2024-06-09 15:54:32'),
(227, 'Vatika Coconut Oil-300ml', 'finish_product', '00000227', 2, 7, NULL, 3, 1, 1, '0', 200.00, 230.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 15:55:41', '2024-06-09 15:55:41'),
(228, 'Sesa Hair Oil-100ml', 'finish_product', '00000228', 2, 7, NULL, 3, 1, 1, '0', 115.00, 150.00, 210.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 15:58:44', '2024-06-09 15:58:44'),
(229, 'Sesa Hair Oil-200ml', 'finish_product', '00000229', 2, 7, NULL, 3, 1, 1, '0', 170.00, 220.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:00:38', '2024-06-09 16:00:38'),
(230, 'Papaya Whitening Soap-135g', 'finish_product', '00000230', 2, 7, NULL, 3, 1, 1, '0', 170.00, 230.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:03:31', '2024-06-09 16:03:31'),
(231, 'Gold 24k Soap-80g', 'finish_product', '00000231', 2, 7, NULL, 3, 1, 1, '0', 75.00, 130.00, 180.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:05:08', '2024-06-09 16:05:08'),
(232, 'Johnson\'s Baby Shampoo-100ml', 'finish_product', '00000232', 2, 7, NULL, 3, 1, 1, '0', 110.00, 135.00, 220.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:09:43', '2024-06-09 16:09:43'),
(233, 'Tinkle Eyebrow Razor', 'finish_product', '00000233', 2, 7, NULL, 3, 1, 1, '0', 60.00, 75.00, 100.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:18:01', '2024-06-09 16:20:09'),
(234, 'Keli Eyebrow Razor', 'finish_product', '00000234', 2, 7, NULL, 3, 1, 1, '0', 120.00, 150.00, 190.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:19:20', '2024-06-09 16:19:20'),
(235, 'Kaveri Mehedi', 'finish_product', '00000235', 2, 7, NULL, 3, 1, 1, '0', 16.50, 20.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:21:15', '2024-06-09 16:21:15'),
(236, 'Aloe Vera Lip gel', 'finish_product', '00000236', 2, 7, NULL, 3, 1, 1, '0', 50.00, 60.00, 90.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-09 16:24:11', '2024-06-09 16:24:11'),
(237, 'Red Suger-1kg', 'finish_product', '00000237', 2, 1, NULL, 2, 1, 1, '0', 168.70, 240.00, 360.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-09 16:45:25', '2024-06-09 16:45:25'),
(238, 'Safari-S', 'finish_product', '00000238', 2, 8, NULL, 3, 1, 1, '0', 13.00, 17.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 19:49:09', '2024-08-26 06:12:28'),
(239, 'Safari-B', 'finish_product', '00000239', 2, 8, NULL, 3, 1, 1, '0', 34.00, 38.00, 45.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 19:50:52', '2024-08-26 06:12:28'),
(240, 'Snickers-12g', 'finish_product', '00000240', 2, 8, NULL, 3, 1, 1, '0', 20.00, 23.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 19:54:46', '2024-10-16 06:42:41'),
(241, '5 Star-22g', 'finish_product', '00000241', 2, 8, NULL, 3, 1, 1, '0', 22.00, 25.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 19:57:31', '2024-08-10 04:03:51'),
(242, 'Amul Dark-40g', 'finish_product', '00000242', 2, 8, NULL, 3, 1, 1, '0', 115.00, 125.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 19:59:57', '2024-09-25 07:40:59'),
(243, 'Tobleron-100g', 'finish_product', '00000243', 2, 8, NULL, 3, 1, 1, '0', 200.00, 225.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:01:45', '2024-09-25 07:40:59'),
(244, 'Milkybar-24.5g', 'finish_product', '00000244', 2, 8, NULL, 3, 1, 1, '0', 42.00, 48.00, 60.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:03:46', '2024-08-10 04:03:51'),
(245, 'Bounty-28.5g', 'finish_product', '00000245', 2, 8, NULL, 3, 1, 1, '0', 60.00, 67.00, 80.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:06:22', '2024-06-10 20:06:22'),
(246, 'Bounty-57g', 'finish_product', '00000246', 2, 8, NULL, 3, 1, 1, '0', 98.00, 110.00, 140.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:08:10', '2024-08-10 04:03:51'),
(247, 'Polo', 'finish_product', '00000247', 2, 8, NULL, 3, 1, 1, '0', 11.00, 12.00, 15.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:10:04', '2024-06-10 20:10:04'),
(248, 'Oreo-S', 'finish_product', '00000248', 2, 8, NULL, 3, 1, 1, '0', 23.50, 25.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:12:41', '2024-10-16 06:42:41'),
(249, 'Oreo-B', 'finish_product', '00000249', 2, 8, NULL, 3, 1, 1, '0', 87.00, 95.00, 120.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:14:24', '2024-10-16 06:42:41'),
(250, 'Hide & seek', 'finish_product', '00000250', 2, 8, NULL, 3, 1, 1, '0', 80.00, 90.00, 110.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:16:30', '2024-06-10 20:16:30'),
(251, 'MacCoffee Gold-50g', 'finish_product', '00000251', 2, 8, NULL, 3, 1, 1, '0', 345.00, 370.00, 460.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:19:43', '2024-06-10 20:19:43'),
(252, 'MacCoffee Gold-100g', 'finish_product', '00000252', 2, 8, NULL, 3, 1, 1, '0', 540.00, 590.00, 790.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:21:37', '2024-06-10 20:21:37'),
(253, 'MacCoffee Gold-200g', 'finish_product', '00000253', 2, 8, NULL, 3, 1, 1, '0', 1170.00, 1200.00, 1450.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:23:11', '2024-06-10 20:59:50'),
(254, 'Nestle gold-50g', 'finish_product', '00000254', 2, 8, NULL, 3, 1, 1, '0', 500.00, 600.00, 790.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:26:10', '2024-06-10 20:59:50'),
(255, 'Nestle gold-100g', 'finish_product', '00000255', 2, 8, NULL, 3, 1, 1, '0', 620.00, 750.00, 990.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:27:44', '2024-06-10 20:59:50'),
(256, 'Davidoff', 'finish_product', '00000256', 2, 8, NULL, 3, 1, 1, '0', 750.00, 880.00, 1100.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:28:53', '2024-06-10 20:28:53'),
(257, 'Tora bika', 'finish_product', '00000257', 2, 8, NULL, 3, 1, 1, '0', 25.00, 28.00, 35.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:30:16', '2024-06-10 20:30:16'),
(258, 'Hershey\'s chocolate syrup', 'finish_product', '00000258', 2, 8, NULL, 3, 1, 1, '0', 500.00, 550.00, 750.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:31:33', '2024-06-10 20:31:33'),
(259, 'BonBOn Bum', 'finish_product', '00000259', 2, 8, NULL, 3, 1, 1, '0', 390.00, 430.00, 760.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:32:54', '2024-08-10 05:47:05'),
(260, 'Orbit', 'finish_product', '00000260', 2, 8, NULL, 3, 1, 1, '0', 10.00, 12.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:34:43', '2024-09-25 07:40:59'),
(261, 'Bubbly silk-s', 'finish_product', '00000261', 2, 8, NULL, 3, 1, 1, '0', 135.00, 140.00, 160.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:39:03', '2024-06-10 20:39:03'),
(262, 'Bubbly silk-B', 'finish_product', '00000262', 2, 8, NULL, 3, 1, 1, '0', 285.00, 300.00, 350.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:40:54', '2024-06-10 20:40:54'),
(263, 'Kitkat UAE', 'finish_product', '00000263', 2, 8, NULL, 3, 1, 1, '0', 115.00, 130.00, 170.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-10 20:43:12', '2024-06-10 20:59:50'),
(264, 'break Time', 'finish_product', '00000264', 2, 8, NULL, 3, 1, 1, '0', 18.00, 20.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:10:56', '2024-06-13 17:10:56'),
(265, 'Gufa', 'finish_product', '00000265', 2, 8, NULL, 3, 1, 1, '0', 14.00, 17.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:11:47', '2024-07-04 16:03:52'),
(266, 'Caranut', 'finish_product', '00000266', 2, 8, NULL, 3, 1, 1, '0', 13.50, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:18:13', '2024-06-13 17:18:13'),
(267, 'Fresh MIxed Nuts-400gm', 'finish_product', '00000267', 2, 8, NULL, 3, 1, 1, '0', 551.00, 670.00, 895.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:20:11', '2024-06-13 17:50:16'),
(268, 'Cintu ChocoStar', 'finish_product', '00000268', 2, 8, NULL, 3, 1, 1, '0', 12.00, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:24:30', '2024-06-13 17:24:30'),
(269, 'Ifly KO KO', 'finish_product', '00000269', 2, 8, NULL, 3, 1, 1, '0', 14.00, 17.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:25:36', '2024-07-04 16:03:52'),
(270, 'American Cow', 'finish_product', '00000270', 2, 8, NULL, 3, 1, 1, '0', 16.00, 20.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:28:58', '2024-10-16 06:42:41'),
(271, 'MARS', 'finish_product', '00000271', 2, 8, NULL, 3, 1, 1, '0', 90.00, 100.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:32:39', '2024-06-13 17:32:39'),
(272, 'BAR-5', 'finish_product', '00000272', 2, 8, NULL, 3, 1, 1, '0', 13.00, 13.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:33:48', '2024-06-13 17:33:48'),
(273, 'FUSE', 'finish_product', '00000273', 2, 8, NULL, 3, 1, 1, '0', 44.00, 48.00, 60.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:36:36', '2024-06-13 17:36:36'),
(274, 'M&MS', 'finish_product', '00000274', 2, 8, NULL, 3, 1, 1, '0', 98.00, 108.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-13 17:39:27', '2024-08-10 04:03:51'),
(275, 'Lucy Olive Oil-100ml', 'finish_product', '00000275', 2, 7, NULL, 3, 1, 1, '0', 110.00, 150.00, 245.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 14:59:15', '2024-06-14 14:59:15');
INSERT INTO `products` (`id`, `name`, `product_type`, `barcode`, `unit_id`, `category_id`, `subcategory_id`, `brand_id`, `branch_id`, `user_id`, `price_type`, `purchase_price`, `sale_price`, `wholesale_price`, `stock_alert`, `divisor_number`, `quantity_in_unit`, `status`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(276, 'Lucy Olive Oil-200ml', 'finish_product', '00000276', 2, 7, NULL, NULL, 1, 1, '0', 205.00, 270.00, 365.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 15:00:17', '2024-06-14 15:00:34'),
(277, 'Aloe Vera gel 99.9%', 'finish_product', '00000277', 2, 7, NULL, 3, 1, 1, '0', 80.00, 105.00, 140.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 15:03:54', '2024-06-14 15:03:54'),
(278, 'Ponds powder', 'finish_product', '00000278', 2, 7, NULL, 3, 1, 1, '0', 120.00, 140.00, 170.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 15:05:42', '2024-06-14 15:05:42'),
(279, 'Fogg body Spray', 'finish_product', '00000279', 2, 7, NULL, 3, 1, 1, '0', 210.00, 325.00, 399.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 15:09:00', '2024-06-14 15:09:00'),
(280, 'johneson Olive Oil', 'finish_product', '00000280', 2, 7, NULL, 3, 1, 1, '0', 70.00, 100.00, 170.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-14 15:12:14', '2024-06-14 20:23:58'),
(281, 'Cowhead-500gm', 'finish_product', '00000281', 2, 8, NULL, 3, 1, 1, '0', 460.00, 590.00, 720.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-25 18:32:49', '2024-09-07 04:10:46'),
(282, 'Organic Baby Oats-500gm', 'finish_product', '00000282', 2, 8, NULL, 3, 1, 1, '0', 440.00, 590.00, 720.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-25 18:36:31', '2024-08-10 05:47:05'),
(283, 'Amul Dark-150gm', 'finish_product', '00000283', 2, 8, NULL, 3, 1, 1, '0', 330.00, 360.00, 440.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-26 14:27:27', '2024-10-16 06:42:41'),
(284, 'Green Cardamon-25gm', 'finish_product', '00000284', 2, 3, NULL, 3, 1, 1, '0', 102.50, 125.00, 145.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-27 20:18:25', '2024-10-22 02:45:58'),
(285, 'Raisins - 100gm কিশমিশ', 'finish_product', '00000285', 2, 3, NULL, 3, 1, 1, '0', 62.00, 85.00, 105.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-06-27 20:20:11', '2024-08-06 05:12:48'),
(286, 'Raisins - 500gm', 'finish_product', '00000286', 2, 3, NULL, 3, 1, 1, '0', 320.00, 400.00, 490.00, 0.00, 1.00, '[null,null,null]', 1, NULL, NULL, '2024-06-27 20:21:15', '2024-10-23 03:10:33'),
(287, 'Marshmallow', 'finish_product', '00000287', 2, 8, NULL, 3, 1, 1, '0', 50.00, 70.00, 90.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:39:32', '2024-08-10 04:03:51'),
(288, 'Soft candy-165g', 'finish_product', '00000288', 2, 8, NULL, 3, 1, 1, '0', 225.00, 250.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:44:35', '2024-08-10 04:03:51'),
(289, 'Ice Cream Mallows', 'finish_product', '00000289', 2, 8, NULL, 3, 1, 1, '0', 130.00, 145.00, 210.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:46:06', '2024-07-04 14:46:06'),
(290, 'Oats Choco-80g', 'finish_product', '00000290', 2, 8, NULL, 3, 1, 1, '0', 245.00, 290.00, 370.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:49:33', '2024-08-26 06:12:28'),
(291, 'Ice Cream Jelly', 'finish_product', '00000291', 2, 8, NULL, 3, 1, 1, '0', 24.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:52:21', '2024-08-10 04:03:51'),
(292, 'Mango Jelly', 'finish_product', '00000292', 2, 8, NULL, 3, 1, 1, '0', 24.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:54:01', '2024-08-10 04:03:51'),
(293, 'Oat Choco-400gm', 'finish_product', '00000293', 2, 8, NULL, 3, 1, 1, '0', 420.00, 450.00, 580.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 14:57:09', '2024-07-04 14:57:09'),
(294, 'Trident Gum', 'finish_product', '00000294', 2, 8, NULL, 3, 1, 1, '0', 115.00, 130.00, 160.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:00:14', '2024-08-10 04:03:51'),
(295, 'Dark fantasy', 'finish_product', '00000295', 2, 8, NULL, 3, 1, 1, '0', 220.00, 245.00, 330.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:02:54', '2024-08-26 06:12:28'),
(296, 'Flak\'O', 'finish_product', '00000296', 2, 8, NULL, 3, 1, 1, '0', 13.00, 16.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:11:54', '2024-07-04 15:11:54'),
(297, 'White Velvet', 'finish_product', '00000297', 2, 8, NULL, 3, 1, 1, '0', 13.00, 16.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:13:36', '2024-07-04 15:13:36'),
(298, 'Toren rocco', 'finish_product', '00000298', 2, 8, NULL, 3, 1, 1, '0', 650.00, 720.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:18:53', '2024-09-07 04:27:17'),
(299, 'perk-s', 'finish_product', '00000299', 2, 8, NULL, 3, 1, 1, '0', 13.00, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:20:03', '2024-08-10 04:03:51'),
(300, 'Amul bar', 'finish_product', '00000300', 2, 8, NULL, 3, 1, 1, '0', 64.00, 70.00, 90.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:23:54', '2024-07-04 15:23:54'),
(301, 'Munch', 'finish_product', '00000301', 2, 8, NULL, 3, 1, 1, '0', 13.00, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-04 15:25:42', '2024-07-04 15:25:42'),
(302, 'Testing salt-50g', 'finish_product', '00000302', 2, 3, NULL, 1, 1, 1, '0', 11.00, 17.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-11 20:23:22', '2024-07-11 20:23:22'),
(303, 'big babol', 'finish_product', '00000303', 2, 8, NULL, 3, 1, 1, '0', 31.00, 34.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:09:59', '2024-09-25 07:40:59'),
(304, 'Mentos Roll', 'finish_product', '00000304', 2, 8, NULL, 3, 1, 1, '0', 27.50, 31.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:12:08', '2024-09-25 07:40:59'),
(305, 'Mimi', 'finish_product', '00000305', 2, 8, NULL, 3, 1, 1, '0', 44.00, 50.00, 70.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:13:24', '2024-07-30 23:13:24'),
(306, 'Europe  Gum', 'finish_product', '00000306', 2, 8, NULL, 3, 1, 1, '0', 240.00, 300.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:15:20', '2024-08-10 04:03:51'),
(307, 'King Gum', 'finish_product', '00000307', 2, 8, NULL, 3, 1, 1, '0', 320.00, 400.00, 750.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:16:17', '2024-09-25 07:40:59'),
(308, 'Kopico Chocolate', 'finish_product', '00000308', 2, 8, NULL, 3, 1, 1, '0', 460.00, 500.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:18:30', '2024-08-14 11:55:57'),
(309, 'Amul kool', 'finish_product', '00000309', 2, 8, NULL, 3, 1, 1, '0', 85.00, 100.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:19:23', '2024-08-10 04:03:51'),
(310, 'Nut Crispy', 'finish_product', '00000310', 2, 8, NULL, 3, 1, 1, '0', 265.00, 290.00, 370.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:21:10', '2024-08-26 06:12:28'),
(311, 'Donut Jelly', 'finish_product', '00000311', 2, 8, NULL, 3, 1, 1, '0', 25.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:24:59', '2024-08-10 04:03:51'),
(312, 'Sharp lollipop', 'finish_product', '00000312', 2, 8, NULL, 3, 1, 1, '0', 23.00, 28.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:26:05', '2024-10-16 06:42:41'),
(313, 'Snickers Chocolate Bar (50 gm)', 'finish_product', '00000313', 2, 8, NULL, 3, 1, 1, '0', 40.00, 45.00, 65.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:30:01', '2024-10-16 06:42:41'),
(314, '3 horses', 'finish_product', '00000314', 2, 8, NULL, 3, 1, 1, '0', 250.00, 290.00, 350.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:37:32', '2024-08-10 04:03:51'),
(315, 'Chaina Lolly', 'finish_product', '00000315', 2, 8, NULL, 3, 1, 1, '0', 20.00, 25.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:38:40', '2024-08-15 07:55:51'),
(316, 'Basil Drinks', 'finish_product', '00000316', 2, 8, NULL, 3, 1, 1, '0', 230.00, 280.00, 350.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:39:30', '2024-08-10 04:03:51'),
(317, 'Sausage Marshmallow', 'finish_product', '00000317', 2, 8, NULL, 3, 1, 1, '0', 33.00, 38.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:40:40', '2024-08-10 04:03:51'),
(318, 'Raffaello', 'finish_product', '00000318', 2, 8, NULL, 3, 1, 1, '0', 145.00, 160.00, 210.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:43:22', '2024-09-25 07:40:59'),
(319, 'Chupachup', 'finish_product', '00000319', 2, 8, NULL, 3, 1, 1, '0', 14.00, 15.50, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:44:29', '2024-08-15 07:55:51'),
(320, 'BQ waves', 'finish_product', '00000320', 2, 8, NULL, 3, 1, 1, '0', 100.00, 110.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:45:32', '2024-07-30 23:45:32'),
(321, 'PopCorn', 'finish_product', '00000321', 2, 8, NULL, 3, 1, 1, '0', 30.00, 40.00, 60.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:47:09', '2024-08-10 04:03:51'),
(322, 'Fruit Podding', 'finish_product', '00000322', 2, 8, NULL, 3, 1, 1, '0', 70.00, 80.00, 105.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:48:23', '2024-08-10 04:03:51'),
(323, 'Fun Stick', 'finish_product', '00000323', 2, 8, NULL, 3, 1, 1, '0', 13.00, 15.00, 20.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:49:37', '2024-07-30 23:49:37'),
(324, 'Galaxy', 'finish_product', '00000324', 2, 8, NULL, 3, 1, 1, '0', 630.00, 695.00, 890.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:52:01', '2024-08-10 04:03:51'),
(325, 'Appy Fizz', 'finish_product', '00000325', 2, 8, NULL, 3, 1, 1, '0', 63.00, 72.00, 90.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:52:49', '2024-08-10 04:03:51'),
(326, 'Kinder joy', 'finish_product', '00000326', 2, 8, NULL, 3, 1, 1, '0', 120.00, 130.00, 170.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:53:41', '2024-10-16 06:42:41'),
(327, 'Mango Pulp Candies', 'finish_product', '00000327', 2, 8, NULL, 3, 1, 1, '0', 13.00, 15.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-30 23:55:10', '2024-07-31 00:27:17'),
(328, 'Gochujang-500gm', 'finish_product', '00000328', 2, 3, NULL, 3, 1, 1, '0', 620.00, 680.00, 780.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:03:15', '2024-08-14 11:55:57'),
(329, 'Choco Pie', 'finish_product', '00000329', 2, 8, NULL, 3, 1, 1, '0', 430.00, 480.00, 540.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:06:06', '2024-08-14 11:55:57'),
(330, 'Amul Kool-plastic', 'finish_product', '00000330', 2, 8, NULL, 3, 1, 1, '0', 70.00, 85.00, 120.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:09:07', '2024-08-14 11:55:57'),
(331, 'Hide & seek Black barbon-L', 'finish_product', '00000331', 2, 8, NULL, 3, 1, 1, '0', 85.00, 95.00, 120.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:11:30', '2024-10-16 06:42:41'),
(332, 'lexus', 'finish_product', '00000332', 2, 8, NULL, 3, 1, 1, '0', 360.00, 410.00, 490.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:13:57', '2024-08-14 11:55:57'),
(333, 'Bourn Vita-S', 'finish_product', '00000333', 2, 8, NULL, 3, 1, 1, '0', 27.00, 30.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:15:17', '2024-07-31 19:15:17'),
(334, 'Hide & seek Black barbon-S', 'finish_product', '00000334', 2, 8, NULL, 3, 1, 1, '0', 28.00, 30.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:16:19', '2024-07-31 19:16:19'),
(335, 'Shin Cup Noodles', 'finish_product', '00000335', 2, 8, NULL, 3, 1, 1, '0', 145.00, 165.00, 195.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:18:34', '2024-08-14 11:55:57'),
(336, 'Buldak Sauce', 'finish_product', '00000336', 2, 8, NULL, 3, 1, 1, '0', 440.00, 480.00, 680.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:23:50', '2024-07-31 19:23:50'),
(337, 'Haldiram\'s Soan Papdi (200 gm)', 'finish_product', '00000337', 2, 8, NULL, 3, 1, 1, '0', 145.00, 155.00, 220.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:25:46', '2024-09-07 04:10:46'),
(338, 'HaiThai', 'finish_product', '00000338', 2, 8, NULL, 3, 1, 1, '0', 330.00, 360.00, 460.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:27:20', '2024-07-31 19:27:20'),
(339, 'Parle-G', 'finish_product', '00000339', 2, 8, NULL, 3, 1, 1, '0', 28.00, 32.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:28:11', '2024-07-31 19:28:11'),
(340, 'Malkist', 'finish_product', '00000340', 2, 8, NULL, 3, 1, 1, '0', 130.00, 145.00, 190.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:29:45', '2024-08-14 11:55:57'),
(341, 'Kitkat 10rs', 'finish_product', '00000341', 2, 8, NULL, 3, 1, 1, '0', 1200.00, 1320.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-07-31 19:32:15', '2024-08-16 08:13:03'),
(342, 'Mustard oil-1l', 'finish_product', '00000342', 2, 5, NULL, 1, 1, 1, '0', 216.60, 260.00, 330.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-04 02:43:52', '2024-08-04 02:46:37'),
(343, 'Mustard oil-2L', 'finish_product', '00000343', 2, 5, NULL, 3, 1, 1, '0', 433.50, 520.00, 660.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-04 02:45:21', '2024-08-04 02:46:37'),
(344, 'Cardamom-25gm এলাচ', 'finish_product', '00000344', 2, 3, NULL, 1, 1, 1, '0', 71.11, 105.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-04 03:14:22', '2024-10-09 07:02:47'),
(345, 'Thai Nut-200g', 'finish_product', '00000345', 2, 1, 2, 1, 1, 1, '0', 68.00, 110.00, 145.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-06 05:11:20', '2024-10-01 10:32:40'),
(346, 'Toren bar', 'finish_product', '00000346', 2, 8, NULL, 3, 1, 1, '0', 90.00, 110.00, 140.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:05:03', '2024-08-10 04:05:03'),
(347, 'Burgur', 'finish_product', '00000347', 2, 8, NULL, 3, 1, 1, '0', 140.00, 180.00, 250.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:05:46', '2024-08-16 08:13:03'),
(348, 'Marshmallow- B', 'finish_product', '00000348', 2, 8, NULL, 3, 1, 1, '0', 180.00, 210.00, 280.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:07:09', '2024-08-10 04:07:09'),
(349, 'Moments', 'finish_product', '00000349', 2, 8, NULL, 3, 1, 1, '0', 240.00, 290.00, 350.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:07:59', '2024-08-15 07:55:51'),
(350, 'star Juice', 'finish_product', '00000350', 2, 8, NULL, 3, 1, 1, '0', 120.00, 130.00, 190.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:08:47', '2024-08-26 06:12:28'),
(351, 'Red bull', 'finish_product', '00000351', 2, 8, NULL, 3, 1, 1, '0', 235.00, 250.00, 300.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:09:40', '2024-08-26 06:12:28'),
(352, 'Rocket lolly', 'finish_product', '00000352', 2, 8, NULL, 3, 1, 1, '0', 25.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:10:25', '2024-08-26 06:12:28'),
(353, 'milkybar 10rs', 'finish_product', '00000353', 2, 8, NULL, 3, 1, 1, '0', 21.00, 25.00, 30.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 04:11:20', '2024-08-10 04:11:20'),
(354, 'kitkat 5rs', 'finish_product', '00000354', 2, 8, NULL, 3, 1, 1, '0', 730.00, 820.00, 1200.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-10 05:34:43', '2024-08-26 06:12:28'),
(355, 'SF. jam - mix', 'finish_product', '00000355', 2, 8, NULL, 3, 1, 1, '0', 550.00, 610.00, 710.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:14:52', '2024-08-14 10:14:52'),
(356, 'jeffy juice - s', 'finish_product', '00000356', 2, 8, NULL, 3, 1, 1, '0', 175.00, 210.00, 250.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:17:14', '2024-08-14 10:17:14'),
(357, 'Benis Coffee', 'finish_product', '00000357', 2, 8, NULL, 3, 1, 1, '0', 400.00, 460.00, 580.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:18:10', '2024-08-14 10:18:10'),
(358, 'Tiffeny Waffer', 'finish_product', '00000358', 2, 8, NULL, 3, 1, 1, '0', 235.00, 255.00, 320.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:18:59', '2024-08-26 05:19:30'),
(359, 'Hubba Bubba', 'finish_product', '00000359', 2, 8, NULL, 3, 1, 1, '0', 250.00, 280.00, 330.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:19:53', '2024-08-14 10:19:53'),
(360, 'SE seven- jams box', 'finish_product', '00000360', 2, 8, NULL, 3, 1, 1, '0', 810.00, 900.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:20:57', '2024-08-14 10:20:57'),
(361, 'Bru Coffee ORG,PURE mix', 'finish_product', '00000361', 2, 8, NULL, 3, 1, 1, '0', 530.00, 650.00, 895.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:23:12', '2024-08-14 10:23:12'),
(362, 'Pocky', 'finish_product', '00000362', 2, 8, NULL, 3, 1, 1, '0', 220.00, 260.00, 315.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:28:35', '2024-08-14 10:28:35'),
(363, 'Tuna fish', 'finish_product', '00000363', 2, 8, NULL, 3, 1, 1, '0', 250.00, 310.00, 370.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:30:07', '2024-08-14 10:30:07'),
(364, 'sardin fish', 'finish_product', '00000364', 2, 8, NULL, 3, 1, 1, '0', 160.00, 190.00, 230.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:31:41', '2024-08-14 10:31:41'),
(365, 'Trisha brush', 'finish_product', '00000365', 2, 8, NULL, 3, 1, 1, '0', 220.00, 260.00, 340.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:33:13', '2024-08-14 10:33:13'),
(366, 'Vita baby juice', 'finish_product', '00000366', 2, 8, NULL, 3, 1, 1, '0', 200.00, 220.00, 250.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:37:17', '2024-08-14 10:37:17'),
(367, 'KItkat chunky', 'finish_product', '00000367', 2, 8, NULL, 3, 1, 1, '0', 120.00, 135.00, 170.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:38:15', '2024-08-30 07:13:50'),
(368, 'Kitkat White', 'finish_product', '00000368', 2, 8, NULL, 3, 1, 1, '0', 2500.00, 2770.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:39:00', '2024-08-14 10:39:00'),
(369, 'Twix', 'finish_product', '00000369', 2, 8, NULL, 3, 1, 1, '0', 2420.00, 2640.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:39:57', '2024-08-14 10:39:57'),
(370, 'Mango ber -1kg', 'finish_product', '00000370', 2, 8, NULL, 3, 1, 1, '0', 800.00, 1000.00, 1700.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:41:14', '2024-09-25 07:40:59'),
(371, 'Mentos sour', 'finish_product', '00000371', 2, 8, NULL, 3, 1, 1, '0', 1430.00, 1580.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:42:09', '2024-08-14 10:42:09'),
(372, 'Trix', 'finish_product', '00000372', 2, 8, NULL, 3, 1, 1, '0', 3000.00, 3300.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:42:51', '2024-08-14 10:42:51'),
(373, 'Sweet Zone', 'finish_product', '00000373', 2, 8, NULL, 3, 1, 1, '0', 440.00, 490.00, 580.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:44:46', '2024-08-14 10:44:46'),
(374, 'Hershy SP. dark Tin', 'finish_product', '00000374', 2, 8, NULL, 3, 1, 1, '0', 370.00, 440.00, 530.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:46:41', '2024-08-14 10:46:41'),
(375, 'Old Town Coffee', 'finish_product', '00000375', 2, 8, NULL, 3, 1, 1, '0', 930.00, 990.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:48:28', '2024-08-14 10:48:28'),
(376, 'cadbury Choco Powder', 'finish_product', '00000376', 2, 8, NULL, 3, 1, 1, '0', 350.00, 410.00, 490.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:49:40', '2024-08-14 10:49:40'),
(377, 'Ritter Sport', 'finish_product', '00000377', 2, 8, NULL, 3, 1, 1, '0', 410.00, 480.00, 580.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:51:20', '2024-08-14 10:51:20'),
(378, 'beryls', 'finish_product', '00000378', 2, 8, NULL, 3, 1, 1, '0', 350.00, 400.00, 470.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:52:41', '2024-08-14 10:52:41'),
(379, 'Magic POP', 'finish_product', '00000379', 2, 8, NULL, 3, 1, 1, '0', 1320.00, 1450.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:55:10', '2024-08-14 10:55:10'),
(380, 'Kitkat caramel', 'finish_product', '00000380', 2, 8, NULL, 3, 1, 1, '0', 3300.00, 3600.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 10:58:16', '2024-08-14 10:58:16'),
(381, 'Damla sour tube', 'finish_product', '00000381', 2, 8, NULL, 3, 1, 1, '0', 77.00, 90.00, 120.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:00:03', '2024-08-14 11:00:03'),
(382, '4 Fruits Candy', 'finish_product', '00000382', 2, 8, NULL, 3, 1, 1, '0', 450.00, 500.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:01:18', '2024-08-14 11:01:18'),
(383, 'Kitkat 4F', 'finish_product', '00000383', 2, 8, NULL, 3, 1, 1, '0', 2100.00, 2300.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:02:01', '2024-08-14 11:02:01'),
(384, 'Oreo cup', 'finish_product', '00000384', 2, 8, NULL, 3, 1, 1, '0', 135.00, 150.00, 180.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:24:27', '2024-08-14 11:24:27'),
(385, 'Jr. horlicks', 'finish_product', '00000385', 2, 8, NULL, 3, 1, 1, '0', 620.00, 680.00, 750.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:27:21', '2024-08-14 11:30:57'),
(386, 'HOrlick UK', 'finish_product', '00000386', 2, 8, NULL, 3, 1, 1, '0', 770.00, 850.00, 950.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:30:14', '2024-08-14 11:30:14'),
(387, 'Lay\'s {F}', 'finish_product', '00000387', 2, 8, NULL, 3, 1, 1, '0', 180.00, 200.00, 250.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:33:44', '2024-08-14 11:33:44'),
(388, 'PRABHUJI PURE FOOD Soan Papdi - Elaichi', 'finish_product', '00000388', 2, 8, NULL, 3, 1, 1, '0', 235.00, 280.00, 350.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 11:35:38', '2024-08-14 11:35:38'),
(389, 'Chilli Powder-200gm', 'finish_product', '00000389', 2, 3, NULL, 1, 1, 1, '0', 52.00, 105.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 12:07:49', '2024-08-14 12:11:10'),
(390, 'Tarmeric Powder-200gm', 'finish_product', '00000390', 2, 3, NULL, 1, 1, 1, '0', 52.00, 100.00, 125.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 12:09:08', '2024-08-14 12:09:08'),
(391, 'Coriander Powder-200gm', 'finish_product', '00000391', 2, 3, NULL, 1, 1, 1, '0', 58.00, 100.00, 125.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 12:10:45', '2024-08-14 12:10:45'),
(392, 'Cumin Powder-200gm', 'finish_product', '00000392', 2, 3, NULL, 1, 1, 1, '0', 132.00, 280.00, 330.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-14 12:13:03', '2024-08-14 12:13:03'),
(393, 'Dairy milk -s', 'finish_product', '00000393', 2, 8, NULL, 3, 1, 1, '0', 18.50, 20.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-15 07:57:40', '2024-10-16 06:42:41'),
(394, 'dairy milk-m', 'finish_product', '00000394', 2, 8, NULL, 3, 1, 1, '0', 36.00, 40.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-15 13:19:08', '2024-08-15 13:19:08'),
(395, 'Dairy milk-l', 'finish_product', '00000395', 2, 8, NULL, 3, 1, 1, '0', 75.00, 80.00, 100.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-15 13:20:35', '2024-10-16 06:42:41'),
(396, 'Eye Candy', 'finish_product', '00000396', 2, 8, NULL, 3, 1, 1, '0', 28.00, 32.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-16 07:54:38', '2024-09-25 07:40:59'),
(397, 'Thai jelly', 'finish_product', '00000397', 2, 8, NULL, 3, 1, 1, '0', 29.00, 32.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-16 07:56:13', '2024-08-16 07:56:13'),
(398, 'Jelly', 'finish_product', '00000398', 2, 8, NULL, 3, 1, 1, '0', 26.00, 30.00, 40.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-16 07:59:16', '2024-08-16 07:59:16'),
(399, 'KITKAT L', 'finish_product', '00000399', 2, 8, NULL, 3, 1, 1, '0', 1200.00, 1320.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-16 08:01:32', '2024-08-16 08:01:32'),
(400, 'AMUL -S', 'finish_product', '00000400', 2, 8, NULL, 3, 1, 1, '0', 34.00, 38.00, 55.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-16 08:04:23', '2024-08-16 08:04:23'),
(401, 'Foochka- 1kg', 'finish_product', '00000401', 2, 4, NULL, 3, 1, 1, '0', 210.00, 750.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-21 03:23:14', '2024-08-21 03:23:14'),
(402, 'Bread Crumb-1kg', 'finish_product', '00000402', 2, 4, NULL, 3, 1, 1, '0', 93.34, 700.00, 0.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-21 03:25:50', '2024-08-21 03:27:01'),
(403, 'Aam Shotto- 100gm', 'finish_product', '00000403', 2, 1, NULL, 1, 1, 1, '0', 31.00, 60.00, 80.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-23 03:22:26', '2024-08-23 03:22:26'),
(404, 'Bread Crumb-200gm', 'finish_product', '00000404', 2, 4, NULL, 3, 1, 1, '0', 17.50, 70.00, 130.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-23 03:23:16', '2024-08-23 03:23:16'),
(405, 'Foochka-100gm', 'finish_product', '00000405', 2, 4, NULL, 3, 1, 1, '0', 21.00, 50.00, 80.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-23 03:26:28', '2024-08-23 03:26:53'),
(406, 'Toren Della', 'finish_product', '00000406', 2, 8, NULL, 3, 1, 1, '0', 90.00, 115.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:14:09', '2024-09-07 04:27:17'),
(407, 'Toren Classic', 'finish_product', '00000407', 2, 8, NULL, 3, 1, 1, '0', 155.00, 170.00, 280.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:16:19', '2024-08-26 05:18:04'),
(408, 'Toren Crunchy', 'finish_product', '00000408', 2, 8, NULL, 3, 1, 1, '0', 54.00, 60.00, 90.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:17:54', '2024-08-26 05:17:54'),
(409, 'Tiffany Wafer S', 'finish_product', '00000409', 2, 8, NULL, 3, 1, 1, '0', 125.00, 135.00, 175.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:20:39', '2024-08-26 05:20:39'),
(410, 'Vochelle Tin', 'finish_product', '00000410', 2, 8, NULL, 3, 1, 1, '0', 520.00, 580.00, 775.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:21:45', '2024-08-26 05:21:45'),
(411, 'Benzo - 1kg pack', 'finish_product', '00000411', 2, 8, NULL, 3, 1, 1, '0', 800.00, 900.00, 1320.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-26 05:38:56', '2024-08-26 05:38:56'),
(412, 'Tobleron MIni', 'finish_product', '00000412', 2, 8, NULL, 3, 1, 1, '0', 715.00, 790.00, 1000.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-08-30 07:15:21', '2024-09-07 04:18:37'),
(413, 'vivo Cream', 'finish_product', '00000413', 2, 4, NULL, 1, 1, 1, '0', 451.00, 520.00, 620.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-09-11 03:52:53', '2024-09-11 03:52:53'),
(414, 'sigma khatta mitta', 'finish_product', '00000414', 2, 8, NULL, 3, 1, 1, '0', 46.00, 52.00, 60.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-09-25 05:01:56', '2024-09-25 05:01:56'),
(415, 'Tiktak', 'finish_product', '00000415', 2, 8, NULL, 3, 1, 1, '0', 410.00, 460.00, 720.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-09-25 06:49:41', '2024-09-25 06:49:41'),
(416, 'milko bar', 'finish_product', '00000416', 2, 8, NULL, 3, 1, 1, '0', 500.00, 550.00, 800.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-09-25 07:44:41', '2024-09-25 07:44:41'),
(417, 'Rock salt-400gm- বিট লবণ', 'finish_product', '00000417', 2, 3, NULL, NULL, 1, 1, '0', 20.00, 100.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-09-30 03:18:43', '2024-09-30 03:18:43'),
(418, 'Galaxy', 'finish_product', '00000418', 2, 8, NULL, 3, 1, 1, '0', 98.00, 110.00, 150.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-10-16 06:44:45', '2024-10-16 06:44:45'),
(419, 'Strike Chocolate bar', 'finish_product', '8906109370919', 2, 8, NULL, 3, 1, 1, '0', 31.00, 35.00, 50.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-10-21 01:48:00', '2024-10-21 01:48:00'),
(420, 'Amol Chocominis', 'finish_product', '00000420', 2, 8, NULL, 3, 1, 1, '0', 11.00, 13.00, 25.00, 0.00, 1.00, '[null]', 1, NULL, NULL, '2024-10-21 01:49:10', '2024-10-21 01:49:10');

-- --------------------------------------------------------

--
-- Table structure for table `product_transfers`
--

CREATE TABLE `product_transfers` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `transfer_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_branch_id` bigint UNSIGNED NOT NULL,
  `to_branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer_details`
--

CREATE TABLE `product_transfer_details` (
  `id` bigint UNSIGNED NOT NULL,
  `product_transfer_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `quantity_in_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `voucher_no` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `party_id` bigint UNSIGNED NOT NULL COMMENT 'Supplier id',
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `subtotal` decimal(12,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat' COMMENT 'percentage/flat',
  `paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `previous_balance` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'party balance before completing purchase',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `date`, `voucher_no`, `party_id`, `branch_id`, `user_id`, `subtotal`, `discount`, `discount_type`, `paid`, `previous_balance`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(4, '2024-03-31', 'Voucher-00000001', 3, 1, 1, 70280.00, 0.00, 'flat', 20000.00, 0.00, NULL, NULL, '2024-04-04 18:55:48', '2024-04-04 19:03:18'),
(5, '2024-04-04', 'Voucher-00000005', 3, 1, 1, 2500.00, 0.00, 'flat', 2500.00, -46170.00, 'null', NULL, '2024-04-04 19:19:12', '2024-04-04 19:19:12'),
(6, '2024-04-04', 'Voucher-00000006', 3, 1, 1, 5500.00, 0.00, 'flat', 5500.00, -46170.00, 'null', NULL, '2024-04-04 19:23:26', '2024-04-04 19:23:26'),
(7, '2024-04-04', 'Voucher-00000007', 3, 1, 1, 18100.00, 0.00, 'flat', 20000.00, -46170.00, 'null', NULL, '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(8, '2024-04-05', 'Voucher-00000008', 3, 1, 1, 0.00, 0.00, 'flat', 0.00, -44270.00, 'null', NULL, '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(10, '2024-04-16', 'Voucher-00000009', 5, 1, 1, 360.00, 0.00, 'flat', 360.00, 0.00, 'null', NULL, '2024-04-16 12:02:15', '2024-04-16 12:02:15'),
(11, '2024-04-16', 'Voucher-00000011', 6, 1, 1, 18428.00, 28.00, 'flat', 18530.00, 0.00, 'null', NULL, '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(12, '2024-04-16', 'Voucher-00000012', 3, 1, 1, 0.00, 0.00, 'flat', 0.00, -29270.00, NULL, NULL, '2024-04-16 12:21:43', '2024-04-16 12:25:14'),
(13, '2024-04-20', 'Voucher-00000013', 6, 1, 1, 2700.16, 0.16, 'flat', 2800.00, 0.00, NULL, NULL, '2024-04-20 20:55:07', '2024-04-20 21:01:34'),
(14, '2024-04-23', 'Voucher-00000014', 3, 1, 1, 8034.00, 0.00, 'flat', 9160.00, -29270.00, 'null', NULL, '2024-04-23 19:41:44', '2024-04-23 19:45:55'),
(15, '2024-04-25', 'Voucher-00000015', 3, 1, 1, 2290.00, 0.00, 'flat', 0.00, -28144.00, 'null', NULL, '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(16, '2024-04-25', 'Voucher-00000016', 3, 1, 1, 0.00, 0.00, 'flat', 0.00, -30434.00, 'null', NULL, '2024-04-25 20:22:08', '2024-04-25 20:22:08'),
(17, '2024-04-29', 'Voucher-00000017', 3, 1, 1, 23880.00, 0.00, 'flat', 25000.00, -13144.00, 'null', NULL, '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(18, '2024-05-02', 'Voucher-00000018', 7, 1, 1, 49350.00, 0.00, 'flat', 29020.00, 0.00, NULL, NULL, '2024-05-02 11:51:58', '2024-05-02 12:03:33'),
(19, '2024-05-03', 'Voucher-00000019', 7, 1, 1, 6700.00, 0.00, 'flat', 0.00, -20850.00, 'null', NULL, '2024-05-03 16:49:28', '2024-05-03 16:49:28'),
(20, '2024-05-04', 'Voucher-00000020', 3, 1, 1, 0.00, 0.00, 'flat', 0.00, -12124.00, 'null', NULL, '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(21, '2024-05-05', 'Voucher-00000021', 3, 1, 1, 52080.00, 0.00, 'flat', 0.00, -12124.00, NULL, NULL, '2024-05-05 19:57:17', '2024-05-06 13:55:40'),
(22, '2024-05-08', 'Voucher-00000022', 3, 1, 1, 10095.00, 0.00, 'flat', 10335.00, -49294.00, 'null', NULL, '2024-05-08 21:10:34', '2024-05-08 21:10:34'),
(23, '2024-05-18', 'Voucher-00000023', 7, 1, 1, 18600.00, 0.00, 'flat', 18750.00, 0.00, 'null', NULL, '2024-05-18 14:12:42', '2024-05-18 14:12:42'),
(24, '2024-05-22', 'Voucher-00000024', 7, 1, 1, 7660.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-05-22 08:37:23', '2024-05-22 08:37:23'),
(25, '2024-05-26', 'Voucher-00000025', 7, 1, 1, 1458.50, 208.50, 'flat', 1250.00, 0.00, NULL, NULL, '2024-05-26 16:01:58', '2024-05-26 16:16:50'),
(26, '2024-05-26', 'Voucher-00000026', 3, 1, 1, 5650.00, 0.00, 'flat', 20000.00, -29294.00, 'null', NULL, '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(27, '2024-05-28', 'Voucher-00000027', 3, 1, 1, 2080.00, 0.00, 'flat', 2080.00, -14944.00, 'null', NULL, '2024-05-28 19:34:23', '2024-05-28 19:34:23'),
(28, '2024-06-01', 'Voucher-00000028', 3, 1, 1, 3425.00, 5.00, 'flat', 3420.00, -14944.00, 'null', NULL, '2024-06-01 20:10:17', '2024-06-01 20:10:17'),
(29, '2024-06-04', 'Voucher-00000029', 3, 1, 1, 9600.00, 0.00, 'flat', 10000.00, 6.00, 'null', NULL, '2024-06-04 20:55:05', '2024-06-04 20:55:05'),
(30, '2024-06-05', 'Voucher-00000030', 3, 1, 1, 7700.00, 4.00, 'flat', 0.00, 406.00, 'null', NULL, '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(31, '2024-06-06', 'Voucher-00000031', 7, 1, 1, 57400.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(32, '2024-06-07', 'Voucher-00000032', 8, 1, 1, 9720.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-06-07 17:04:16', '2024-06-07 17:04:16'),
(33, '2024-06-08', 'Voucher-00000033', 8, 1, 1, 6600.00, 0.00, 'flat', 0.00, -9720.00, 'null', NULL, '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(34, '2024-06-08', 'Voucher-00000034', 3, 1, 1, 350.00, 0.00, 'flat', 0.00, -5490.00, NULL, NULL, '2024-06-08 21:07:07', '2024-06-08 21:07:40'),
(35, '2024-06-09', 'Voucher-00000035', 8, 1, 1, 8550.00, 0.00, 'flat', 0.00, -7320.00, NULL, NULL, '2024-06-09 16:14:19', '2024-06-09 16:28:32'),
(36, '2024-06-09', 'Voucher-00000036', 8, 1, 1, 1356.00, 1.00, 'flat', 0.00, -15755.00, 'null', NULL, '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(37, '2024-06-09', 'Voucher-00000037', 7, 1, 1, 6748.00, 0.00, 'flat', 0.00, -57850.00, 'null', NULL, '2024-06-09 16:47:22', '2024-06-09 16:47:22'),
(38, '2024-06-10', 'Voucher-00000038', 8, 1, 1, 60005.00, 0.00, 'flat', 0.00, -15870.00, 'null', NULL, '2024-06-10 20:59:49', '2024-06-10 20:59:49'),
(39, '2024-06-13', 'Voucher-00000039', 8, 1, 1, 16000.00, 0.00, 'flat', 0.00, -75875.00, NULL, NULL, '2024-06-13 17:47:36', '2024-06-13 17:50:16'),
(40, '2024-06-13', 'Voucher-00000040', 3, 1, 1, 6800.00, 1000.00, 'flat', 0.00, -5840.00, 'null', NULL, '2024-06-13 19:01:10', '2024-06-13 19:01:10'),
(41, '2024-06-14', 'Voucher-00000041', 3, 1, 1, 4835.00, 0.00, 'flat', 0.00, -11640.00, 'null', NULL, '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(42, '2024-06-14', 'Voucher-00000042', 8, 1, 1, 16440.00, 0.00, 'flat', 0.00, -91875.00, NULL, NULL, '2024-06-14 15:16:29', '2024-06-14 20:23:58'),
(43, '2024-06-15', 'Voucher-00000043', 3, 1, 1, 500.00, 0.00, 'flat', 0.00, -1975.00, 'null', NULL, '2024-06-15 23:17:50', '2024-06-15 23:17:50'),
(44, '2024-06-24', 'Voucher-00000044', 3, 1, 1, 6100.00, 0.00, 'flat', 0.00, 7525.00, NULL, NULL, '2024-06-24 20:18:47', '2024-06-24 20:22:37'),
(45, '2024-06-25', 'Voucher-00000045', 8, 1, 1, 17160.00, 0.00, 'flat', 14610.00, -72315.00, 'null', NULL, '2024-06-25 18:38:37', '2024-06-25 18:38:37'),
(46, '2024-06-25', 'Voucher-00000046', 3, 1, 1, 9940.00, 0.00, 'flat', 10000.00, 1425.00, NULL, NULL, '2024-06-25 21:45:55', '2024-06-25 21:50:18'),
(47, '2024-06-26', 'Voucher-00000047', 8, 1, 1, 8100.00, 0.00, 'flat', 0.00, -74865.00, 'null', NULL, '2024-06-26 14:28:35', '2024-06-26 14:28:35'),
(48, '2024-06-27', 'Voucher-00000048', 3, 1, 1, 18700.00, 0.00, 'flat', 0.00, 1485.00, 'null', NULL, '2024-06-27 11:05:17', '2024-06-27 11:05:17'),
(49, '2024-06-30', 'Voucher-00000049', 7, 1, 1, 31600.00, 0.00, 'flat', 10000.00, 0.00, 'null', NULL, '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(50, '2024-07-04', 'Voucher-00000050', 8, 1, 1, 53468.00, 0.00, 'flat', 0.00, -82965.00, 'null', NULL, '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(51, '2024-07-11', 'Voucher-00000051', 7, 1, 1, 9700.00, 0.00, 'flat', 9900.00, 0.00, NULL, NULL, '2024-07-11 20:34:16', '2024-07-11 20:44:53'),
(52, '2024-07-11', 'Voucher-00000052', 8, 1, 1, 12480.00, 0.00, 'flat', 0.00, -136433.00, 'null', NULL, '2024-07-11 20:57:37', '2024-07-11 20:57:37'),
(53, '2024-07-16', 'Voucher-00000053', 7, 1, 1, 23250.00, 0.00, 'flat', 23500.00, 0.00, 'null', NULL, '2024-07-16 14:22:06', '2024-07-16 14:22:06'),
(54, '2024-07-24', 'Voucher-00000054', 3, 1, 1, 3840.00, 0.00, 'flat', 0.00, 4985.00, NULL, NULL, '2024-07-24 15:03:27', '2024-07-24 15:11:38'),
(55, '2024-07-30', 'Voucher-00000055', 8, 1, 1, 96528.00, 0.00, 'flat', 0.00, -82913.00, 'null', NULL, '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(56, '2024-07-31', 'Voucher-00000056', 8, 1, 1, 35022.00, 0.00, 'flat', 0.00, -179441.00, 'null', NULL, '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(57, '2024-08-02', 'Voucher-00000057', 3, 1, 1, 79750.00, 0.00, 'flat', 0.00, 41145.00, 'null', NULL, '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(58, '2024-08-04', 'Voucher-00000058', 3, 1, 1, 3840.00, 0.00, 'flat', 0.00, -38605.00, 'null', NULL, '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(59, '2024-08-04', 'Voucher-00000059', 10, 1, 1, 13000.50, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-08-04 02:46:37', '2024-08-04 02:46:37'),
(60, '2024-08-04', 'Voucher-00000060', 3, 1, 1, 0.00, 0.00, 'flat', 0.00, -42445.00, NULL, NULL, '2024-08-04 04:32:41', '2024-08-04 04:35:14'),
(61, '2024-08-06', 'Voucher-00000061', 3, 1, 1, 25105.00, 0.00, 'flat', 0.00, -32445.00, 'null', NULL, '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(62, '2024-08-09', 'Voucher-00000062', 3, 1, 1, 51350.00, 0.00, 'flat', 0.00, -37550.00, 'null', NULL, '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(63, '2024-08-10', 'Voucher-00000063', 10, 1, 1, 77400.00, 0.50, 'flat', 0.00, -0.50, 'null', NULL, '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(64, '2024-08-10', 'Voucher-00000064', 8, 1, 1, 106308.00, 0.00, 'flat', 0.00, -214463.00, 'null', NULL, '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(65, '2024-08-10', 'Voucher-00000065', 8, 1, 1, 21420.00, 0.00, 'flat', 0.00, -320771.00, 'null', NULL, '2024-08-10 04:15:13', '2024-08-10 04:15:13'),
(66, '2024-08-10', 'Voucher-00000066', 8, 1, 1, 66866.00, 0.00, 'flat', 0.00, -342191.00, 'null', NULL, '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(67, '2024-08-14', 'Voucher-00000067', 8, 1, 1, 26130.00, 0.00, 'flat', 0.00, -209057.00, 'null', NULL, '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(68, '2024-08-14', 'Voucher-00000068', 8, 1, 1, 56186.00, 0.00, 'flat', 0.00, -235187.00, 'null', NULL, '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(69, '2024-08-14', 'Voucher-00000069', 8, 1, 1, 75216.00, 0.00, 'flat', 0.00, -291373.00, 'null', NULL, '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(70, '2024-08-15', 'Voucher-00000070', 8, 1, 1, 75780.00, 0.00, 'flat', 0.00, -366589.00, 'null', NULL, '2024-08-15 02:46:14', '2024-08-15 02:46:14'),
(71, '2024-08-15', 'Voucher-00000071', 8, 1, 1, 96556.00, 0.00, 'flat', 0.00, -372369.00, 'null', NULL, '2024-08-15 07:55:51', '2024-08-16 08:13:03'),
(72, '2024-08-16', 'Voucher-00000072', 10, 1, 1, 272.40, 272.40, 'flat', 0.00, 0.00, 'null', NULL, '2024-08-16 08:26:56', '2024-08-16 08:26:56'),
(73, '2024-08-21', 'Voucher-00000073', 11, 1, 1, 373810.00, 0.00, 'flat', 371290.00, 0.00, NULL, NULL, '2024-08-21 03:09:54', '2024-08-21 03:11:43'),
(74, '2024-08-21', 'Voucher-00000074', 11, 1, 1, 910.02, 0.02, 'flat', 910.00, -2520.00, 'null', NULL, '2024-08-21 03:27:01', '2024-08-21 03:27:01'),
(75, '2024-08-23', 'Voucher-00000075', 11, 1, 1, 620.00, 0.00, 'flat', 0.00, -2520.00, 'null', NULL, '2024-08-23 03:27:30', '2024-08-23 03:27:30'),
(76, '2024-08-25', 'Voucher-00000076', 5, 1, 1, 39050.00, 0.00, 'flat', 39050.00, 0.00, 'null', NULL, '2024-08-25 12:33:29', '2024-08-25 12:33:29'),
(77, '2024-08-25', 'Voucher-00000077', 3, 1, 1, 9750.00, 0.00, 'flat', 0.00, 6070.00, 'null', NULL, '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(78, '2024-08-26', 'Voucher-00000078', 8, 1, 1, 24744.00, 0.00, 'flat', 0.00, -298925.00, 'null', NULL, '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(79, '2024-08-26', 'Voucher-00000079', 8, 1, 1, 81200.00, 0.00, 'flat', 0.00, -323669.00, NULL, NULL, '2024-08-26 06:12:28', '2024-08-26 06:13:34'),
(80, '2024-08-27', 'Voucher-00000080', 3, 1, 1, 8380.00, 0.00, 'flat', 0.00, 6320.00, 'null', NULL, '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(81, '2024-08-30', 'Voucher-00000081', 11, 1, 1, 21960.00, 0.00, 'flat', 0.00, -3140.00, 'null', NULL, '2024-08-30 07:13:50', '2024-08-30 07:17:25'),
(82, '2024-08-31', 'Voucher-00000082', 3, 1, 1, 9535.00, 0.00, 'flat', 0.00, 7940.00, 'null', NULL, '2024-08-31 02:39:25', '2024-08-31 02:39:25'),
(83, '2024-08-31', 'Voucher-00000083', 3, 1, 1, 3633.52, 0.00, 'flat', 0.00, -1595.00, 'null', NULL, '2024-08-31 02:43:22', '2024-08-31 02:43:22'),
(84, '2024-09-07', 'Voucher-00000084', 8, 1, 1, 22670.00, 0.00, 'flat', 0.00, -368925.00, 'null', NULL, '2024-09-07 04:10:45', '2024-09-07 04:10:45'),
(85, '2024-09-07', 'Voucher-00000085', 8, 1, 1, 9090.00, 0.00, 'flat', 0.00, -391595.00, 'null', NULL, '2024-09-07 04:18:37', '2024-09-07 04:18:37'),
(86, '2024-09-07', 'Voucher-00000086', 8, 1, 1, 31468.00, 0.00, 'flat', 0.00, -400685.00, 'null', NULL, '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(87, '2024-09-07', 'Voucher-00000087', 11, 1, 1, 6300.00, 0.00, 'flat', 0.00, -5100.00, 'null', NULL, '2024-09-07 06:14:36', '2024-09-07 06:14:36'),
(88, '2024-09-08', 'Voucher-00000088', 3, 1, 1, 32110.00, 0.00, 'flat', 0.00, 14771.48, 'null', NULL, '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(89, '2024-09-11', 'Voucher-00000089', 10, 1, 1, 16236.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-09-11 03:53:16', '2024-09-11 03:53:16'),
(90, '2024-09-17', 'Voucher-00000090', 11, 1, 1, 1700.00, 0.00, 'flat', 0.00, -400.00, 'null', NULL, '2024-09-17 09:08:33', '2024-09-17 09:08:33'),
(91, '2024-09-17', 'Voucher-00000091', 10, 1, 1, 64950.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(92, '2024-09-17', 'Voucher-00000092', 11, 1, 1, 3000.00, 0.00, 'flat', 0.00, -2100.00, 'null', NULL, '2024-09-17 09:21:22', '2024-09-17 09:21:22'),
(93, '2024-09-25', 'Voucher-00000093', 8, 1, 1, 131986.00, 0.00, 'flat', 0.00, -318533.00, 'null', NULL, '2024-09-25 04:58:11', '2024-09-25 07:46:40'),
(94, '2024-09-28', 'Voucher-00000094', 3, 1, 1, 1120.00, 0.00, 'flat', 0.00, 921.48, 'null', NULL, '2024-09-28 11:40:05', '2024-09-28 11:40:05'),
(95, '2024-09-29', 'Voucher-00000095', 8, 1, 1, 34780.00, 0.00, 'flat', 0.00, -343519.00, 'null', NULL, '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(96, '2024-09-30', 'Voucher-00000096', 11, 1, 1, 10130.95, 10130.95, 'flat', 0.00, -100.00, 'null', NULL, '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(97, '2024-10-06', 'Voucher-00000097', 3, 1, 1, 25462.37, 262.37, 'flat', 0.00, 12801.48, 'null', NULL, '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(98, '2024-10-08', 'Voucher-00000098', 3, 1, 1, 32680.00, 0.00, 'flat', 0.00, 2601.48, 'null', NULL, '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(99, '2024-10-12', 'Voucher-00000099', 10, 1, 1, 27200.00, 0.00, 'flat', 0.00, 0.00, 'null', NULL, '2024-10-12 06:22:37', '2024-10-12 06:22:37'),
(100, '2024-10-16', 'Voucher-00000100', 10, 1, 1, 19000.00, 0.00, 'flat', 0.00, -27200.00, 'null', NULL, '2024-10-15 22:37:30', '2024-10-15 22:37:30'),
(101, '2024-10-16', 'Voucher-00000101', 8, 1, 1, 113028.00, 3028.00, 'flat', 0.00, -293299.00, 'null', NULL, '2024-10-16 06:42:41', '2024-10-16 07:43:49'),
(102, '2024-10-19', 'Voucher-00000102', 3, 1, 1, 123510.00, 0.00, 'flat', 0.00, 10921.48, 'null', NULL, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(103, '2024-10-21', 'Voucher-00000103', 8, 1, 1, 18886.00, 0.00, 'flat', 0.00, -360299.00, 'null', NULL, '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(104, '2024-10-25', 'Voucher-00000104', 10, 1, 1, 37700.00, 0.00, 'flat', 0.00, -16200.00, 'null', NULL, '2024-10-25 09:19:04', '2024-10-25 09:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_costs`
--

CREATE TABLE `purchase_costs` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `labour_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `labour_cost_adjust_to_supplier` tinyint(1) NOT NULL DEFAULT '1',
  `transport_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `transport_cost_adjust_to_supplier` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_costs`
--

INSERT INTO `purchase_costs` (`id`, `purchase_id`, `labour_cost`, `labour_cost_adjust_to_supplier`, `transport_cost`, `transport_cost_adjust_to_supplier`, `created_at`, `updated_at`) VALUES
(4, 4, 0.00, 1, 0.00, 1, '2024-04-04 18:55:48', '2024-04-04 19:03:18'),
(5, 5, 0.00, 1, 0.00, 1, '2024-04-04 19:19:12', '2024-04-04 19:19:12'),
(6, 6, 0.00, 1, 0.00, 1, '2024-04-04 19:23:27', '2024-04-04 19:23:27'),
(7, 7, 0.00, 1, 0.00, 1, '2024-04-04 19:27:36', '2024-04-04 19:27:36'),
(8, 8, 0.00, 1, 0.00, 1, '2024-04-05 19:15:37', '2024-04-05 19:15:37'),
(10, 10, 0.00, 1, 0.00, 1, '2024-04-16 12:02:15', '2024-04-16 12:02:15'),
(11, 11, 20.00, 1, 110.00, 1, '2024-04-16 12:07:09', '2024-04-16 12:07:09'),
(12, 12, 0.00, 1, 0.00, 1, '2024-04-16 12:21:43', '2024-04-16 12:25:14'),
(13, 13, 0.00, 1, 100.00, 1, '2024-04-20 20:55:07', '2024-04-20 21:01:34'),
(14, 14, 0.00, 1, 0.00, 1, '2024-04-23 19:41:44', '2024-04-23 19:45:55'),
(15, 15, 0.00, 1, 0.00, 1, '2024-04-25 14:53:51', '2024-04-25 14:53:51'),
(16, 16, 0.00, 1, 0.00, 1, '2024-04-25 20:22:08', '2024-04-25 20:22:08'),
(17, 17, 0.00, 1, 100.00, 1, '2024-04-29 13:57:45', '2024-04-29 13:57:45'),
(18, 18, 0.00, 1, 520.00, 1, '2024-05-02 11:51:58', '2024-05-02 12:03:33'),
(19, 19, 0.00, 1, 0.00, 1, '2024-05-03 16:49:28', '2024-05-03 16:49:28'),
(20, 20, 0.00, 1, 0.00, 1, '2024-05-04 14:28:12', '2024-05-04 14:28:12'),
(21, 21, 90.00, 1, 0.00, 1, '2024-05-05 19:57:17', '2024-05-06 13:55:40'),
(22, 22, 0.00, 1, 240.00, 1, '2024-05-08 21:10:35', '2024-05-08 21:10:35'),
(23, 23, 0.00, 1, 150.00, 1, '2024-05-18 14:12:42', '2024-05-18 14:12:42'),
(24, 24, 0.00, 1, 0.00, 1, '2024-05-22 08:37:23', '2024-05-22 08:37:23'),
(25, 25, 0.00, 1, 0.00, 1, '2024-05-26 16:01:58', '2024-05-26 16:16:50'),
(26, 26, 0.00, 1, 0.00, 1, '2024-05-26 16:16:10', '2024-05-26 16:16:10'),
(27, 27, 0.00, 1, 0.00, 1, '2024-05-28 19:34:23', '2024-05-28 19:34:23'),
(28, 28, 0.00, 1, 0.00, 1, '2024-06-01 20:10:17', '2024-06-01 20:10:17'),
(29, 29, 0.00, 1, 0.00, 1, '2024-06-04 20:55:05', '2024-06-04 20:55:05'),
(30, 30, 0.00, 1, 200.00, 1, '2024-06-05 14:03:02', '2024-06-05 14:03:02'),
(31, 31, 450.00, 1, 0.00, 1, '2024-06-06 16:42:25', '2024-06-06 16:42:25'),
(32, 32, 0.00, 1, 0.00, 1, '2024-06-07 17:04:16', '2024-06-07 17:04:16'),
(33, 33, 0.00, 1, 0.00, 1, '2024-06-08 16:14:45', '2024-06-08 16:14:45'),
(34, 34, 0.00, 1, 0.00, 1, '2024-06-08 21:07:07', '2024-06-08 21:07:40'),
(35, 35, 0.00, 1, 0.00, 1, '2024-06-09 16:14:19', '2024-06-09 16:28:32'),
(36, 36, 0.00, 1, 0.00, 1, '2024-06-09 16:26:06', '2024-06-09 16:26:06'),
(37, 37, 0.00, 1, 2.00, 1, '2024-06-09 16:47:22', '2024-06-09 16:47:22'),
(38, 38, 0.00, 1, 0.00, 1, '2024-06-10 20:59:50', '2024-06-10 20:59:50'),
(39, 39, 0.00, 1, 0.00, 1, '2024-06-13 17:47:36', '2024-06-13 17:50:16'),
(40, 40, 0.00, 1, 0.00, 1, '2024-06-13 19:01:10', '2024-06-13 19:01:10'),
(41, 41, 0.00, 1, 0.00, 1, '2024-06-14 13:49:54', '2024-06-14 13:49:54'),
(42, 42, 0.00, 1, 0.00, 1, '2024-06-14 15:16:29', '2024-06-14 20:23:58'),
(43, 43, 0.00, 1, 0.00, 1, '2024-06-15 23:17:50', '2024-06-15 23:17:50'),
(44, 44, 0.00, 1, 0.00, 1, '2024-06-24 20:18:47', '2024-06-24 20:22:37'),
(45, 45, 0.00, 1, 0.00, 1, '2024-06-25 18:38:37', '2024-06-25 18:38:37'),
(46, 46, 0.00, 1, 0.00, 1, '2024-06-25 21:45:55', '2024-06-25 21:50:18'),
(47, 47, 0.00, 1, 0.00, 1, '2024-06-26 14:28:35', '2024-06-26 14:28:35'),
(48, 48, 0.00, 1, 0.00, 1, '2024-06-27 11:05:18', '2024-06-27 11:05:18'),
(49, 49, 0.00, 1, 0.00, 1, '2024-06-30 12:20:11', '2024-06-30 12:20:11'),
(50, 50, 0.00, 1, 0.00, 1, '2024-07-04 16:03:52', '2024-07-04 16:03:52'),
(51, 51, 0.00, 1, 200.00, 1, '2024-07-11 20:34:16', '2024-07-11 20:44:53'),
(52, 52, 0.00, 1, 0.00, 1, '2024-07-11 20:57:37', '2024-07-11 20:57:37'),
(53, 53, 0.00, 1, 250.00, 1, '2024-07-16 14:22:06', '2024-07-16 14:22:06'),
(54, 54, 0.00, 1, 0.00, 1, '2024-07-24 15:03:27', '2024-07-24 15:11:38'),
(55, 55, 0.00, 1, 0.00, 1, '2024-07-31 00:27:16', '2024-07-31 00:27:16'),
(56, 56, 0.00, 1, 0.00, 1, '2024-07-31 21:22:08', '2024-07-31 21:22:08'),
(57, 57, 0.00, 1, 0.00, 1, '2024-08-02 12:10:41', '2024-08-02 12:10:41'),
(58, 58, 0.00, 1, 0.00, 1, '2024-08-04 02:41:30', '2024-08-04 02:41:30'),
(59, 59, 0.00, 1, 0.00, 1, '2024-08-04 02:46:37', '2024-08-04 02:46:37'),
(60, 60, 0.00, 1, 0.00, 1, '2024-08-04 04:32:41', '2024-08-04 04:35:14'),
(61, 61, 0.00, 1, 0.00, 1, '2024-08-06 05:00:31', '2024-08-06 05:00:31'),
(62, 62, 30.00, 1, 0.00, 1, '2024-08-09 03:53:24', '2024-08-09 03:53:24'),
(63, 63, 40.00, 1, 0.00, 1, '2024-08-10 02:01:39', '2024-08-10 02:01:39'),
(64, 64, 0.00, 1, 0.00, 1, '2024-08-10 04:03:51', '2024-08-10 04:03:51'),
(65, 65, 0.00, 1, 0.00, 1, '2024-08-10 04:15:13', '2024-08-10 04:15:13'),
(66, 66, 0.00, 1, 0.00, 1, '2024-08-10 05:47:05', '2024-08-10 05:47:05'),
(67, 67, 0.00, 1, 0.00, 1, '2024-08-14 10:25:26', '2024-08-14 10:25:26'),
(68, 68, 0.00, 1, 0.00, 1, '2024-08-14 11:05:33', '2024-08-14 11:05:33'),
(69, 69, 0.00, 1, 0.00, 1, '2024-08-14 11:55:57', '2024-08-14 11:55:57'),
(70, 70, 0.00, 1, 0.00, 1, '2024-08-15 02:46:14', '2024-08-15 02:46:14'),
(71, 71, 0.00, 1, 0.00, 1, '2024-08-15 07:55:51', '2024-08-16 08:13:03'),
(72, 72, 0.00, 1, 0.00, 1, '2024-08-16 08:26:56', '2024-08-16 08:26:56'),
(73, 73, 0.00, 1, 0.00, 1, '2024-08-21 03:09:54', '2024-08-21 03:11:43'),
(74, 74, 0.00, 1, 0.00, 1, '2024-08-21 03:27:01', '2024-08-21 03:27:01'),
(75, 75, 0.00, 1, 0.00, 1, '2024-08-23 03:27:30', '2024-08-23 03:27:30'),
(76, 76, 0.00, 1, 0.00, 1, '2024-08-25 12:33:29', '2024-08-25 12:33:29'),
(77, 77, 0.00, 1, 0.00, 1, '2024-08-25 12:49:34', '2024-08-25 12:49:34'),
(78, 78, 0.00, 1, 0.00, 1, '2024-08-26 05:25:10', '2024-08-26 05:25:10'),
(79, 79, 0.00, 1, 0.00, 1, '2024-08-26 06:12:28', '2024-08-26 06:13:34'),
(80, 80, 0.00, 1, 0.00, 1, '2024-08-27 11:47:55', '2024-08-27 11:47:55'),
(81, 81, 0.00, 1, 0.00, 1, '2024-08-30 07:13:50', '2024-08-30 07:17:25'),
(82, 82, 0.00, 1, 0.00, 1, '2024-08-31 02:39:25', '2024-08-31 02:39:25'),
(83, 83, 0.00, 1, 0.00, 1, '2024-08-31 02:43:22', '2024-08-31 02:43:22'),
(84, 84, 0.00, 1, 0.00, 1, '2024-09-07 04:10:45', '2024-09-07 04:10:45'),
(85, 85, 0.00, 1, 0.00, 1, '2024-09-07 04:18:37', '2024-09-07 04:18:37'),
(86, 86, 0.00, 1, 0.00, 1, '2024-09-07 04:27:17', '2024-09-07 04:27:17'),
(87, 87, 0.00, 1, 0.00, 1, '2024-09-07 06:14:36', '2024-09-07 06:14:36'),
(88, 88, 40.00, 1, 0.00, 1, '2024-09-08 09:59:15', '2024-09-08 09:59:15'),
(89, 89, 0.00, 1, 0.00, 1, '2024-09-11 03:53:16', '2024-09-11 03:53:16'),
(90, 90, 0.00, 1, 0.00, 1, '2024-09-17 09:08:33', '2024-09-17 09:08:33'),
(91, 91, 0.00, 1, 0.00, 1, '2024-09-17 09:13:45', '2024-09-17 09:13:45'),
(92, 92, 0.00, 1, 0.00, 1, '2024-09-17 09:21:22', '2024-09-17 09:21:22'),
(93, 93, 0.00, 1, 0.00, 1, '2024-09-25 04:58:11', '2024-09-25 07:46:40'),
(94, 94, 0.00, 1, 0.00, 1, '2024-09-28 11:40:05', '2024-09-28 11:40:05'),
(95, 95, 0.00, 1, 0.00, 1, '2024-09-29 13:48:21', '2024-09-29 13:48:21'),
(96, 96, 0.00, 1, 0.00, 1, '2024-09-30 07:10:00', '2024-09-30 07:10:00'),
(97, 97, 0.00, 1, 0.00, 1, '2024-10-06 06:07:01', '2024-10-06 06:07:01'),
(98, 98, 0.00, 1, 0.00, 1, '2024-10-07 23:50:55', '2024-10-07 23:50:55'),
(99, 99, 0.00, 1, 0.00, 1, '2024-10-12 06:22:37', '2024-10-12 06:22:37'),
(100, 100, 0.00, 1, 0.00, 1, '2024-10-15 22:37:30', '2024-10-15 22:37:30'),
(101, 101, 0.00, 1, 0.00, 1, '2024-10-16 06:42:41', '2024-10-16 07:43:49'),
(102, 102, 100.00, 1, 0.00, 1, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(103, 103, 0.00, 1, 0.00, 1, '2024-10-21 01:57:30', '2024-10-21 01:57:30'),
(104, 104, 0.00, 1, 0.00, 1, '2024-10-25 09:19:04', '2024-10-25 09:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_type` enum('stock_return','damage_return') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stock_return',
  `party_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `paid_from` enum('cash','bank') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'paid from cash or bank',
  `previous_balance` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'party balance before completing purchase return',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_permanent` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `is_permanent`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'web', 1, '2024-03-21 03:52:20', '2024-03-21 03:52:20'),
(2, 'Manager', 'web', 1, '2024-03-21 03:52:20', '2024-03-21 03:52:20'),
(3, 'Operator', 'web', 1, '2024-03-21 03:52:20', '2024-03-21 03:52:20'),
(4, 'packaging', 'web', 0, '2024-04-08 21:36:08', '2024-04-08 21:36:08'),
(5, 'Chairman', 'web', 0, '2024-05-21 17:31:39', '2024-05-21 17:31:39'),
(6, 'Managing Director', 'web', 0, '2024-05-21 17:32:42', '2024-05-21 17:32:42');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5),
(7, 5),
(8, 5),
(9, 5),
(10, 5),
(11, 5),
(12, 5),
(13, 5),
(14, 5),
(15, 5),
(16, 5),
(17, 5),
(18, 5),
(19, 5),
(20, 5),
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 5),
(37, 5),
(38, 5),
(39, 5),
(40, 5),
(41, 5),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(46, 5),
(47, 5),
(48, 5),
(49, 5),
(50, 5),
(51, 5),
(52, 5),
(53, 5),
(54, 5),
(55, 5),
(56, 5),
(57, 5),
(58, 5),
(59, 5),
(60, 5),
(61, 5),
(62, 5),
(63, 5),
(64, 5),
(65, 5),
(66, 5),
(67, 5),
(68, 5),
(69, 5),
(70, 5),
(71, 5),
(72, 5),
(73, 5),
(74, 5),
(75, 5),
(76, 5),
(77, 5),
(78, 5),
(79, 5),
(80, 5),
(81, 5),
(82, 5),
(83, 5),
(84, 5),
(85, 5),
(86, 5),
(87, 5),
(88, 5),
(89, 5),
(90, 5),
(91, 5),
(92, 5),
(93, 5),
(94, 5),
(95, 5),
(96, 5),
(97, 5),
(98, 5),
(99, 5),
(100, 5),
(101, 5),
(102, 5),
(103, 5),
(104, 5),
(105, 5),
(106, 5),
(107, 5),
(108, 5),
(109, 5),
(110, 5),
(111, 5),
(112, 5),
(113, 5),
(114, 5),
(115, 5),
(116, 5),
(117, 5),
(118, 5),
(119, 5),
(120, 5),
(121, 5),
(122, 5),
(123, 5),
(124, 5),
(125, 5),
(126, 5),
(127, 5),
(128, 5),
(129, 5),
(130, 5),
(131, 5),
(132, 5),
(133, 5),
(134, 5),
(135, 5),
(136, 5),
(137, 5),
(138, 5),
(139, 5),
(140, 5),
(141, 5),
(142, 5),
(143, 5),
(144, 5),
(145, 5),
(146, 5),
(147, 5),
(148, 5),
(149, 5),
(150, 5),
(151, 5),
(152, 5),
(153, 5),
(154, 5),
(155, 5),
(156, 5),
(157, 5),
(158, 5),
(159, 5),
(160, 5),
(161, 5),
(162, 5),
(163, 5),
(164, 5),
(165, 5),
(166, 5),
(167, 5),
(168, 5),
(169, 5),
(170, 5),
(171, 5),
(172, 5),
(173, 5),
(174, 5),
(175, 5),
(176, 5),
(177, 5),
(178, 5),
(179, 5),
(180, 5),
(181, 5),
(182, 5),
(183, 5),
(184, 5),
(185, 5),
(186, 5),
(187, 5),
(188, 5),
(189, 5),
(190, 5),
(191, 5),
(192, 5),
(193, 5),
(194, 5),
(195, 5),
(196, 5),
(197, 5),
(198, 5),
(199, 5),
(200, 5),
(201, 5),
(202, 5),
(203, 5),
(204, 5),
(205, 5),
(206, 5),
(207, 5),
(208, 5),
(209, 5),
(210, 5),
(211, 5),
(212, 5),
(213, 5),
(214, 5),
(215, 5),
(216, 5),
(217, 5),
(218, 5),
(219, 5),
(220, 5),
(221, 5),
(222, 5),
(223, 5),
(224, 5),
(225, 5),
(226, 5),
(227, 5),
(228, 5),
(229, 5),
(230, 5),
(231, 5),
(232, 5),
(233, 5),
(234, 5),
(235, 5),
(236, 5),
(237, 5),
(238, 5),
(239, 5),
(240, 5),
(241, 5),
(242, 5),
(243, 5),
(244, 5),
(245, 5),
(246, 5),
(247, 5),
(248, 5),
(249, 5),
(250, 5),
(251, 5),
(252, 5),
(253, 5),
(254, 5),
(255, 5),
(256, 5),
(257, 5),
(258, 5),
(259, 5),
(260, 5),
(261, 5),
(262, 5),
(263, 5),
(264, 5),
(265, 5),
(266, 5),
(267, 5),
(268, 5),
(269, 5),
(270, 5),
(271, 5),
(272, 5),
(273, 5),
(274, 5),
(275, 5),
(276, 5),
(277, 5),
(278, 5),
(279, 5),
(280, 5),
(281, 5),
(282, 5),
(283, 5),
(284, 5),
(285, 5),
(286, 5),
(287, 5),
(288, 5),
(289, 5),
(290, 5),
(291, 5),
(292, 5),
(293, 5),
(294, 5),
(295, 5),
(296, 5),
(297, 5),
(298, 5),
(299, 5),
(300, 5),
(301, 5),
(302, 5),
(303, 5),
(304, 5),
(305, 5),
(306, 5),
(307, 5),
(308, 5),
(309, 5),
(310, 5),
(311, 5),
(312, 5),
(313, 5),
(314, 5),
(315, 5),
(316, 5),
(317, 5),
(318, 5),
(319, 5),
(320, 5),
(321, 5),
(322, 5),
(323, 5),
(324, 5),
(325, 5),
(326, 5),
(327, 5),
(328, 5),
(329, 5),
(330, 5),
(331, 5),
(332, 5),
(333, 5),
(334, 5),
(335, 5),
(336, 5),
(337, 5),
(338, 5),
(339, 5),
(340, 5),
(341, 5),
(342, 5),
(343, 5),
(344, 5),
(345, 5),
(346, 5),
(347, 5),
(348, 5),
(349, 5),
(350, 5),
(351, 5),
(352, 5),
(353, 5),
(354, 5),
(355, 5),
(356, 5),
(357, 5),
(358, 5),
(359, 5),
(360, 5),
(361, 5),
(362, 5),
(363, 5),
(364, 5),
(365, 5),
(366, 5),
(367, 5),
(368, 5),
(369, 5),
(370, 5),
(371, 5),
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(6, 6),
(7, 6),
(8, 6),
(9, 6),
(10, 6),
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(15, 6),
(16, 6),
(17, 6),
(18, 6),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 6),
(24, 6),
(25, 6),
(26, 6),
(27, 6),
(28, 6),
(29, 6),
(30, 6),
(31, 6),
(32, 6),
(33, 6),
(34, 6),
(35, 6),
(36, 6),
(37, 6),
(38, 6),
(39, 6),
(40, 6),
(41, 6),
(42, 6),
(43, 6),
(44, 6),
(45, 6),
(46, 6),
(47, 6),
(48, 6),
(49, 6),
(50, 6),
(51, 6),
(52, 6),
(53, 6),
(54, 6),
(55, 6),
(56, 6),
(57, 6),
(58, 6),
(59, 6),
(60, 6),
(61, 6),
(62, 6),
(63, 6),
(64, 6),
(65, 6),
(66, 6),
(67, 6),
(68, 6),
(69, 6),
(70, 6),
(71, 6),
(72, 6),
(73, 6),
(74, 6),
(75, 6),
(76, 6),
(77, 6),
(78, 6),
(79, 6),
(80, 6),
(81, 6),
(82, 6),
(83, 6),
(84, 6),
(85, 6),
(86, 6),
(87, 6),
(88, 6),
(89, 6),
(90, 6),
(91, 6),
(92, 6),
(93, 6),
(94, 6),
(95, 6),
(96, 6),
(97, 6),
(98, 6),
(99, 6),
(100, 6),
(101, 6),
(102, 6),
(103, 6),
(104, 6),
(105, 6),
(106, 6),
(107, 6),
(108, 6),
(109, 6),
(110, 6),
(111, 6),
(112, 6),
(113, 6),
(114, 6),
(115, 6),
(116, 6),
(117, 6),
(118, 6),
(119, 6),
(120, 6),
(121, 6),
(122, 6),
(123, 6),
(124, 6),
(125, 6),
(126, 6),
(127, 6),
(128, 6),
(129, 6),
(130, 6),
(131, 6),
(132, 6),
(133, 6),
(134, 6),
(135, 6),
(136, 6),
(137, 6),
(138, 6),
(139, 6),
(140, 6),
(141, 6),
(142, 6),
(143, 6),
(144, 6),
(145, 6),
(146, 6),
(147, 6),
(148, 6),
(149, 6),
(150, 6),
(151, 6),
(152, 6),
(153, 6),
(154, 6),
(155, 6),
(156, 6),
(157, 6),
(158, 6),
(159, 6),
(160, 6),
(161, 6),
(162, 6),
(163, 6),
(164, 6),
(165, 6),
(166, 6),
(167, 6),
(168, 6),
(169, 6),
(170, 6),
(171, 6),
(172, 6),
(173, 6),
(174, 6),
(175, 6),
(176, 6),
(177, 6),
(178, 6),
(179, 6),
(180, 6),
(181, 6),
(182, 6),
(183, 6),
(184, 6),
(185, 6),
(186, 6),
(187, 6),
(188, 6),
(189, 6),
(190, 6),
(191, 6),
(192, 6),
(193, 6),
(194, 6),
(195, 6),
(196, 6),
(197, 6),
(198, 6),
(199, 6),
(200, 6),
(201, 6),
(202, 6),
(203, 6),
(204, 6),
(205, 6),
(206, 6),
(207, 6),
(208, 6),
(209, 6),
(210, 6),
(211, 6),
(212, 6),
(213, 6),
(214, 6),
(215, 6),
(216, 6),
(217, 6),
(218, 6),
(219, 6),
(220, 6),
(221, 6),
(222, 6),
(223, 6),
(224, 6),
(225, 6),
(226, 6),
(227, 6),
(228, 6),
(229, 6),
(230, 6),
(231, 6),
(232, 6),
(233, 6),
(234, 6),
(235, 6),
(236, 6),
(237, 6),
(238, 6),
(239, 6),
(240, 6),
(241, 6),
(242, 6),
(243, 6),
(244, 6),
(245, 6),
(246, 6),
(247, 6),
(248, 6),
(249, 6),
(250, 6),
(251, 6),
(252, 6),
(253, 6),
(254, 6),
(255, 6),
(256, 6),
(257, 6),
(258, 6),
(259, 6),
(260, 6),
(261, 6),
(262, 6),
(263, 6),
(264, 6),
(265, 6),
(266, 6),
(267, 6),
(268, 6),
(269, 6),
(270, 6),
(271, 6),
(272, 6),
(273, 6),
(274, 6),
(275, 6),
(276, 6),
(277, 6),
(278, 6),
(279, 6),
(280, 6),
(281, 6),
(282, 6),
(283, 6),
(284, 6),
(285, 6),
(286, 6),
(287, 6),
(288, 6),
(289, 6),
(290, 6),
(291, 6),
(292, 6),
(293, 6),
(294, 6),
(295, 6),
(296, 6),
(297, 6),
(298, 6),
(299, 6),
(300, 6),
(301, 6),
(302, 6),
(303, 6),
(304, 6),
(305, 6),
(306, 6),
(307, 6),
(308, 6),
(309, 6),
(310, 6),
(311, 6),
(312, 6),
(313, 6),
(314, 6),
(315, 6),
(316, 6),
(317, 6),
(318, 6),
(319, 6),
(320, 6),
(321, 6),
(322, 6),
(323, 6),
(324, 6),
(325, 6),
(326, 6),
(327, 6),
(328, 6),
(329, 6),
(330, 6),
(331, 6),
(332, 6),
(333, 6),
(334, 6),
(335, 6),
(336, 6),
(337, 6),
(338, 6),
(339, 6),
(340, 6),
(341, 6),
(342, 6),
(343, 6),
(344, 6),
(345, 6),
(346, 6),
(347, 6),
(348, 6),
(349, 6),
(350, 6),
(351, 6),
(352, 6),
(353, 6),
(354, 6),
(355, 6),
(356, 6),
(357, 6),
(358, 6),
(359, 6),
(360, 6),
(361, 6),
(362, 6),
(363, 6),
(364, 6),
(365, 6),
(366, 6),
(367, 6),
(368, 6),
(369, 6),
(370, 6),
(371, 6);

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `employee_id` bigint UNSIGNED NOT NULL COMMENT 'Employee from users',
  `cash_id` bigint UNSIGNED DEFAULT NULL,
  `bank_account_id` bigint UNSIGNED DEFAULT NULL,
  `salary_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `given_date` date NOT NULL COMMENT 'salary given date',
  `salary_month` date NOT NULL COMMENT 'month of salary',
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`id`, `user_id`, `employee_id`, `cash_id`, `bank_account_id`, `salary_no`, `given_date`, `salary_month`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, NULL, '00000001', '2024-04-08', '0024-03-01', NULL, '2024-04-08 21:40:01', '2024-04-08 21:40:01'),
(2, 1, 2, 3, NULL, '00000002', '2024-05-11', '2024-04-01', NULL, '2024-05-11 20:50:47', '2024-05-11 20:50:47'),
(3, 1, 3, 3, NULL, '00000003', '2024-05-22', '2024-04-01', NULL, '2024-05-22 12:07:24', '2024-05-22 12:07:24'),
(4, 1, 4, 3, NULL, '00000004', '2024-05-22', '2024-04-01', NULL, '2024-05-22 12:07:52', '2024-05-22 12:07:52'),
(5, 1, 5, 3, NULL, '00000005', '2024-05-22', '2024-04-01', NULL, '2024-05-22 12:08:21', '2024-05-22 12:08:21'),
(6, 1, 2, 3, NULL, '00000007', '2024-06-14', '2024-06-01', NULL, '2024-06-14 15:59:45', '2024-06-15 14:50:22'),
(7, 1, 3, 3, NULL, '00000007', '2024-06-16', '2024-06-01', NULL, '2024-06-16 20:49:35', '2024-06-16 20:49:35'),
(8, 1, 4, 3, NULL, '00000008', '2024-06-16', '2024-06-01', NULL, '2024-06-16 20:50:11', '2024-06-16 20:50:11'),
(9, 1, 5, 3, NULL, '00000009', '2024-06-16', '2024-06-01', NULL, '2024-06-16 21:02:53', '2024-06-16 21:02:53'),
(10, 1, 2, 3, NULL, '00000010', '2024-07-07', '2024-07-01', NULL, '2024-07-07 22:06:32', '2024-07-07 22:06:32'),
(11, 1, 2, 3, NULL, '00000011', '2024-08-05', '2024-08-01', NULL, '2024-08-05 10:12:00', '2024-08-05 10:12:00'),
(12, 1, 1, 3, NULL, '00000012', '2024-08-06', '2024-07-01', NULL, '2024-08-06 12:05:27', '2024-08-06 12:05:27'),
(13, 1, 3, 3, NULL, '00000013', '2024-08-06', '2024-07-01', NULL, '2024-08-06 12:06:08', '2024-08-06 12:06:08'),
(14, 1, 4, 3, NULL, '00000014', '2024-08-06', '2024-07-01', NULL, '2024-08-06 12:06:24', '2024-08-06 12:06:24'),
(15, 1, 1, 3, NULL, '00000015', '2024-08-06', '2024-08-01', NULL, '2024-08-06 12:07:00', '2024-08-06 12:07:00'),
(16, 1, 3, 3, NULL, '00000016', '2024-08-06', '2024-08-01', NULL, '2024-08-06 12:07:20', '2024-08-06 12:07:20'),
(17, 1, 4, 3, NULL, '00000017', '2024-08-06', '2024-08-01', NULL, '2024-08-06 12:07:38', '2024-08-06 12:07:38'),
(18, 1, 2, 3, NULL, '00000018', '2024-09-05', '2024-09-01', NULL, '2024-09-05 11:14:01', '2024-09-05 11:14:01'),
(19, 1, 1, 3, NULL, '00000019', '2024-09-08', '2024-09-01', NULL, '2024-09-08 06:30:46', '2024-09-08 06:30:46'),
(20, 1, 3, 3, NULL, '00000020', '2024-09-08', '2024-09-01', NULL, '2024-09-08 06:31:15', '2024-09-08 06:31:15'),
(21, 1, 4, 3, NULL, '00000021', '2024-09-08', '2024-09-01', NULL, '2024-09-08 06:31:54', '2024-09-08 06:31:54'),
(22, 1, 2, 3, NULL, '00000022', '2024-10-02', '2024-10-01', NULL, '2024-10-02 11:22:37', '2024-10-02 11:22:37'),
(23, 1, 3, 3, NULL, '00000023', '2024-10-05', '2024-10-01', NULL, '2024-10-05 12:19:51', '2024-10-05 12:19:51'),
(24, 1, 4, 3, NULL, '00000024', '2024-10-05', '2024-10-01', NULL, '2024-10-05 12:20:08', '2024-10-05 12:20:08'),
(25, 1, 1, 3, NULL, '00000025', '2024-10-08', '2024-10-01', NULL, '2024-10-07 22:44:48', '2024-10-07 22:44:48');

-- --------------------------------------------------------

--
-- Table structure for table `salary_details`
--

CREATE TABLE `salary_details` (
  `id` bigint UNSIGNED NOT NULL,
  `salary_id` bigint UNSIGNED NOT NULL,
  `purpose` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'the purpose of salary amount',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'positive balance means give amount to user, negative balance means take amount from user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `salary_details`
--

INSERT INTO `salary_details` (`id`, `salary_id`, `purpose`, `amount`, `created_at`, `updated_at`) VALUES
(1, 1, 'basic_salary', 3500.00, '2024-04-08 21:40:01', '2024-04-08 21:40:01'),
(2, 2, 'basic_salary', 3500.00, '2024-05-11 20:50:47', '2024-05-11 20:50:47'),
(3, 3, 'basic_salary', 5000.00, '2024-05-22 12:07:24', '2024-05-22 12:07:24'),
(4, 4, 'basic_salary', 5000.00, '2024-05-22 12:07:53', '2024-05-22 12:07:53'),
(5, 5, 'basic_salary', 8000.00, '2024-05-22 12:08:21', '2024-05-22 12:08:21'),
(7, 6, 'basic_salary', 3500.00, '2024-06-15 14:50:22', '2024-06-15 14:50:22'),
(8, 6, 'bonus', 1500.00, '2024-06-15 14:50:22', '2024-06-15 14:50:22'),
(9, 7, 'basic_salary', 5000.00, '2024-06-16 20:49:35', '2024-06-16 20:49:35'),
(10, 7, 'bonus', 1000.00, '2024-06-16 20:49:35', '2024-06-16 20:49:35'),
(11, 8, 'basic_salary', 5000.00, '2024-06-16 20:50:11', '2024-06-16 20:50:11'),
(12, 8, 'bonus', 1000.00, '2024-06-16 20:50:11', '2024-06-16 20:50:11'),
(13, 9, 'basic_salary', 8000.00, '2024-06-16 21:02:53', '2024-06-16 21:02:53'),
(14, 9, 'bonus', 4000.00, '2024-06-16 21:02:53', '2024-06-16 21:02:53'),
(15, 10, 'basic_salary', 3500.00, '2024-07-07 22:06:32', '2024-07-07 22:06:32'),
(16, 11, 'basic_salary', 3500.00, '2024-08-05 10:12:00', '2024-08-05 10:12:00'),
(17, 12, 'basic_salary', 8000.00, '2024-08-06 12:05:27', '2024-08-06 12:05:27'),
(18, 13, 'basic_salary', 6000.00, '2024-08-06 12:06:08', '2024-08-06 12:06:08'),
(19, 14, 'basic_salary', 6000.00, '2024-08-06 12:06:24', '2024-08-06 12:06:24'),
(20, 15, 'basic_salary', 8000.00, '2024-08-06 12:07:00', '2024-08-06 12:07:00'),
(21, 16, 'basic_salary', 6000.00, '2024-08-06 12:07:20', '2024-08-06 12:07:20'),
(22, 17, 'basic_salary', 6000.00, '2024-08-06 12:07:38', '2024-08-06 12:07:38'),
(23, 18, 'basic_salary', 3500.00, '2024-09-05 11:14:01', '2024-09-05 11:14:01'),
(24, 19, 'basic_salary', 8000.00, '2024-09-08 06:30:46', '2024-09-08 06:30:46'),
(25, 20, 'basic_salary', 10000.00, '2024-09-08 06:31:15', '2024-09-08 06:31:15'),
(26, 21, 'basic_salary', 10000.00, '2024-09-08 06:31:54', '2024-09-08 06:31:54'),
(27, 22, 'basic_salary', 3500.00, '2024-10-02 11:22:37', '2024-10-02 11:22:37'),
(28, 23, 'basic_salary', 10000.00, '2024-10-05 12:19:51', '2024-10-05 12:19:51'),
(29, 24, 'basic_salary', 10000.00, '2024-10-05 12:20:08', '2024-10-05 12:20:08'),
(30, 25, 'basic_salary', 8000.00, '2024-10-07 22:44:48', '2024-10-07 22:44:48');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `invoice_no` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `party_id` bigint UNSIGNED NOT NULL COMMENT 'Customer id',
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `subtotal` decimal(12,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat' COMMENT 'percentage/flat',
  `labour_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `transport_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `due` decimal(12,2) NOT NULL DEFAULT '0.00',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00',
  `previous_balance` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'customer previous balance before completing sale',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `date`, `invoice_no`, `party_id`, `branch_id`, `user_id`, `subtotal`, `discount`, `discount_type`, `labour_cost`, `transport_cost`, `paid`, `due`, `change`, `previous_balance`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, '2024-03-31', 'Invoice-00000001', 4, 1, 1, 98244.00, 0.00, 'flat', 0.00, 0.00, 4410.00, 93834.00, 0.00, 0.00, NULL, NULL, '2024-04-04 18:58:02', '2024-04-04 19:02:53'),
(4, '2024-04-04', 'Invoice-00000004', 4, 1, 1, 2750.00, 0.00, 'flat', 0.00, 0.00, 5000.00, 91584.00, 0.00, 93834.00, 'null', NULL, '2024-04-04 19:20:38', '2024-04-04 19:20:38'),
(5, '2024-04-04', 'Invoice-00000005', 4, 1, 1, 7285.00, 0.00, 'flat', 0.00, 0.00, 5000.00, 93869.00, 0.00, 91584.00, NULL, NULL, '2024-04-04 19:25:25', '2024-04-04 19:29:18'),
(6, '2024-04-04', 'Invoice-00000006', 4, 1, 1, 8200.00, 0.00, 'flat', 0.00, 0.00, 0.00, 97069.00, 0.00, 88869.00, 'null', NULL, '2024-04-04 22:03:29', '2024-04-04 22:03:29'),
(8, '2024-04-05', 'Invoice-00000007', 4, 1, 1, 20080.00, 149.00, 'flat', 0.00, 0.00, 0.00, 117000.00, 0.00, 97069.00, NULL, NULL, '2024-04-05 19:21:30', '2024-04-05 19:53:09'),
(9, '2024-04-16', 'Invoice-00000009', 4, 1, 1, 1680.00, 0.00, 'flat', 0.00, 0.00, 0.00, 33680.00, 0.00, 32000.00, 'null', NULL, '2024-04-16 12:26:11', '2024-04-16 12:26:11'),
(10, '2024-04-17', 'Invoice-00000010', 4, 1, 1, 26610.00, 0.00, 'flat', 0.00, 0.00, 5000.00, 55290.00, 0.00, 33680.00, NULL, NULL, '2024-04-17 12:14:09', '2024-04-18 19:56:51'),
(11, '2024-04-21', 'Invoice-00000011', 4, 1, 1, 2400.00, 0.00, 'flat', 0.00, 0.00, 0.00, 52690.00, 0.00, 50290.00, 'null', NULL, '2024-04-21 19:43:17', '2024-04-21 19:43:17'),
(12, '2024-04-23', 'Invoice-00000012', 4, 1, 1, 1360.00, 0.00, 'flat', 0.00, 0.00, 0.00, 54050.00, 0.00, 52690.00, NULL, NULL, '2024-04-23 11:47:14', '2024-04-23 11:49:01'),
(13, '2024-04-23', 'Invoice-00000013', 4, 1, 1, 0.00, 0.00, 'flat', 0.00, 0.00, 0.00, 54050.00, 0.00, 54050.00, 'null', NULL, '2024-04-23 11:52:00', '2024-04-23 11:52:00'),
(14, '2024-04-23', 'Invoice-00000014', 4, 1, 1, 700.00, 0.00, 'flat', 0.00, 0.00, 0.00, 54750.00, 0.00, 54050.00, 'null', NULL, '2024-04-23 17:34:41', '2024-04-23 17:34:41'),
(15, '2024-04-25', 'Invoice-00000015', 4, 1, 1, 10575.00, 0.00, 'flat', 0.00, 0.00, 0.00, 55325.00, 0.00, 44750.00, 'null', NULL, '2024-04-25 20:44:23', '2024-04-25 20:44:23'),
(16, '2024-04-25', 'Invoice-00000016', 4, 1, 1, 400.00, 0.00, 'flat', 0.00, 0.00, 0.00, 55725.00, 0.00, 55325.00, 'null', NULL, '2024-04-25 21:13:17', '2024-04-25 21:13:17'),
(28, '2024-05-02', 'Invoice-00000017', 4, 1, 1, 41756.00, 0.00, 'flat', 0.00, 0.00, 0.00, 76756.00, 0.00, 35000.00, NULL, NULL, '2024-05-02 13:38:52', '2024-05-06 19:48:31'),
(29, '2024-05-02', 'Invoice-00000029', 4, 1, 1, 69740.00, 0.00, 'flat', 0.00, 0.00, 0.00, 153996.00, 0.00, 84256.00, 'null', NULL, '2024-05-02 13:43:52', '2024-05-02 13:43:52'),
(30, '2024-05-03', 'Invoice-00000030', 4, 1, 1, 7825.00, 0.00, 'flat', 0.00, 0.00, 0.00, 161821.00, 0.00, 153996.00, NULL, NULL, '2024-05-03 16:50:29', '2024-05-03 18:59:27'),
(31, '2024-05-04', 'Invoice-00000031', 4, 1, 1, 11572.00, 0.00, 'flat', 0.00, 0.00, 0.00, 153393.00, 0.00, 141821.00, 'null', NULL, '2024-05-04 14:32:58', '2024-05-04 14:32:58'),
(32, '2024-05-04', 'Invoice-00000032', 4, 1, 1, 0.00, 0.00, 'flat', 0.00, 0.00, 0.00, 153393.00, 0.00, 153393.00, 'null', NULL, '2024-05-04 14:38:10', '2024-05-04 14:38:10'),
(33, '2024-05-06', 'Invoice-00000033', 4, 1, 1, 82310.00, 3.00, 'flat', 0.00, 0.00, 0.00, 235700.00, 0.00, 153393.00, 'null', NULL, '2024-05-06 14:07:46', '2024-05-06 14:07:46'),
(34, '2024-05-08', 'Invoice-00000034', 4, 1, 1, 14800.00, 0.00, 'flat', 0.00, 0.00, 10000.00, 214790.00, 0.00, 209990.00, 'null', NULL, '2024-05-08 21:15:47', '2024-05-08 21:15:47'),
(35, '2024-05-17', 'Invoice-00000035', 4, 1, 1, 4068.00, 8.00, 'flat', 0.00, 0.00, 0.00, 174050.00, 0.00, 169990.00, NULL, NULL, '2024-05-17 18:02:47', '2024-05-17 18:04:31'),
(36, '2024-05-18', 'Invoice-00000036', 4, 1, 1, 25000.00, 0.00, 'flat', 0.00, 0.00, 0.00, 189050.00, 0.00, 164050.00, 'null', NULL, '2024-05-18 14:20:55', '2024-05-18 14:20:55'),
(37, '2024-05-22', 'Invoice-00000037', 4, 1, 1, 7600.00, 0.00, 'flat', 0.00, 0.00, 0.00, 177600.00, 0.00, 170000.00, 'null', NULL, '2024-05-22 08:38:31', '2024-05-22 08:38:31'),
(38, '2024-05-26', 'Invoice-00000038', 4, 1, 1, 16091.50, 41.50, 'flat', 0.00, 0.00, 0.00, 163650.00, 0.00, 147600.00, 'null', NULL, '2024-05-26 16:42:09', '2024-05-26 16:42:09'),
(39, '2024-05-28', 'Invoice-00000039', 4, 1, 1, 3200.00, 0.00, 'flat', 0.00, 0.00, 0.00, 166850.00, 0.00, 163650.00, 'null', NULL, '2024-05-28 19:35:21', '2024-05-28 19:35:21'),
(40, '2024-06-01', 'Invoice-00000040', 4, 1, 1, 4500.00, 0.00, 'flat', 0.00, 0.00, 10000.00, 151350.00, 0.00, 156850.00, 'null', NULL, '2024-06-01 20:12:32', '2024-06-01 20:12:32'),
(41, '2024-06-06', 'Invoice-00000041', 4, 1, 1, 100650.00, 0.00, 'flat', 0.00, 0.00, 0.00, 242000.00, 0.00, 141350.00, 'null', NULL, '2024-06-06 16:48:42', '2024-06-06 16:48:42'),
(42, '2024-06-07', 'Invoice-00000042', 4, 1, 1, 10440.00, 0.00, 'flat', 0.00, 0.00, 0.00, 252440.00, 0.00, 242000.00, 'null', NULL, '2024-06-07 17:05:12', '2024-06-07 17:05:12'),
(43, '2024-06-08', 'Invoice-00000043', 4, 1, 1, 7950.00, 0.00, 'flat', 0.00, 0.00, 0.00, 260390.00, 0.00, 252440.00, 'null', NULL, '2024-06-08 16:17:09', '2024-06-08 16:17:09'),
(44, '2024-06-08', 'Invoice-00000044', 4, 1, 1, 420.00, 0.00, 'flat', 0.00, 0.00, 0.00, 250810.00, 0.00, 250390.00, 'null', NULL, '2024-06-08 21:09:48', '2024-06-08 21:09:48'),
(45, '2024-06-09', 'Invoice-00000045', 4, 1, 1, 13080.00, 0.00, 'flat', 0.00, 0.00, 0.00, 263890.00, 0.00, 250810.00, 'null', NULL, '2024-06-09 16:32:21', '2024-06-09 16:32:21'),
(46, '2024-06-10', 'Invoice-00000046', 4, 1, 1, 66351.00, 1.00, 'flat', 0.00, 0.00, 0.00, 330240.00, 0.00, 263890.00, 'null', NULL, '2024-06-10 21:05:18', '2024-06-10 21:05:18'),
(47, '2024-06-11', 'Invoice-00000047', 4, 1, 1, 9600.00, 0.00, 'flat', 0.00, 0.00, 0.00, 339840.00, 0.00, 330240.00, 'null', NULL, '2024-06-11 21:55:48', '2024-06-11 21:55:48'),
(48, '2024-06-13', 'Invoice-00000048', 4, 1, 1, 17894.00, 0.00, 'flat', 0.00, 0.00, 0.00, 357734.00, 0.00, 339840.00, 'null', NULL, '2024-06-13 17:53:12', '2024-06-13 17:53:12'),
(49, '2024-06-14', 'Invoice-00000049', 4, 1, 1, 14130.00, 0.00, 'flat', 0.00, 0.00, 0.00, 371864.00, 0.00, 357734.00, 'null', NULL, '2024-06-14 13:51:59', '2024-06-14 13:51:59'),
(50, '2024-06-14', 'Invoice-00000050', 4, 1, 1, 22400.00, 0.00, 'flat', 0.00, 0.00, 0.00, 394264.00, 0.00, 371864.00, NULL, NULL, '2024-06-14 15:17:27', '2024-06-14 20:25:03'),
(51, '2024-06-15', 'Invoice-00000051', 4, 1, 1, 828.00, 0.00, 'flat', 0.00, 0.00, 0.00, 395092.00, 0.00, 394264.00, 'null', NULL, '2024-06-15 23:18:34', '2024-06-15 23:18:34'),
(52, '2024-06-25', 'Invoice-00000052', 4, 1, 1, 19560.00, 0.00, 'flat', 0.00, 0.00, 0.00, 284652.00, 0.00, 265092.00, 'null', NULL, '2024-06-25 18:46:14', '2024-06-25 18:46:14'),
(53, '2024-06-26', 'Invoice-00000053', 4, 1, 1, 8700.00, 0.00, 'flat', 0.00, 0.00, 0.00, 283352.00, 0.00, 274652.00, 'null', NULL, '2024-06-26 14:29:24', '2024-06-26 14:29:24'),
(54, '2024-06-27', 'Invoice-00000054', 4, 1, 1, 54380.00, 380.00, 'flat', 0.00, 0.00, 0.00, 332352.00, 0.00, 278352.00, 'null', NULL, '2024-06-27 21:00:08', '2024-06-27 21:00:08'),
(55, '2024-06-30', 'Invoice-00000055', 4, 1, 1, 36500.00, 0.00, 'flat', 0.00, 0.00, 0.00, 348852.00, 0.00, 312352.00, 'null', NULL, '2024-06-30 12:23:17', '2024-06-30 12:23:17'),
(56, '2024-07-04', 'Invoice-00000056', 4, 1, 1, 60562.00, 288.00, 'flat', 0.00, 0.00, 0.00, 389081.00, 0.00, 328807.00, NULL, NULL, '2024-07-04 16:15:17', '2024-07-06 19:43:52'),
(57, '2024-07-11', 'Invoice-00000057', 4, 1, 1, 14000.00, 0.00, 'flat', 0.00, 0.00, 0.00, 370281.00, 0.00, 356281.00, 'null', NULL, '2024-07-11 20:41:42', '2024-07-11 20:41:42'),
(58, '2024-07-11', 'Invoice-00000058', 4, 1, 1, 15600.00, 0.00, 'flat', 0.00, 0.00, 0.00, 385881.00, 0.00, 370281.00, 'null', NULL, '2024-07-11 20:58:27', '2024-07-11 20:58:27'),
(59, '2024-07-16', 'Invoice-00000059', 4, 1, 1, 31250.00, 0.00, 'flat', 0.00, 0.00, 0.00, 397131.00, 0.00, 365881.00, 'null', NULL, '2024-07-16 14:22:51', '2024-07-16 14:22:51'),
(60, '2024-07-24', 'Invoice-00000060', 4, 1, 1, 6500.00, 0.00, 'flat', 0.00, 0.00, 0.00, 393631.00, 0.00, 387131.00, 'null', NULL, '2024-07-24 15:15:11', '2024-07-24 15:15:11'),
(61, '2024-07-30', 'Invoice-00000061', 4, 1, 1, 107270.00, 0.00, 'flat', 0.00, 0.00, 0.00, 434901.00, 0.00, 327631.00, 'null', NULL, '2024-07-31 00:35:12', '2024-07-31 00:35:12'),
(62, '2024-07-31', 'Invoice-00000062', 4, 1, 1, 38344.00, 0.00, 'flat', 0.00, 0.00, 0.00, 473245.00, 0.00, 434901.00, 'null', NULL, '2024-07-31 21:29:08', '2024-07-31 21:29:08'),
(63, '2024-08-04', 'Invoice-00000063', 9, 1, 1, 114072.00, 0.00, 'flat', 0.00, 0.00, 0.00, 74072.00, 0.00, -40000.00, NULL, NULL, '2024-08-04 04:22:04', '2024-08-04 04:24:26'),
(69, '2024-08-04', 'Invoice-00000064', 4, 1, 1, 5244.00, 0.00, 'flat', 0.00, 0.00, 0.00, 478489.00, 0.00, 473245.00, 'null', NULL, '2024-08-04 04:46:17', '2024-08-04 04:46:17'),
(70, '2024-08-05', 'Invoice-00000070', 4, 1, 1, 7500.00, 0.00, 'flat', 0.00, 0.00, 0.00, 470989.00, 0.00, 463489.00, 'null', NULL, '2024-08-05 09:11:39', '2024-08-05 09:11:39'),
(71, '2024-08-06', 'Invoice-00000071', 9, 1, 1, 39965.00, 0.00, 'flat', 0.00, 0.00, 0.00, 114037.00, 0.00, 74072.00, 'null', NULL, '2024-08-06 05:25:03', '2024-08-06 05:25:03'),
(72, '2024-08-10', 'Invoice-00000072', 9, 1, 1, 148072.00, 0.00, 'flat', 0.00, 0.00, 148069.00, 0.00, 0.00, -3.00, 'null', NULL, '2024-08-10 04:33:59', '2024-08-10 04:33:59'),
(73, '2024-08-10', 'Invoice-00000073', 9, 1, 1, 40000.00, 0.00, 'flat', 0.00, 0.00, 40000.00, 0.00, 0.00, 0.00, NULL, NULL, '2024-08-10 04:41:54', '2024-08-10 04:57:19'),
(75, '2024-08-10', 'Invoice-00000074', 9, 1, 1, 78675.00, 280.00, 'flat', 0.00, 0.00, 78395.00, 0.00, 0.00, 0.00, NULL, NULL, '2024-08-10 05:49:32', '2024-08-10 09:52:36'),
(76, '2024-08-10', 'Invoice-00000076', 4, 1, 1, 119480.00, 0.00, 'flat', 0.00, 0.00, 0.00, 530469.00, 0.00, 410989.00, 'null', NULL, '2024-08-10 09:48:30', '2024-08-10 09:48:30'),
(77, '2024-08-14', 'Invoice-00000077', 9, 1, 1, 207367.00, 0.00, 'flat', 0.00, 0.00, 0.00, 207367.00, 0.00, 0.00, 'null', NULL, '2024-08-14 12:28:09', '2024-08-14 12:28:09'),
(78, '2024-08-15', 'Invoice-00000078', 9, 1, 1, 83880.00, 0.00, 'flat', 0.00, 0.00, 0.00, 291247.00, 0.00, 207367.00, 'null', NULL, '2024-08-15 02:47:05', '2024-08-15 02:47:05'),
(79, '2024-08-16', 'Invoice-00000079', 4, 1, 1, 114782.00, 0.00, 'flat', 0.00, 0.00, 0.00, 645251.00, 0.00, 530469.00, 'null', NULL, '2024-08-16 08:21:15', '2024-08-16 08:21:15'),
(80, '2024-08-21', 'Invoice-00000080', 4, 1, 1, 420000.00, 0.00, 'flat', 0.00, 0.00, 0.00, 765251.00, 0.00, 345251.00, NULL, NULL, '2024-08-21 03:13:03', '2024-08-21 11:12:15'),
(81, '2024-08-23', 'Invoice-00000081', 4, 1, 1, 2820.00, 0.00, 'flat', 0.00, 0.00, 0.00, 753071.00, 0.00, 750251.00, NULL, NULL, '2024-08-23 03:30:52', '2024-08-23 03:31:23'),
(82, '2024-08-25', 'Invoice-00000082', 4, 1, 1, 50000.00, 0.00, 'flat', 0.00, 0.00, 0.00, 748071.00, 0.00, 698071.00, 'null', NULL, '2024-08-25 12:33:59', '2024-08-25 12:33:59'),
(83, '2024-08-26', 'Invoice-00000083', 4, 1, 1, 27432.00, 0.00, 'flat', 0.00, 0.00, 0.00, 760503.00, 0.00, 733071.00, 'null', NULL, '2024-08-26 05:27:14', '2024-08-26 05:27:14'),
(84, '2024-08-26', 'Invoice-00000084', 4, 1, 1, 90913.00, 0.00, 'flat', 0.00, 0.00, 0.00, 851416.00, 0.00, 760503.00, 'null', NULL, '2024-08-26 06:18:43', '2024-08-26 06:18:43'),
(85, '2024-08-28', 'Invoice-00000085', 9, 1, 1, 19480.00, 2420.00, 'flat', 0.00, 0.00, 0.00, 58307.00, 0.00, 41247.00, 'null', NULL, '2024-08-28 10:31:18', '2024-08-28 10:31:18'),
(86, '2024-08-31', 'Invoice-00000086', 4, 1, 1, 52155.00, 0.00, 'flat', 0.00, 0.00, 0.00, 818571.00, 0.00, 766416.00, 'null', NULL, '2024-08-31 04:17:41', '2024-08-31 04:17:41'),
(87, '2024-08-31', 'Invoice-00000087', 4, 1, 1, 4225.00, 0.00, 'flat', 0.00, 0.00, 0.00, 822796.00, 0.00, 818571.00, 'null', NULL, '2024-08-31 04:20:27', '2024-08-31 04:20:27'),
(88, '2024-09-07', 'Invoice-00000088', 9, 1, 1, 55100.00, 0.00, 'flat', 0.00, 0.00, 0.00, 93407.00, 0.00, 38307.00, 'null', NULL, '2024-09-07 05:05:32', '2024-09-07 05:05:32'),
(89, '2024-09-08', 'Invoice-00000089', 4, 1, 1, 27060.00, 0.00, 'flat', 0.00, 0.00, 0.00, 804856.00, 0.00, 777796.00, 'null', NULL, '2024-09-08 04:48:21', '2024-09-08 04:48:21'),
(90, '2024-09-11', 'Invoice-00000090', 9, 1, 1, 12480.00, 0.00, 'flat', 0.00, 0.00, 0.00, 47887.00, 0.00, 35407.00, 'null', NULL, '2024-09-11 03:53:43', '2024-09-11 03:53:43'),
(91, '2024-09-17', 'Invoice-00000091', 4, 1, 1, 137440.00, 0.00, 'flat', 0.00, 0.00, 0.00, 942296.00, 0.00, 804856.00, NULL, NULL, '2024-09-17 09:20:06', '2024-09-17 09:21:56'),
(92, '2024-09-25', 'Invoice-00000092', 4, 1, 1, 157764.00, 0.00, 'flat', 0.00, 0.00, 0.00, 1005060.00, 0.00, 847296.00, 'null', NULL, '2024-09-25 08:22:13', '2024-09-25 08:22:13'),
(93, '2024-09-30', 'Invoice-00000093', 4, 1, 1, 49095.00, 0.00, 'flat', 0.00, 0.00, 0.00, 854155.00, 0.00, 805060.00, NULL, NULL, '2024-09-30 03:28:03', '2024-09-30 08:58:54'),
(94, '2024-10-06', 'Invoice-00000094', 4, 1, 1, 45685.00, 0.00, 'flat', 0.00, 0.00, 0.00, 801840.00, 0.00, 756155.00, 'null', NULL, '2024-10-06 06:15:53', '2024-10-06 06:28:22'),
(95, '2024-10-07', 'Invoice-00000095', 4, 1, 1, 6720.00, 0.00, 'flat', 0.00, 0.00, 0.00, 808560.00, 0.00, 801840.00, 'null', NULL, '2024-10-07 03:13:25', '2024-10-07 03:13:25'),
(96, '2024-10-09', 'Invoice-00000096', 4, 1, 1, 66285.00, 0.00, 'flat', 0.00, 0.00, 0.00, 839845.00, 0.00, 773560.00, NULL, NULL, '2024-10-09 07:06:28', '2024-10-12 06:23:53'),
(98, '2024-10-10', 'Invoice-00000097', 9, 1, 1, 9680.00, 0.00, 'flat', 0.00, 0.00, 0.00, 42567.00, 0.00, 32887.00, 'null', NULL, '2024-10-10 10:52:12', '2024-10-10 10:52:12'),
(99, '2024-10-16', 'Invoice-00000099', 4, 1, 1, 38640.00, 0.00, 'flat', 0.00, 0.00, 0.00, 788485.00, 0.00, 749845.00, 'null', NULL, '2024-10-15 22:39:49', '2024-10-15 22:39:49'),
(100, '2024-10-16', 'Invoice-00000100', 4, 1, 1, 132289.00, 2289.00, 'flat', 0.00, 0.00, 0.00, 918485.00, 0.00, 788485.00, 'null', NULL, '2024-10-16 06:50:45', '2024-10-16 07:43:21'),
(101, '2024-10-19', 'Invoice-00000101', 4, 1, 1, 28970.00, 0.00, 'flat', 0.00, 0.00, 0.00, 927455.00, 0.00, 898485.00, 'null', NULL, '2024-10-19 05:42:14', '2024-10-19 05:42:14'),
(102, '2024-10-21', 'Invoice-00000102', 4, 1, 1, 21458.00, 0.00, 'flat', 0.00, 0.00, 0.00, 896913.00, 0.00, 875455.00, 'null', NULL, '2024-10-21 01:58:30', '2024-10-21 01:58:30'),
(103, '2024-10-22', 'Invoice-00000103', 9, 1, 1, 7600.00, 0.00, 'flat', 0.00, 0.00, 0.00, 23837.00, 0.00, 16237.00, NULL, NULL, '2024-10-22 02:47:06', '2024-10-22 03:08:40'),
(104, '2024-10-23', 'Invoice-00000104', 4, 1, 1, 7920.00, 0.00, 'flat', 0.00, 0.00, 0.00, 864833.00, 0.00, 856913.00, 'null', NULL, '2024-10-23 03:11:27', '2024-10-23 03:11:27'),
(105, '2024-10-25', 'Invoice-00000105', 4, 1, 1, 42000.00, 0.00, 'flat', 0.00, 0.00, 0.00, 886833.00, 0.00, 844833.00, 'null', NULL, '2024-10-25 09:19:30', '2024-10-25 09:19:30');

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `party_id` bigint UNSIGNED NOT NULL COMMENT 'customer id',
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `due` decimal(12,2) NOT NULL DEFAULT '0.00',
  `previous_balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'party previous balance at this return state',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_returns`
--

INSERT INTO `sale_returns` (`id`, `date`, `return_no`, `party_id`, `branch_id`, `user_id`, `subtotal`, `discount`, `paid`, `due`, `previous_balance`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(7, '2024-10-16', 'Return-00000001', 9, 1, 1, 16170.00, 0.00, 0.00, 0.00, 32407.00, NULL, NULL, '2024-10-15 22:35:21', '2024-10-15 22:35:21');

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE `sms` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'content of message',
  `status` tinyint(1) NOT NULL COMMENT '0 means not sent 1 means sent',
  `total_character` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'number of character sent at a time',
  `total_sms` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'number of message sent at a time',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `damage_quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `divisor_number` int NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `branch_id`, `quantity`, `damage_quantity`, `divisor_number`, `purchase_price`, `created_at`, `updated_at`) VALUES
(1061, 96, 1, 5.00, 0.00, 1, 105.00, '2024-08-31 02:39:26', '2024-08-31 02:39:26'),
(1250, 345, 1, 60.00, 0.00, 1, 68.00, '2024-10-01 10:32:40', '2024-10-01 10:32:40'),
(1342, 56, 1, 1.00, 0.00, 1, 280.00, '2024-10-15 22:35:21', '2024-10-15 22:35:21'),
(1432, 396, 1, 0.00, 0.00, 1, 28.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1433, 370, 1, 0.00, 0.00, 1, 800.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1434, 321, 1, 0.00, 0.00, 1, 30.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1435, 240, 1, 0.00, 0.00, 1, 20.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1436, 313, 1, 0.00, 0.00, 1, 40.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1437, 282, 1, 0.00, 0.00, 1, 440.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1438, 281, 1, 0.00, 0.00, 1, 460.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1439, 270, 1, 0.00, 0.00, 1, 16.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1440, 331, 1, 0.00, 0.00, 1, 85.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1441, 249, 1, 0.00, 0.00, 1, 87.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1442, 248, 1, 0.00, 0.00, 1, 23.50, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1443, 393, 1, 0.00, 0.00, 1, 18.50, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1444, 394, 1, 0.00, 0.00, 1, 36.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1445, 395, 1, 0.00, 0.00, 1, 75.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1446, 319, 1, 0.00, 0.00, 1, 14.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1447, 283, 1, 0.00, 0.00, 1, 330.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1448, 242, 1, 0.00, 0.00, 1, 115.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1449, 312, 1, 0.00, 0.00, 1, 23.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1450, 388, 1, 0.00, 0.00, 1, 235.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1451, 326, 1, 0.00, 0.00, 1, 120.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1452, 418, 1, 0.00, 0.00, 1, 98.00, '2024-10-16 07:43:49', '2024-10-16 07:43:49'),
(1454, 180, 1, 2.00, 0.00, 1, 140.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1455, 23, 1, 5.00, 0.00, 1, 1150.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1457, 29, 1, 5.00, 0.00, 1, 2600.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1458, 114, 1, 10.00, 0.00, 1, 450.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1459, 165, 1, 5000.00, 0.00, 1000, 1310.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1460, 89, 1, 10.00, 0.00, 1, 660.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1461, 176, 1, 5.00, 0.00, 1, 820.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1462, 144, 1, 5.00, 0.00, 1, 200.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1463, 128, 1, 5.00, 0.00, 1, 2900.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1464, 107, 1, 5.00, 0.00, 1, 1300.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1465, 104, 1, 5000.00, 0.00, 1000, 130.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1466, 95, 1, 5.00, 0.00, 1, 1050.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1467, 72, 1, 5.00, 0.00, 1, 320.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1468, 38, 1, 5.00, 0.00, 1, 120.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1469, 6, 1, 2.00, 0.00, 1, 1220.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1470, 100, 1, 2.00, 0.00, 1, 520.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1472, 110, 1, 25.00, 0.00, 1, 146.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1473, 98, 1, 5.00, 0.00, 1, 140.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1474, 157, 1, 50.00, 0.00, 1, 72.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1475, 158, 1, 4.00, 0.00, 1, 260.00, '2024-10-19 05:34:48', '2024-10-19 05:34:48'),
(1487, 284, 1, 25.00, 0.00, 1, 102.50, '2024-10-22 03:08:40', '2024-10-22 03:08:40');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `transaction_from` enum('bank','cash') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'From where the transaction took place',
  `transaction_from_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bank account or cash id',
  `transaction_to` enum('bank','cash') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Where the transaction take place?',
  `transaction_to_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bank account or cash id',
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `date`, `user_id`, `transaction_from`, `transaction_from_id`, `transaction_to`, `transaction_to_id`, `amount`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-08-15', 1, 'cash', '3', 'bank', '1', 66747.00, 'null', NULL, '2024-08-15 06:21:55', '2024-08-15 06:21:55'),
(2, '2024-08-17', 1, 'bank', '1', 'cash', '3', 66747.00, 'null', NULL, '2024-08-17 07:25:04', '2024-08-17 07:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `code`, `label`, `relation`, `user_id`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'KG', '0001', 'mon/kg/gm', '1/40/1000', 1, '1mon = 40kg,\r\n1kg = 1000gm', NULL, '2024-04-03 14:14:40', '2024-04-03 14:14:40'),
(2, 'Pcs', '0002', 'Pcs', '1', 1, '1 Pcs', NULL, '2024-06-09 12:20:51', '2024-06-09 12:20:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `active`, `branch_id`, `user_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Wahidul Islam Rahat', 'admin@utkarsho.com', '01795290732', '2024-03-21 03:52:20', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 1, NULL, 'J60LDOdM7IZ8RGsDkafXcgLfE80fIf5QlULtpY8quTwoLn1UmyT7iy6AepuH', '2024-03-21 03:52:20', '2024-07-31 09:46:37'),
(2, 'Sabbir Ahmed', 'packaging@khurak.com', '01982848396', NULL, '$2y$10$bnTzfV68/WE9IHDs3ChQquUrZTD1qmwXtZ5ok2vun0JftbJ0VpJ72', 1, 1, NULL, NULL, '2024-04-08 21:38:36', '2024-04-08 21:38:36'),
(3, 'Tariqul Islam', 'tariqmakbul6278@gmail.com', '01753326721', '2024-09-02 04:16:33', '$2y$10$fpgxXZrWUxLYwvu6Ol46U.2BkL/gKGS2BKQfPty390oX22yZvmR7e', 1, 1, NULL, NULL, '2024-05-22 12:03:32', '2024-09-02 04:16:33'),
(4, 'Rakibul Islam Nayem', 'nayemrakib170@gmail.com', '01710153118', NULL, '$2y$10$cvXjzkYEqj21L6MmKDsOWuNjR/QLInkJOea6p/FLIR8cKVcufcFoS', 1, 1, NULL, NULL, '2024-05-22 12:04:47', '2024-08-18 10:56:30'),
(5, 'Wahidul Islam Rahat', 'admin@rahat.com', '01795291732', NULL, '$2y$10$aVt/kgSlocGOUZw8.RljbOE5iCn9TPsPJYlBja51P.sMxe9.uoFJ.', 1, 1, NULL, NULL, '2024-05-22 12:06:27', '2024-05-22 12:06:27');

-- --------------------------------------------------------

--
-- Table structure for table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Creator',
  `date` date NOT NULL,
  `amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `transactionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionable_id` bigint UNSIGNED NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `advanced_salaries`
--
ALTER TABLE `advanced_salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `advanced_salaries_user_id_foreign` (`user_id`),
  ADD KEY `advanced_salaries_salary_id_foreign` (`salary_id`),
  ADD KEY `advanced_salaries_employee_id_foreign` (`employee_id`),
  ADD KEY `advanced_salaries_cash_id_foreign` (`cash_id`),
  ADD KEY `advanced_salaries_bank_account_id_foreign` (`bank_account_id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `banks_user_id_foreign` (`user_id`);

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_accounts_bank_id_foreign` (`bank_id`),
  ADD KEY `bank_accounts_user_id_foreign` (`user_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_user_id_foreign` (`user_id`);

--
-- Indexes for table `cashes`
--
ALTER TABLE `cashes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashes_branch_id_foreign` (`branch_id`),
  ADD KEY `cashes_user_id_foreign` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`),
  ADD KEY `categories_user_id_foreign` (`user_id`),
  ADD KEY `categories_name_index` (`name`);

--
-- Indexes for table `closing_balances`
--
ALTER TABLE `closing_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `closing_balances_user_id_foreign` (`user_id`);

--
-- Indexes for table `damages`
--
ALTER TABLE `damages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `damages_branch_id_foreign` (`branch_id`),
  ADD KEY `damages_user_id_foreign` (`user_id`);

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `details_product_id_foreign` (`product_id`),
  ADD KEY `details_detailable_type_detailable_id_index` (`detailable_type`,`detailable_id`);

--
-- Indexes for table `due_manages`
--
ALTER TABLE `due_manages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `due_manages_party_id_foreign` (`party_id`),
  ADD KEY `due_manages_cash_id_foreign` (`cash_id`),
  ADD KEY `due_manages_bank_account_id_foreign` (`bank_account_id`),
  ADD KEY `due_manages_user_id_foreign` (`user_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_expense_category_id_foreign` (`expense_category_id`),
  ADD KEY `expenses_expense_subcategory_id_foreign` (`expense_subcategory_id`),
  ADD KEY `expenses_branch_id_foreign` (`branch_id`),
  ADD KEY `expenses_user_id_foreign` (`user_id`),
  ADD KEY `expenses_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_parent_id_foreign` (`parent_id`),
  ADD KEY `expense_categories_user_id_foreign` (`user_id`),
  ADD KEY `expense_categories_name_index` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `income_records`
--
ALTER TABLE `income_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `income_records_user_id_foreign` (`user_id`),
  ADD KEY `income_records_branch_id_foreign` (`branch_id`),
  ADD KEY `income_records_income_sector_id_foreign` (`income_sector_id`),
  ADD KEY `income_records_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`);

--
-- Indexes for table `income_sectors`
--
ALTER TABLE `income_sectors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `income_sectors_user_id_foreign` (`user_id`);

--
-- Indexes for table `investors`
--
ALTER TABLE `investors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `investors_user_id_foreign` (`user_id`);

--
-- Indexes for table `invests`
--
ALTER TABLE `invests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invests_user_id_foreign` (`user_id`),
  ADD KEY `invests_investor_id_foreign` (`investor_id`),
  ADD KEY `invests_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`),
  ADD KEY `invests_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `invest_withdraws`
--
ALTER TABLE `invest_withdraws`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invest_withdraws_user_id_foreign` (`user_id`),
  ADD KEY `invest_withdraws_invest_id_foreign` (`invest_id`),
  ADD KEY `invest_withdraws_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`),
  ADD KEY `invest_withdraws_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loans_user_id_foreign` (`user_id`),
  ADD KEY `loans_loan_account_id_foreign` (`loan_account_id`),
  ADD KEY `loans_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`);

--
-- Indexes for table `loan_accounts`
--
ALTER TABLE `loan_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_accounts_user_id_foreign` (`user_id`);

--
-- Indexes for table `loan_installments`
--
ALTER TABLE `loan_installments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_installments_user_id_foreign` (`user_id`),
  ADD KEY `loan_installments_loan_id_foreign` (`loan_id`),
  ADD KEY `loan_installments_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `parties`
--
ALTER TABLE `parties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parties_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_paymentable_type_paymentable_id_index` (`paymentable_type`,`paymentable_id`),
  ADD KEY `payments_cash_id_foreign` (`cash_id`),
  ADD KEY `payments_bank_account_id_foreign` (`bank_account_id`),
  ADD KEY `payments_user_id_foreign` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `productions`
--
ALTER TABLE `productions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productions_branch_id_foreign` (`branch_id`),
  ADD KEY `productions_user_id_foreign` (`user_id`);

--
-- Indexes for table `production_details`
--
ALTER TABLE `production_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_details_production_id_foreign` (`production_id`),
  ADD KEY `production_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_barcode_unique` (`barcode`),
  ADD KEY `products_unit_id_foreign` (`unit_id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_subcategory_id_foreign` (`subcategory_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_branch_id_foreign` (`branch_id`),
  ADD KEY `products_user_id_foreign` (`user_id`);

--
-- Indexes for table `product_transfers`
--
ALTER TABLE `product_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_transfers_from_branch_id_foreign` (`from_branch_id`),
  ADD KEY `product_transfers_to_branch_id_foreign` (`to_branch_id`),
  ADD KEY `product_transfers_user_id_foreign` (`user_id`);

--
-- Indexes for table `product_transfer_details`
--
ALTER TABLE `product_transfer_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_transfer_details_product_transfer_id_foreign` (`product_transfer_id`),
  ADD KEY `product_transfer_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_party_id_foreign` (`party_id`),
  ADD KEY `purchases_branch_id_foreign` (`branch_id`),
  ADD KEY `purchases_user_id_foreign` (`user_id`);

--
-- Indexes for table `purchase_costs`
--
ALTER TABLE `purchase_costs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_costs_purchase_id_foreign` (`purchase_id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_returns_party_id_foreign` (`party_id`),
  ADD KEY `purchase_returns_branch_id_foreign` (`branch_id`),
  ADD KEY `purchase_returns_user_id_foreign` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salaries_user_id_foreign` (`user_id`),
  ADD KEY `salaries_employee_id_foreign` (`employee_id`),
  ADD KEY `salaries_cash_id_foreign` (`cash_id`),
  ADD KEY `salaries_bank_account_id_foreign` (`bank_account_id`);

--
-- Indexes for table `salary_details`
--
ALTER TABLE `salary_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salary_details_salary_id_foreign` (`salary_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_party_id_foreign` (`party_id`),
  ADD KEY `sales_branch_id_foreign` (`branch_id`),
  ADD KEY `sales_user_id_foreign` (`user_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_returns_party_id_foreign` (`party_id`),
  ADD KEY `sale_returns_branch_id_foreign` (`branch_id`),
  ADD KEY `sale_returns_user_id_foreign` (`user_id`);

--
-- Indexes for table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sms_branch_id_foreign` (`branch_id`),
  ADD KEY `sms_user_id_foreign` (`user_id`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sms_templates_user_id_foreign` (`user_id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stocks_product_id_foreign` (`product_id`),
  ADD KEY `stocks_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD KEY `users_branch_id_foreign` (`branch_id`),
  ADD KEY `users_user_id_foreign` (`user_id`);

--
-- Indexes for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdraws_user_id_foreign` (`user_id`),
  ADD KEY `withdraws_transactionable_type_transactionable_id_index` (`transactionable_type`,`transactionable_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advanced_salaries`
--
ALTER TABLE `advanced_salaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cashes`
--
ALTER TABLE `cashes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `closing_balances`
--
ALTER TABLE `closing_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `damages`
--
ALTER TABLE `damages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `details`
--
ALTER TABLE `details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2204;

--
-- AUTO_INCREMENT for table `due_manages`
--
ALTER TABLE `due_manages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_records`
--
ALTER TABLE `income_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `income_sectors`
--
ALTER TABLE `income_sectors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `investors`
--
ALTER TABLE `investors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invests`
--
ALTER TABLE `invests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invest_withdraws`
--
ALTER TABLE `invest_withdraws`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `loan_accounts`
--
ALTER TABLE `loan_accounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loan_installments`
--
ALTER TABLE `loan_installments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `parties`
--
ALTER TABLE `parties`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=372;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `production_details`
--
ALTER TABLE `production_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=360;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=421;

--
-- AUTO_INCREMENT for table `product_transfers`
--
ALTER TABLE `product_transfers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_transfer_details`
--
ALTER TABLE `product_transfer_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `purchase_costs`
--
ALTER TABLE `purchase_costs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `salary_details`
--
ALTER TABLE `salary_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sms`
--
ALTER TABLE `sms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1492;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advanced_salaries`
--
ALTER TABLE `advanced_salaries`
  ADD CONSTRAINT `advanced_salaries_bank_account_id_foreign` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `advanced_salaries_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cashes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `advanced_salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `advanced_salaries_salary_id_foreign` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `advanced_salaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `banks`
--
ALTER TABLE `banks`
  ADD CONSTRAINT `banks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD CONSTRAINT `bank_accounts_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bank_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `brands_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `cashes`
--
ALTER TABLE `cashes`
  ADD CONSTRAINT `cashes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `cashes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `closing_balances`
--
ALTER TABLE `closing_balances`
  ADD CONSTRAINT `closing_balances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `damages`
--
ALTER TABLE `damages`
  ADD CONSTRAINT `damages_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `damages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `details`
--
ALTER TABLE `details`
  ADD CONSTRAINT `details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `due_manages`
--
ALTER TABLE `due_manages`
  ADD CONSTRAINT `due_manages_bank_account_id_foreign` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `due_manages_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cashes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `due_manages_party_id_foreign` FOREIGN KEY (`party_id`) REFERENCES `parties` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `due_manages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_expense_subcategory_id_foreign` FOREIGN KEY (`expense_subcategory_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `expense_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expense_categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `income_records`
--
ALTER TABLE `income_records`
  ADD CONSTRAINT `income_records_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `income_records_income_sector_id_foreign` FOREIGN KEY (`income_sector_id`) REFERENCES `income_sectors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `income_records_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `income_sectors`
--
ALTER TABLE `income_sectors`
  ADD CONSTRAINT `income_sectors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `investors`
--
ALTER TABLE `investors`
  ADD CONSTRAINT `investors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `invests`
--
ALTER TABLE `invests`
  ADD CONSTRAINT `invests_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `invests_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `invest_withdraws`
--
ALTER TABLE `invest_withdraws`
  ADD CONSTRAINT `invest_withdraws_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `invest_withdraws_invest_id_foreign` FOREIGN KEY (`invest_id`) REFERENCES `invests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invest_withdraws_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_loan_account_id_foreign` FOREIGN KEY (`loan_account_id`) REFERENCES `loan_accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `loan_accounts`
--
ALTER TABLE `loan_accounts`
  ADD CONSTRAINT `loan_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `loan_installments`
--
ALTER TABLE `loan_installments`
  ADD CONSTRAINT `loan_installments_loan_id_foreign` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_installments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parties`
--
ALTER TABLE `parties`
  ADD CONSTRAINT `parties_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_bank_account_id_foreign` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cashes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `productions`
--
ALTER TABLE `productions`
  ADD CONSTRAINT `productions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `production_details`
--
ALTER TABLE `production_details`
  ADD CONSTRAINT `production_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `production_details_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_subcategory_id_foreign` FOREIGN KEY (`subcategory_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `product_transfers`
--
ALTER TABLE `product_transfers`
  ADD CONSTRAINT `product_transfers_from_branch_id_foreign` FOREIGN KEY (`from_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_transfers_to_branch_id_foreign` FOREIGN KEY (`to_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_transfers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_transfer_details`
--
ALTER TABLE `product_transfer_details`
  ADD CONSTRAINT `product_transfer_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_transfer_details_product_transfer_id_foreign` FOREIGN KEY (`product_transfer_id`) REFERENCES `product_transfers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_party_id_foreign` FOREIGN KEY (`party_id`) REFERENCES `parties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `purchase_costs`
--
ALTER TABLE `purchase_costs`
  ADD CONSTRAINT `purchase_costs_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD CONSTRAINT `purchase_returns_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_returns_party_id_foreign` FOREIGN KEY (`party_id`) REFERENCES `parties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_returns_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `salaries`
--
ALTER TABLE `salaries`
  ADD CONSTRAINT `salaries_bank_account_id_foreign` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salaries_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cashes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `salary_details`
--
ALTER TABLE `salary_details`
  ADD CONSTRAINT `salary_details_salary_id_foreign` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_party_id_foreign` FOREIGN KEY (`party_id`) REFERENCES `parties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD CONSTRAINT `sale_returns_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sale_returns_party_id_foreign` FOREIGN KEY (`party_id`) REFERENCES `parties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sale_returns_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sms`
--
ALTER TABLE `sms`
  ADD CONSTRAINT `sms_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD CONSTRAINT `sms_templates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD CONSTRAINT `withdraws_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
