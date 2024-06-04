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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(20) NOT NULL,
  `flight_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `ticket_class` varchar(100) DEFAULT NULL,
  `price` int NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'booked',
  `passenger` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  UNIQUE KEY `ticket_number` (`ticket_number`),
  KEY `flight_id` (`flight_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(11, 'VN-294', 1, 2, '2024-06-04 07:00:00', '2024-06-04 09:20:00', 3500000, '2024-06-04 05:52:46');



INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `gender`, `date_of_birth`, `nationality`, `cccd`, `address`, `phone`, `role`, `refresh_token`) VALUES
(1, 'MAI VU CAO SON', 'admin@gmail.com', '$2b$10$dbZGaJO0Y9sbPmrkosZSDelGujUpFrGO4HoCA22UqsF/S2zo2BbNW', 1, '2004-04-15', 'VIETNAM', '068204008774', '59/33B, Pham Viet Chanh, District 1, Ho Chi Minh city', '0336114129', 'ADMIN', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJrZXkiOiJtR2x6cWUiLCJpYXQiOjE3MTc0ODAyNTUsImV4cCI6MTcxODA4NTA1NX0.aBpqN8lEOtY0-Y-p-P4TagJP4lCYMR9EdW-7gBCF_I8');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;