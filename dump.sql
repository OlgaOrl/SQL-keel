-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 18, 2024 at 01:32 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `koolihobi`
--

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
                                                                                                                        (4, 'Mati', 'Maasikas', '1995-03-06 00:00:00.000', '+37255487951', 'matimaasikas@gmail.com', 'Tartu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `student_data`
--
ALTER TABLE `student_data`
    ADD PRIMARY KEY (`student_id`),
    ADD UNIQUE KEY `unique_phone` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `student_data`
--
ALTER TABLE `student_data`
    MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;
