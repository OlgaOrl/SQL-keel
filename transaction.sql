-- Alustame transaktsiooni
START TRANSACTION;

-- Lisame uue õpilase
INSERT INTO `student_data` (`student_id`, `first_name`, `last_name`, `birth_date`, `phone_number`, `email`, `city`)
VALUES (5, 'Karl', 'Koiv', '2000-01-01 00:00:00', '+37255555555', 'karlkoiv@gmail.com', 'Pärnu');

-- Vigane sisestus (telefon ja email valed)
INSERT INTO `student_data` (`student_id`, `first_name`, `last_name`, `birth_date`, `phone_number`, `email`, `city`)
VALUES (6, 'Eva', 'Elk', '2000-01-01 00:00:00', '55555555', 'evaelk.com', 'Tallinn');

-- Kui kõik õnnestub
COMMIT;

-- Kui tekib viga
ROLLBACK;

-- Tabelis pole uusi andmeid (student_id = 5 ja 6).