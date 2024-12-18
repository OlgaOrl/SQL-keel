-- Faili nimi: update_student_data.sql
-- Autor: [Olga Orlova]
-- Kuupäev: 18.12.2024
-- Kirjeldus:
-- 1. Lisame uue veeru registration_date.
-- 2. Muudame e-maili veeru unikaalseks, et tagada kordumatud e-mailid.

-- 1. Lisame uue veeru registration_date
-- Kommentaar:
-- Registreerimise kuupäeva lisamine võimaldab jälgida, millal õpilane süsteemis registreeriti.
-- Veeru vaikeväärtuseks on praegune kuupäev ja aeg.
ALTER TABLE student_data
    ADD COLUMN registration_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Õpilase registreerimise kuupäev';

-- 2. Muudame e-maili veeru unikaalseks
-- Kommentaar:
-- E-maili unikaalsuse tagamine väldib sama e-maili kasutamist mitme õpilase juures.
ALTER TABLE student_data
    ADD UNIQUE KEY `unique_email` (`email`);
