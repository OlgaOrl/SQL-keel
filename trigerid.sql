-- Auditilogide tabeli loomine (kui see ei eksisteeri)
CREATE TABLE IF NOT EXISTS `audit_logs`
(
    `log_id`     int         NOT NULL AUTO_INCREMENT,        -- Logikirje unikaalne ID
    `table_name` varchar(50) NOT NULL,                       -- Tabeli nimi, kus muudatus tehti
    `operation`  varchar(10) NOT NULL,                       -- Operatsiooni tüüp (UPDATE, INSERT jne)
    `old_data`   JSON,                                       -- Vanad andmed JSON-formaadis
    `new_data`   JSON,                                       -- Uued andmed JSON-formaadis
    `changed_by` varchar(50)      DEFAULT NULL,              -- Kasutaja, kes muudatuse tegi
    `changed_at` timestamp   NULL DEFAULT CURRENT_TIMESTAMP, -- Muudatuse aeg
    PRIMARY KEY (`log_id`)                                   -- Esmane võti
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- Tabeli `student_data` loomine (kui see ei eksisteeri)
CREATE TABLE IF NOT EXISTS `student_data`
(
    `student_id`        int NOT NULL AUTO_INCREMENT,                                                                                                      -- Õpilase unikaalne ID
    `first_name`        varchar(191)                                                 DEFAULT NULL,                                                        -- Õpilase eesnimi
    `last_name`         varchar(191)                                                 DEFAULT NULL,                                                        -- Õpilase perekonnanimi
    `birth_date`        datetime(3)                                                  DEFAULT NULL,                                                        -- Õpilase sünnikuupäev
    `phone_number`      varchar(191)                                                 DEFAULT NULL,                                                        -- Õpilase telefoninumber
    `email`             varchar(191)                                                 DEFAULT NULL,                                                        -- Õpilase e-posti aadress
    `city`              varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,                                                        -- Linn
    `registration_date` datetime                                                     DEFAULT CURRENT_TIMESTAMP COMMENT 'Õpilase registreerimise kuupäev', -- Registreerimise kuupäev
    PRIMARY KEY (`student_id`),                                                                                                                           -- Esmane võti
    UNIQUE KEY `unique_phone` (`phone_number`),                                                                                                           -- Unikaalne telefoninumber
    UNIQUE KEY `unique_email` (`email`)                                                                                                                   -- Unikaalne e-posti aadress
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- AFTER UPDATE trigger tabelile `student_data`
DELIMITER $$
CREATE TRIGGER `after_student_update`
    AFTER UPDATE
    ON `student_data`
    FOR EACH ROW
BEGIN
    -- Vanade ja uute andmete logimine audititabelisse JSON-formaadis
    INSERT INTO `audit_logs` (table_name, operation, old_data, new_data, changed_by)
    VALUES ('student_data', -- Tabeli nimi
            'UPDATE', -- Operatsiooni tüüp
            JSON_OBJECT(
                    'first_name', OLD.first_name,
                    'last_name', OLD.last_name,
                    'phone_number', OLD.phone_number,
                    'email', OLD.email,
                    'city', OLD.city
            ), -- Vanad andmed
            JSON_OBJECT(
                    'first_name', NEW.first_name,
                    'last_name', NEW.last_name,
                    'phone_number', NEW.phone_number,
                    'email', NEW.email,
                    'city', NEW.city
            ), -- Uued andmed
            USER() -- Kasutaja, kes muudatuse tegi
           );
END$$
DELIMITER ;

-- BEFORE INSERT trigger tabelile `student_data`
DELIMITER $$
CREATE TRIGGER `before_student_insert`
    BEFORE INSERT
    ON `student_data`
    FOR EACH ROW
BEGIN
    -- Kontroll, kas telefoninumber on korrektse formaadiga
    IF NEW.phone_number NOT REGEXP '^\\+[0-9]{10,15}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Telefoninumber ei ole korrektne. See peab algama "+" ja sisaldama 10-15 numbrit.';
    END IF;

    -- Kontroll, kas e-posti aadress on korrektse formaadiga
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Emaili aadress ei ole korrektne.';
    END IF;
END$$
DELIMITER ;
