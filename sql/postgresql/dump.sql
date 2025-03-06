-- Создание базы (если её нет)
CREATE DATABASE koolihobi;
\c koolihobi;

-- Создание таблицы audit_logs
CREATE TABLE audit_logs (
                            log_id SERIAL PRIMARY KEY,
                            table_name VARCHAR(50) NOT NULL,
                            operation VARCHAR(10) NOT NULL,
                            old_data JSONB DEFAULT NULL,
                            new_data JSONB DEFAULT NULL,
                            changed_by VARCHAR(50) DEFAULT NULL,
                            changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы student_data
CREATE TABLE student_data (
                              student_id SERIAL PRIMARY KEY,
                              first_name VARCHAR(191),
                              last_name VARCHAR(191),
                              birth_date TIMESTAMP,
                              phone_number VARCHAR(191),
                              email VARCHAR(191),
                              city VARCHAR(50)
);

-- Вставка данных
INSERT INTO student_data (first_name, last_name, birth_date, phone_number, email, city) VALUES
                                                                                            ('James', 'Holm', '1985-06-07 00:00:00', '+37255884466', 'jamesholm@gmail.com', 'Tartu'),
                                                                                            ('Linda', 'Kask', '1990-03-15 00:00:00', '+37255352845', 'lindakask@gmail.com', 'Tallinn'),
                                                                                            ('Olga', 'Orlova', '1989-09-26 00:00:00', '+37251965832', 'olala@gmail.com', 'Narva'),
                                                                                            ('Mati', 'Maasikas', '1995-03-06 00:00:00', '+37255487951', 'matimaasikas@gmail.com', 'Tartu'),
                                                                                            ('Karl', 'Koiv', '2000-01-01 00:00:00', '+37255555555', 'karlkoiv@gmail.com', 'Pärnu');

-- Триггер для логирования обновлений (PostgreSQL версия)
CREATE OR REPLACE FUNCTION log_student_update()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_logs (table_name, operation, old_data, new_data, changed_by)
    VALUES (
               'student_data',
               'UPDATE',
               jsonb_build_object(
                       'first_name', OLD.first_name,
                       'last_name', OLD.last_name,
                       'phone_number', OLD.phone_number,
                       'email', OLD.email,
                       'city', OLD.city
               ),
               jsonb_build_object(
                       'first_name', NEW.first_name,
                       'last_name', NEW.last_name,
                       'phone_number', NEW.phone_number,
                       'email', NEW.email,
                       'city', NEW.city
               ),
               current_user
           );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_student_update
    AFTER UPDATE ON student_data
    FOR EACH ROW
EXECUTE FUNCTION log_student_update();

-- Триггер для валидации номера телефона и email перед вставкой
CREATE OR REPLACE FUNCTION validate_student_insert()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.phone_number !~ '^\+[0-9]{10,15}$' THEN
        RAISE EXCEPTION 'Telefoninumber ei ole korrektne. See peab algama "+" ja sisaldama 10-15 numbrit.';
    END IF;

    IF NEW.email !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        RAISE EXCEPTION 'Emaili aadress ei ole korrektne.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_student_insert
    BEFORE INSERT ON student_data
    FOR EACH ROW
EXECUTE FUNCTION validate_student_insert();
