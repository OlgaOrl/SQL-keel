-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 04, 2025 at 04:19 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `koolihobi`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `operation` varchar(10) NOT NULL,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `changed_by` varchar(50) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_data`
--

CREATE TABLE `student_data` (
  `student_id` int NOT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `birth_date` datetime(3) DEFAULT NULL,
  `phone_number` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `student_data`
--

INSERT INTO `student_data` (`student_id`, `first_name`, `last_name`, `birth_date`, `phone_number`, `email`, `city`) VALUES
(1, 'James', 'Holm', '1985-06-07 00:00:00.000', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
(2, 'Linda', 'Kask', '1990-03-15 00:00:00.000', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
(3, 'Olga ', 'Orlova', '1989-09-26 00:00:00.000', '+37251965832', 'olala@gmail.com', 'Narva'),
(4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
(1, 'James', 'Holm', '1985-06-07 00:00:00.000', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
(2, 'Linda', 'Kask', '1990-03-15 00:00:00.000', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
(3, 'Olga ', 'Orlova', '1989-09-26 00:00:00.000', '+37251965832', 'olala@gmail.com', 'Narva'),
(4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
(1, 'James', 'Holm', '1985-06-07 00:00:00.000', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
(2, 'Linda', 'Kask', '1990-03-15 00:00:00.000', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
(3, 'Olga ', 'Orlova', '1989-09-26 00:00:00.000', '+37251965832', 'olala@gmail.com', 'Narva'),
(4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
(1, 'James', 'Holm', '1985-06-07 00:00:00.000', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
(2, 'Linda', 'Kask', '1990-03-15 00:00:00.000', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
(3, 'Olga ', 'Orlova', '1989-09-26 00:00:00.000', '+37251965832', 'olala@gmail.com', 'Narva'),
(4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
(5, 'Karl', 'Koiv', '2000-01-01 00:00:00.000', '+37255555555', 'karlkoiv@gmail.com', 'Pärnu'),
(1, 'James', 'Holm', '1985-06-07 00:00:00.000', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
(2, 'Linda', 'Kask', '1990-03-15 00:00:00.000', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
(3, 'Olga ', 'Orlova', '1989-09-26 00:00:00.000', '+37251965832', 'olala@gmail.com', 'Narva'),
(4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
(5, 'Karl', 'Koiv', '2000-01-01 00:00:00.000', '+37255555555', 'karlkoiv@gmail.com', 'Pärnu');

--
-- Triggers `student_data`
--
DELIMITER $$
CREATE TRIGGER `after_student_update` AFTER UPDATE ON `student_data` FOR EACH ROW BEGIN
    INSERT INTO `audit_logs` (table_name, operation, old_data, new_data, changed_by)
    VALUES (
               'student_data',
               'UPDATE',
               JSON_OBJECT(
                       'first_name', OLD.first_name,
                       'last_name', OLD.last_name,
                       'phone_number', OLD.phone_number,
                       'email', OLD.email,
                       'city', OLD.city
               ),
               JSON_OBJECT(
                       'first_name', NEW.first_name,
                       'last_name', NEW.last_name,
                       'phone_number', NEW.phone_number,
                       'email', NEW.email,
                       'city', NEW.city
               ),
               USER()
           );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_student_insert` BEFORE INSERT ON `student_data` FOR EACH ROW BEGIN
    IF NEW.phone_number NOT REGEXP '^\+[0-9]{10,15}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Telefoninumber ei ole korrektne. See peab algama "+" ja sisaldama 10-15 numbrit.';
    END IF;

    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Emaili aadress ei ole korrektne.';
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
