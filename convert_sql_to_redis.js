const mysql = require("mysql2");
const redis = require("redis");

const client = redis.createClient();
client.connect();

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "koolihobi"
});

db.connect(err => {
    if (err) throw err;
    console.log("✅ Подключено к MySQL");

    db.query("SELECT * FROM student_data", async (err, results) => {
        if (err) throw err;

        for (let student of results) {
            const key = `student:${student.student_id}`;
            await client.set(key, JSON.stringify(student));
            console.log(`Добавлен: ${key}`);
        }

        console.log("✅ Данные загружены в Redis");
        db.end();
        client.quit();
    });
});
