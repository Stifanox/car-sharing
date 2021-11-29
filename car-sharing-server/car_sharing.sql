-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 29 Lis 2021, 11:50
-- Wersja serwera: 10.4.17-MariaDB
-- Wersja PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `car_sharing`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `archives_reservations`
--

CREATE TABLE `archives_reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `archives_reservations`
--

INSERT INTO `archives_reservations` (`id`, `user_id`, `offer_id`, `date_start`, `date_end`, `status_id`) VALUES
(3, 14, 3, '2021-11-28', '2021-11-30', 4),
(4, 0, 3, '2021-11-28', '2021-11-29', 4),
(5, 0, 3, '2021-11-28', '2021-11-29', 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `body_types`
--

CREATE TABLE `body_types` (
  `id` int(11) NOT NULL,
  `body_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `body_types`
--

INSERT INTO `body_types` (`id`, `body_name`) VALUES
(1, 'Sedan');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_brands`
--

CREATE TABLE `car_brands` (
  `id` int(11) NOT NULL,
  `brand` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `car_brands`
--

INSERT INTO `car_brands` (`id`, `brand`) VALUES
(1, 'Ford'),
(2, 'Honda'),
(3, 'Mercedes-Benz'),
(4, 'Audi'),
(5, 'Volkswagen');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `offer`
--

CREATE TABLE `offer` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `horsepower` smallint(6) DEFAULT NULL,
  `price_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fuel_per_100_km` float DEFAULT NULL,
  `how_long_to_100` float DEFAULT NULL,
  `image_source` varchar(40) DEFAULT NULL,
  `model` varchar(40) DEFAULT NULL,
  `body_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `offer`
--

INSERT INTO `offer` (`id`, `brand_id`, `horsepower`, `price_id`, `description`, `fuel_per_100_km`, `how_long_to_100`, `image_source`, `model`, `body_id`) VALUES
(3, 1, 12, 1, 'Stary focus w twojej okolicy', 8, 11.2, 'ford_focus.jpg', 'Focus', 1),
(4, 2, 2, 1, 'Szybko', 5, 10.3, 'honda_civic.jpg', 'Civic', 1),
(5, 3, 4, 1, 'AAAAAAAAAAAAAA', 8, 4.3, 'mercedes_benc_amg.jpg', 'AMG', 1),
(6, 4, 125, 1, 'Wrum', 1, 20, 'audi_a3.jpg', 'A3', 1),
(7, 2, 300, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec sem imperdiet, tempus libero vel, cursus mi. Duis eget velit vitae lacus interdum varius at a lectus. Phasellus vitae diam vitae quam varius efficitur ac ut orci. Mauris arcu neque,', 16, 3.6, 'honda_accord.jpg', 'Accords', 1),
(8, 5, 90, 2, 'Ale fura', 12, 21, 'volkswagen_golf_IV.jpg', 'Golf IV', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `prices`
--

CREATE TABLE `prices` (
  `id` int(11) NOT NULL,
  `price` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `prices`
--

INSERT INTO `prices` (`id`, `price`) VALUES
(1, 200),
(2, 150);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `offer_id` int(11) DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `reservations`
--

INSERT INTO `reservations` (`id`, `user_id`, `offer_id`, `date_start`, `date_end`, `status_id`) VALUES
(5, 14, 3, '2021-11-28', '2021-11-29', 3);

--
-- Wyzwalacze `reservations`
--
DELIMITER $$
CREATE TRIGGER `archive_reservations` BEFORE DELETE ON `reservations` FOR EACH ROW INSERT INTO archives_reservations(user_id,offer_id,date_start,date_end,status_id) VALUES (OLD.user_id,OLD.offer_id,OLD.date_start,OLD.date_end,OLD.status_id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `roles`
--

INSERT INTO `roles` (`id`, `role_name`) VALUES
(1, 'administrator'),
(2, 'user'),
(3, 'moderator');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `status_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `status`
--

INSERT INTO `status` (`id`, `status_name`) VALUES
(1, 'available'),
(2, 'not_available'),
(3, 'waiting'),
(4, 'archive'),
(7, 'accepted');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(25) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `privilege_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `privilege_id`) VALUES
(14, 'q', 'q@q.q', '$2y$10$9mqm3hY7jltw632cuw4EeutB/IhpeZ7EAGhtYfQeIv1tVi3oNH12S', 2),
(15, 'admin', 'admin@admin.pl', '$2y$10$.AJlNjedc8rODibgjsWsB.xTTahv9otowrv.2h407vcPg3rlruu.q', 1),
(16, 'Klik', 'Klik@dowuzziola.pl', '$2y$10$VgAocaR9kg8LLn/fRxc7X.mT9E15cWbIjxazxYRGBA6S9M2vnzEYi', 2),
(17, 'Mod', 'Mod@mod.pl', '$2y$10$6JdovAwUKY4LzJrV1NldkeYGzC2JFrUmZub5WWxJskvit6ksFptga', 3),
(18, 'Mod2', 'Mod2@mod2.pl', '$2y$10$rNa3qWpdcEtfhWVUrGk6fODBYnr4De40iMoNjDO9IhQPnZUs8qsq.', 3),
(19, 'Nowy user', 'nowyuser@hihi.pl', '$2y$10$hC7PXbl/BWGHIqSGyXll.Ou5ujECgp4lbEEInWbUDJA0DtO/5S10K', 3),
(20, 'user', 'user@use', '$2y$10$n8UsfCeavqXRjcSKDlqZe.x9OF95KVFl.5WhDzHBXxahN5Tv3Ec8u', 2);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `archives_reservations`
--
ALTER TABLE `archives_reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`offer_id`,`status_id`);

--
-- Indeksy dla tabeli `body_types`
--
ALTER TABLE `body_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `car_brands`
--
ALTER TABLE `car_brands`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `offer`
--
ALTER TABLE `offer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`,`price_id`,`body_id`),
  ADD KEY `price_id` (`price_id`),
  ADD KEY `body_id` (`body_id`);

--
-- Indeksy dla tabeli `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`offer_id`,`status_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `offer_id` (`offer_id`);

--
-- Indeksy dla tabeli `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `privilege_id` (`privilege_id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `archives_reservations`
--
ALTER TABLE `archives_reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `body_types`
--
ALTER TABLE `body_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `car_brands`
--
ALTER TABLE `car_brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `offer`
--
ALTER TABLE `offer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `offer`
--
ALTER TABLE `offer`
  ADD CONSTRAINT `offer_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `car_brands` (`id`),
  ADD CONSTRAINT `offer_ibfk_2` FOREIGN KEY (`price_id`) REFERENCES `prices` (`id`),
  ADD CONSTRAINT `offer_ibfk_3` FOREIGN KEY (`body_id`) REFERENCES `body_types` (`id`);

--
-- Ograniczenia dla tabeli `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`offer_id`) REFERENCES `offer` (`id`);

--
-- Ograniczenia dla tabeli `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`privilege_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
