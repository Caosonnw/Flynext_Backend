/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `airports` (
  `airport_id` int NOT NULL AUTO_INCREMENT,
  `airport_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `airport_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(100) NOT NULL,
  PRIMARY KEY (`airport_id`),
  UNIQUE KEY `code` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `room_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(20) NOT NULL,
  `departure_airport_id` int DEFAULT NULL,
  `arrival_airport_id` int DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `price` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `departure_airport_id` (`departure_airport_id`),
  KEY `arrival_airport_id` (`arrival_airport_id`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`departure_airport_id`) REFERENCES `airports` (`airport_id`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`arrival_airport_id`) REFERENCES `airports` (`airport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `passengers` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `gender` tinyint NOT NULL,
  `date_of_birth` date NOT NULL,
  `passport_number` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`passenger_id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `name_on_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `expiry_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cvv` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `id` (`payment_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `revenueByFlights` (
  `rbf_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `total_tickets` int DEFAULT NULL,
  `revenue` int DEFAULT NULL,
  `ratio` int DEFAULT NULL,
  PRIMARY KEY (`rbf_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `revenueByFlights_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `revenueByYear` (
  `rby_id` int NOT NULL AUTO_INCREMENT,
  `rbf_id` int DEFAULT NULL,
  `total_flights` int DEFAULT NULL,
  `revenue` int DEFAULT NULL,
  `ratio` int DEFAULT NULL,
  PRIMARY KEY (`rby_id`),
  KEY `rbf_id` (`rbf_id`),
  CONSTRAINT `revenueByYear_ibfk_1` FOREIGN KEY (`rbf_id`) REFERENCES `revenueByFlights` (`rbf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(20) NOT NULL,
  `flight_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `ticket_class` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'booked',
  `passenger` int DEFAULT NULL,
  `total_price` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  UNIQUE KEY `ticket_number` (`ticket_number`),
  KEY `flight_id` (`flight_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_friends` (
  `user_id` int NOT NULL,
  `friend_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`friend_id`),
  KEY `friend_id` (`friend_id`),
  CONSTRAINT `user_friends_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_friends_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` tinyint DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `cccd` varchar(20) DEFAULT NULL,
  `address` text,
  `phone` varchar(20) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `refresh_token` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `airports` (`airport_id`, `airport_code`, `airport_name`, `city`) VALUES
(1, 'SGN', 'Tan Son Nhat International Airport - Ho Chi Minh city - SGN', 'Ho Chi Minh');
INSERT INTO `airports` (`airport_id`, `airport_code`, `airport_name`, `city`) VALUES
(2, 'HAN', 'Noi Bai International Airport - Ha Noi city - HAN', 'Ha Noi');
INSERT INTO `airports` (`airport_id`, `airport_code`, `airport_name`, `city`) VALUES
(3, 'DAD', 'Da Nang International Airport - Da Nang city - DAD', 'Da Nang');
INSERT INTO `airports` (`airport_id`, `airport_code`, `airport_name`, `city`) VALUES
(4, 'HUI', 'Phu Bai International Airport - Hue city - HUI', 'Hue'),
(5, 'CRX', 'Cam Ranh International Airport - Nha Trang city - CRX', 'Nha Trang'),
(6, 'PQC', 'Phu Quoc International Airport - Phuc Quoc city - PQC', 'Phu Quoc'),
(7, 'HPH', 'Cat Bi International Airport - Hai Phong city - HPH', 'Hai Phong'),
(8, 'VCA', 'Can Tho International Airport - Can Tho city - VCA', 'Can Tho'),
(9, 'VDO', 'Van Don International Airport - Quang Ninh city - VDO', 'Quang Ninh'),
(10, 'VII', 'Vinh International Airport - Vinh city - VII', 'Vinh'),
(11, 'BMV', 'Buon Ma Thuot Airport - Buon Ma Thuot city - BMV', 'Buon Ma Thuot'),
(12, 'CAH', 'Ca Mau Airport - Ca Mau city - CAH', 'Ca Mau'),
(13, 'VCS', 'Co Ong Airport - Con Dao city - VCS', 'Con Dao'),
(14, 'VCL', 'Chu Lai Airport - Chu Lai city - VCL', 'Chu Lai'),
(15, 'DLI', 'Lien Khuong Airport - Da Lat city - DLI', 'Da Lat'),
(16, 'DIN', 'Dien Bien Phu Airport - Dien Bien Phu city - DIN', 'Dien Bien Phu'),
(17, 'VDH', 'Dong Hoi Airport - Dong Hoi city - VDH', 'Dong Hoi'),
(18, 'PXU', 'Pleiku Airport - Pleiku city - PXU', 'Pleiku'),
(19, 'UIH', 'Phu Cat Airport - Quy Nhon city - UIH', 'Quy Nhon'),
(20, 'VKG', 'Rach Gia Airport - Rach Gia city - VKG', 'Rach Gia'),
(21, 'TBB', 'Dong Tac Airport - Tuy Hoa city - TBB', 'Tuy Hoa'),
(22, 'VTG', 'Vung Tau Airport - Vung tau city - VTG', 'Vung Tau'),
(23, 'THD', 'Tho Xuan Airport - Thanh Hoa city - THD', 'Thanh Hoa');

INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(1, 1, '2', NULL, '2024-07-16 14:18:31');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(2, 1, '2', '1-1', '2024-07-16 14:43:01');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(3, 1, '2', '1-1', '2024-07-16 15:11:19');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(4, 2, '2', '1-2', '2024-07-16 15:13:23');

INSERT INTO `flights` (`flight_id`, `flight_number`, `departure_airport_id`, `arrival_airport_id`, `departure_time`, `arrival_time`, `price`, `created_at`) VALUES
(1, 'VN-upK8J5', 1, 2, '2024-05-31 09:00:00', '2024-05-31 12:20:00', 3000000, '2024-05-30 14:59:44');
INSERT INTO `flights` (`flight_id`, `flight_number`, `departure_airport_id`, `arrival_airport_id`, `departure_time`, `arrival_time`, `price`, `created_at`) VALUES
(2, 'VN-7BLfor', 1, 2, '2024-05-31 09:00:00', '2024-05-31 12:20:00', 3000000, '2024-05-30 14:59:44');
INSERT INTO `flights` (`flight_id`, `flight_number`, `departure_airport_id`, `arrival_airport_id`, `departure_time`, `arrival_time`, `price`, `created_at`) VALUES
(3, 'VN-z7wbjq', 1, 2, '2024-05-31 15:00:00', '2024-05-31 17:50:00', 6000000, '2024-05-30 15:50:08');
INSERT INTO `flights` (`flight_id`, `flight_number`, `departure_airport_id`, `arrival_airport_id`, `departure_time`, `arrival_time`, `price`, `created_at`) VALUES
(4, 'VN-9251', 1, 2, '2024-06-01 09:00:00', '2024-06-01 12:00:00', 2955000, '2024-06-01 07:50:18'),
(5, 'VJ-2980', 1, 2, '2024-06-01 07:30:00', '2024-06-01 09:00:00', 1250000, '2024-06-01 08:26:32'),
(6, 'QH-5937', 1, 2, '2024-06-01 15:00:00', '2024-06-01 17:20:00', 3330000, '2024-06-01 09:24:29'),
(7, 'VN-795', 1, 2, '2024-06-02 20:35:00', '2024-06-02 22:45:00', 3057000, '2024-06-01 17:18:05'),
(8, 'QH-5798', 1, 2, '2024-06-02 20:55:00', '2024-06-02 23:15:00', 3182000, '2024-06-01 17:18:42'),
(9, 'VJ-7302', 1, 2, '2024-06-02 22:20:00', '2024-06-03 00:25:00', 3380600, '2024-06-01 17:19:23'),
(10, 'VU-9794', 1, 2, '2024-06-02 00:00:00', '2024-06-02 03:00:00', 1250000, '2024-06-01 17:31:37'),
(11, 'VN-294', 1, 2, '2024-06-04 07:00:00', '2024-06-04 09:20:00', 3500000, '2024-06-04 05:52:46'),
(12, 'QH-8263', 1, 2, '2024-06-04 19:00:00', '2024-06-04 21:30:00', 4120000, '2024-06-04 11:20:45'),
(13, 'VN-1028', 1, 2, '2024-06-06 08:00:00', '2024-06-06 10:00:00', 2300000, '2024-06-06 03:04:40'),
(14, 'QH-9441', 2, 1, '2024-06-08 00:00:00', '2024-06-08 10:00:00', 3150000, '2024-06-06 03:05:10'),
(15, 'VN-3616', 1, 2, '2024-06-07 10:00:00', '2024-06-07 12:20:00', 2450000, '2024-06-07 02:37:52'),
(16, 'QH-6370', 2, 1, '2024-06-08 18:00:00', '2024-06-08 20:30:00', 3670000, '2024-06-07 02:38:19'),
(17, 'VN-5201', 1, 2, '2024-06-10 07:00:00', '2024-06-10 10:00:00', 3420000, '2024-06-10 14:57:58'),
(18, 'VN-3163', 1, 2, '2024-06-11 07:00:00', '2024-06-11 09:30:00', 3600000, '2024-06-11 05:59:58'),
(19, 'VJ-6383', 2, 1, '2024-06-13 10:00:00', '2024-06-13 12:00:00', 4500000, '2024-06-11 06:00:30'),
(20, 'VN-181', 1, 2, '2024-06-18 08:00:00', '2024-06-18 10:00:00', 2400000, '2024-06-17 16:06:48'),
(21, 'QH-426', 2, 1, '2024-06-18 16:00:00', '2024-06-18 18:25:00', 3450000, '2024-06-17 17:40:50'),
(22, 'VJ-6620', 1, 2, '2024-06-18 04:00:00', '2024-06-18 06:40:00', 2340000, '2024-06-17 18:09:21'),
(23, 'VN-5205', 1, 2, '2024-06-19 15:00:00', '2024-06-19 17:20:00', 3140000, '2024-06-19 02:36:08'),
(24, 'QH-9567', 1, 2, '2024-06-19 20:00:00', '2024-06-19 22:17:00', 3560000, '2024-06-19 02:36:38'),
(25, 'VN-7891', 1, 2, '2024-06-20 12:00:00', '2024-06-20 14:10:00', 3500000, '2024-06-20 04:01:17'),
(26, 'QH-170', 1, 2, '2024-06-20 13:00:00', '2024-06-20 15:00:00', 4100000, '2024-06-20 04:01:50'),
(27, 'QH-8128', 1, 2, '2024-06-22 07:00:00', '2024-06-22 09:20:00', 2670000, '2024-06-21 03:14:19'),
(28, 'VN-6289', 1, 2, '2024-06-22 15:00:00', '2024-06-22 17:30:00', 2670000, '2024-06-21 03:26:19'),
(29, 'VJ-1375', 2, 1, '2024-06-23 19:00:00', '2024-06-23 21:50:00', 1360000, '2024-06-22 14:50:21'),
(30, 'VN-9886', 1, 2, '2024-06-25 16:00:00', '2024-06-25 18:40:00', 2450000, '2024-06-25 06:31:38'),
(31, 'QH-8380', 1, 2, '2024-06-25 20:00:00', '2024-06-25 22:20:00', 2900000, '2024-06-25 06:32:10'),
(32, 'VJ-5317', 1, 2, '2024-06-25 07:00:00', '2024-06-25 10:00:00', 1780000, '2024-06-25 06:32:36'),
(33, 'VN-6063', 1, 2, '2024-06-30 10:00:00', '2024-06-30 12:25:00', 2390000, '2024-06-28 02:41:17'),
(34, 'VJ-2868', 1, 2, '2024-06-30 15:00:00', '2024-06-30 17:15:00', 1954000, '2024-06-28 02:41:53'),
(35, 'QH-7122', 1, 2, '2024-06-30 18:10:00', '2024-06-30 20:30:00', 2900000, '2024-06-28 02:42:29'),
(36, 'VU-6164', 2, 1, '2024-07-01 02:00:00', '2024-07-01 04:00:00', 1560000, '2024-06-28 03:25:17'),
(37, 'VN-235', 1, 2, '2024-07-05 07:00:00', '2024-07-05 09:30:00', 1450000, '2024-07-02 06:27:31'),
(38, 'QH-1613', 1, 2, '2024-07-05 04:00:00', '2024-07-05 06:20:00', 2310000, '2024-07-02 06:28:01'),
(39, 'VJ-3011', 1, 2, '2024-07-05 14:00:00', '2024-07-05 16:30:00', 2390000, '2024-07-02 06:28:31'),
(40, 'VU-9381', 1, 2, '2024-07-05 21:00:00', '2024-07-05 22:10:00', 1990000, '2024-07-02 06:29:11'),
(41, 'BL-5811', 2, 1, '2024-07-05 04:00:00', '2024-07-05 06:08:00', 1908000, '2024-07-03 09:12:01'),
(42, 'VJ-2739', 1, 2, '2024-07-09 01:20:00', '2024-07-09 03:30:00', 1436600, '2024-07-05 06:34:08'),
(43, 'VJ-8396', 1, 2, '2024-07-09 21:15:00', '2024-07-09 23:25:00', 1544600, '2024-07-05 06:34:56'),
(44, 'QH-5629', 1, 2, '2024-07-09 23:40:00', '2024-07-10 01:50:00', 1566000, '2024-07-05 06:35:36'),
(45, 'VU-130', 1, 2, '2024-07-09 05:45:00', '2024-07-09 07:50:00', 1726000, '2024-07-05 06:36:48'),
(46, 'VN-6310', 1, 2, '2024-07-09 20:00:00', '2024-07-09 22:15:00', 2134000, '2024-07-05 06:37:32'),
(47, 'VN-9766', 1, 2, '2024-07-09 09:00:00', '2024-07-09 11:20:00', 2340000, '2024-07-05 06:38:00'),
(48, 'VJ-3651', 2, 1, '2024-07-09 22:40:00', '2024-07-10 00:50:00', 1544600, '2024-07-05 06:38:49'),
(49, 'QH-2394', 2, 1, '2024-07-09 23:30:00', '2024-07-10 01:40:00', 1566000, '2024-07-05 06:39:26'),
(50, 'VN-2858', 2, 1, '2024-07-09 12:30:00', '2024-07-09 14:40:00', 2134000, '2024-07-05 06:40:37'),
(51, 'VJ-3583', 2, 1, '2024-07-09 07:00:00', '2024-07-09 09:10:00', 1803800, '2024-07-05 06:42:26'),
(52, 'BL-5323', 2, 1, '2024-07-09 09:10:00', '2024-07-09 11:20:00', 1877600, '2024-07-05 06:43:11'),
(53, 'VN-7721', 1, 2, '2024-07-16 07:00:00', '2024-07-16 09:25:00', 1450000, '2024-07-11 14:56:53'),
(54, 'VN-4492', 1, 2, '2024-07-23 07:00:00', '2024-07-23 09:20:00', 1450000, '2024-07-17 06:05:50');

INSERT INTO `passengers` (`passenger_id`, `ticket_id`, `passenger_name`, `gender`, `date_of_birth`, `passport_number`, `type`) VALUES
(19, 51, 'Mai Vũ Cao Sơn', 1, '2004-04-15', '068204008774', 'adult');
INSERT INTO `passengers` (`passenger_id`, `ticket_id`, `passenger_name`, `gender`, `date_of_birth`, `passport_number`, `type`) VALUES
(20, 51, 'Admin', 1, '2013-05-31', '', 'children');
INSERT INTO `passengers` (`passenger_id`, `ticket_id`, `passenger_name`, `gender`, `date_of_birth`, `passport_number`, `type`) VALUES
(21, 52, 'Sơn', 1, '2004-04-15', 'VN123', 'adult');







INSERT INTO `tickets` (`ticket_id`, `ticket_number`, `flight_id`, `user_id`, `ticket_class`, `status`, `passenger`, `total_price`, `created_at`) VALUES
(51, 'TK7930', 46, 1, 'Business Class', 'booked', 2, 4257330, '2024-07-07 15:46:41');
INSERT INTO `tickets` (`ticket_id`, `ticket_number`, `flight_id`, `user_id`, `ticket_class`, `status`, `passenger`, `total_price`, `created_at`) VALUES
(52, 'TK3147', 42, 1, 'Economy Class', 'booked', 1, 1436600, '2024-07-09 07:18:58');




INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `gender`, `date_of_birth`, `nationality`, `cccd`, `address`, `phone`, `role`, `refresh_token`) VALUES
(1, 'MAI VU CAO SON', 'admin@gmail.com', '$2b$10$dbZGaJO0Y9sbPmrkosZSDelGujUpFrGO4HoCA22UqsF/S2zo2BbNW', 1, '2004-04-15', 'VIETNAM', '068204008774', '59/33B, Pham Viet Chanh, District 1, Ho Chi Minh city', '0336114129', 'ADMIN', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJrZXkiOiI5dGt0MjIiLCJpYXQiOjE3MjExMzk4ODIsImV4cCI6MTcyMTc0NDY4Mn0.0xYofAUWFa0wcm5SDNTarjNRPVsF6z0ZG4rdRk3_ALc');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `gender`, `date_of_birth`, `nationality`, `cccd`, `address`, `phone`, `role`, `refresh_token`) VALUES
(2, 'Test', 'test@gmail.com', '$2b$10$L3tmG68ZGSzBthOakOCTKOFw83OPM2v1KqzsVdZXzgmjaK0YJMhfG', 1, '2000-05-10', 'Viet Nam', '123', '123, 1A, LA', '0336114129', 'USER', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJrZXkiOiJFVHQyT1UiLCJpYXQiOjE3MjExNDI3OTgsImV4cCI6MTcyMTc0NzU5OH0.WAJAE5BuJ9vV75VetAduL3XHB8qYCEKn467OSh_eTsI');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;