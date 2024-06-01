-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 01, 2024 at 12:09 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `james_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jewels`
--

DROP TABLE IF EXISTS `jewels`;
CREATE TABLE IF NOT EXISTS `jewels` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('ruby','diamond','emerald','sapphire','pearl') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carat` decimal(8,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `deleted_by` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jewels_created_by_foreign` (`created_by`),
  KEY `jewels_updated_by_foreign` (`updated_by`),
  KEY `jewels_deleted_by_foreign` (`deleted_by`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jewels`
--

INSERT INTO `jewels` (`id`, `name`, `type`, `carat`, `price`, `description`, `image`, `created_at`, `updated_at`, `deleted_at`, `created_by`, `updated_by`, `deleted_by`) VALUES
(1, 'Cincin Ruby Klasik', 'ruby', 2.00, 8000.00, 'Tes', 'https://media.istockphoto.com/id/815613222/id/foto/cincin-emas.jpg?s=612x612&w=0&k=20&c=BXgN2blpaxcH0b7U21JgeglhImoO1y5Ohd1XiWQmD_U=', '2024-05-21 09:01:20', '2024-05-21 10:35:59', '2024-05-21 10:35:59', NULL, NULL, NULL),
(2, 'Cincin Ruby Klasik', 'ruby', 2.00, 8000.00, 'Cincin ruby klasik dengan batu ruby merah yang menawan, dikelilingi oleh berlian kecil yang berkilauan.', 'https://media.istockphoto.com/id/815613222/id/foto/cincin-emas.jpg?s=612x612&w=0&k=20&c=BXgN2blpaxcH0b7U21JgeglhImoO1y5Ohd1XiWQmD_U=', '2024-05-21 10:30:41', '2024-05-21 10:34:38', NULL, NULL, NULL, NULL),
(3, 'Kalung Berlian Elegan', 'diamond', 5.00, 15000.00, 'Kalung berlian indah dengan liontin berbentuk hati, terbuat dari emas putih 18 karat dan berlian berkilauan.', 'https://images.tokopedia.net/img/cache/900/hDjmkQ/2024/4/7/6328cc0b-3846-46b7-b8ef-1d0e8dcb0353.jpg', '2024-05-27 05:23:45', '2024-05-27 05:23:45', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_05_21_101214_create_jewels_table', 2),
(5, '2024_05_21_111922_create_personal_access_tokens_table', 3),
(6, '2024_05_27_105601_create_oauth_auth_codes_table', 4),
(7, '2024_05_27_105602_create_oauth_access_tokens_table', 4),
(8, '2024_05_27_105603_create_oauth_refresh_tokens_table', 4),
(9, '2024_05_27_105604_create_oauth_clients_table', 4),
(10, '2024_05_27_105605_create_oauth_personal_access_clients_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('293e7cc83a5128ec0ea47d3a3d4592bb87b89ab827cd3ca6872228f5ba86a3e9687d9c0f0ff0c729', 2, 1, 'All Yours', '[]', 0, '2024-05-27 05:07:23', '2024-05-27 05:07:23', '2024-11-27 12:07:23'),
('326591782bd1a5910bd7b8c8c2c396f4676cc9d7a9279f363d25251ffc84157eda8a335686fdc1d1', 1, 1, 'All Yours', '[]', 1, '2024-06-01 05:00:47', '2024-06-01 05:05:22', '2024-12-01 12:00:47'),
('3664480b0e06505e77b7526c0679545fc7756a575dffa97c86ce058106068a8977391d75d9e29cab', 1, 1, 'All Yours', '[]', 0, '2024-06-01 05:00:29', '2024-06-01 05:00:29', '2024-12-01 12:00:29'),
('48f7454e2512fb1a86cd49b392269562f79a43f09b8978aae93d3f93db60920509eb4f255ecd5ba0', 3, 1, 'All Yours', '[]', 0, '2024-06-01 05:07:51', '2024-06-01 05:07:51', '2024-12-01 12:07:51'),
('4f81f65a0d8f923157e092f245c53a4923717af2878f189abadc0f379da6a8e1092863b8cd4741c0', 1, 1, 'All Yours', '[]', 1, '2024-05-27 04:33:49', '2024-05-27 04:35:03', '2024-11-27 11:33:49'),
('56f3714bd327efcf39280175b671be47bea4ce24a538d99549fedd13fd4c27c2f2a771ee779b9c1d', 1, 1, 'All Yours', '[]', 1, '2024-05-27 04:37:47', '2024-05-27 04:38:01', '2024-11-27 11:37:47'),
('572770bc20f816febef7435125d25b885ee349c3cb98284e91356d2a48aade3f9b289b5e44fe2fd8', 1, 1, 'All Yours', '[]', 1, '2024-06-01 04:58:38', '2024-06-01 04:58:49', '2024-12-01 11:58:38'),
('604295df94a38089194d6737c6652c837cf36624b1fb81b7fd404bf56f84f630f4faa6855d234c0f', 1, 1, 'All Yours', '[]', 0, '2024-05-27 05:12:27', '2024-05-27 05:12:27', '2024-11-27 12:12:27'),
('6090a80a6c7a9a4f1c222fac8c526bcfc8c0aaa298a056d8fe47494e95445f1cbc439d623376bd5e', 1, 1, 'All Yours', '[]', 0, '2024-05-27 05:23:26', '2024-05-27 05:23:26', '2024-11-27 12:23:26'),
('680b0fc6103014f5ebf00cb38194a2d2decc74818af5032073bb1fc4a14d46a0344ca48a2b12d846', 2, 1, 'All Yours', '[]', 1, '2024-06-01 05:07:23', '2024-06-01 05:07:31', '2024-12-01 12:07:23'),
('713fd088dee682828846f86853b771532f3e800edd41df83dce639ac7975ec948af68aeeedc72c14', 1, 1, 'All Yours', '[]', 1, '2024-05-27 05:11:58', '2024-05-27 05:12:20', '2024-11-27 12:11:58'),
('81b615e72bc951dce55047995ae35a425fed980e3a2ee8dd96f9f97c71190098354c8df737eeb7bd', 1, 1, 'All Yours', '[]', 0, '2024-05-27 05:12:26', '2024-05-27 05:12:26', '2024-11-27 12:12:26'),
('87259465b9a7017bca0ec734b2ddfe6c67152ea6aca0be9c2aad1b319a9a8134db2d43771610567b', 1, 1, 'All Yours', '[]', 0, '2024-05-27 05:06:07', '2024-05-27 05:06:08', '2024-11-27 12:06:07'),
('98f2bc2ac6b780ca54038cc4148b4f86d01c8bf3f403b7b55f530fe8c94e5804ec83f66ee3d1dd94', 1, 1, 'All Yours', '[]', 1, '2024-05-27 05:09:34', '2024-05-27 05:11:19', '2024-11-27 12:09:34'),
('a3c035f6f20629a05192a6fcf17868deb0292151dfd49d58115cc07384a3f759de6ee52841b17ef8', 1, 1, 'All Yours', '[]', 0, '2024-05-27 04:23:45', '2024-05-27 04:23:45', '2024-11-27 11:23:45'),
('aefc8822c26da4bb741722feb739545c19a16be49b13c31075770a6c3720502a743875ac30f8a129', 1, 1, 'All Yours', '[]', 0, '2024-05-27 04:26:24', '2024-05-27 04:26:24', '2024-11-27 11:26:24'),
('b7bdc849c86b5933c4d4465fe847afc2929db5647be5cb408dec3aadf5432e1d36c42ee459abd74f', 1, 1, 'All Yours', '[]', 0, '2024-05-27 05:22:49', '2024-05-27 05:22:49', '2024-11-27 12:22:49'),
('cbf2a92e3cf9b9914af2783127afa35d2e5923721c7bd5dc744487412fd3ad9d8fce23dbea4ca1b2', 1, 1, 'All Yours', '[]', 0, '2024-05-27 04:38:34', '2024-05-27 04:38:34', '2024-11-27 11:38:34'),
('e3d2b2a9bab73191656d2fc0047bc729635d3defe705c38baeb622ba94d2ad8247b4b5e4a392dc56', 1, 1, 'All Yours', '[]', 0, '2024-05-27 04:35:57', '2024-05-27 04:35:57', '2024-11-27 11:35:57'),
('e602f01310c1dac227293c16f6f3dd0278a79b8b45290a1020e74f39449b70b2ea253f1dfbc580f1', 1, 1, 'All Yours', '[]', 1, '2024-06-01 05:05:40', '2024-06-01 05:05:46', '2024-12-01 12:05:40'),
('e68dc410c5d8726eab928cb667d7d152a8ca4e149af6b28a5c53b7d0381ec8f30022faef5789f290', 1, 1, 'All Yours', '[]', 0, '2024-05-27 04:44:56', '2024-05-27 04:44:56', '2024-11-27 11:44:56');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'a8bmvQh4TQUEpP1bp3AyMa8TNMnCyeRbS55FMD4P', NULL, 'http://localhost', 1, 0, 0, '2024-05-27 03:56:12', '2024-05-27 03:56:12'),
(2, NULL, 'Laravel Password Grant Client', 'yyPx5L1q3P7bOXbLkzEAVGpkMYjgbp9MFUk01vQ9', 'users', 'http://localhost', 0, 1, 0, '2024-05-27 03:56:12', '2024-05-27 03:56:12');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-05-27 03:56:12', '2024-05-27 03:56:12');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('61hBC5I6wSkB9e6GT8tdentXedb0e30HCRYbrTRX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZG01aXdGMTFyZ2lscUo3ckJRbWp2RXhKS3pMU29hOVJTNDFSZ0ZGcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1717243672),
('aEEbBrqzyZGu7oSVGiy1S5obIwuEqKaDhvf5adox', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2FNVEptaUhibllhY1dOWVNIem9YRUxtTGVGRVdTY1k2ZGhCNkptVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9qZXdlbC8zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1717243140);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'James Wilson Lie', 'james@gmail.com', NULL, '$2y$12$ToL1MV57QR1PMIHXO98GLeBm0GV.GARYlJAl0ugCHcqlrXQ4AOa1i', NULL, '2024-05-27 05:07:23', '2024-05-27 05:07:23'),
(2, 'User', 'user@gmail.com', NULL, '$2y$12$BygiXq/OhXPpqMw81I9xX..nvgK//d0BWymN.KHd7xFJRdQTl92he', NULL, '2024-06-01 05:07:23', '2024-06-01 05:07:23'),
(3, 'James2', 'james2@gmail.com', NULL, '$2y$12$HaVJGb.c.oKLo0XYcgkgquAfjTCLNcxbwhJ4MqUpjbM/Sj.DAVyae', NULL, '2024-06-01 05:07:51', '2024-06-01 05:07:51');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jewels`
--
ALTER TABLE `jewels`
  ADD CONSTRAINT `jewels_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `jewels_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `jewels_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
