const mysql = require('mysql2');
const fs = require('fs');

// Подключение к MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',  // Укажи пароль, если он есть
    database: 'koolihobi'
});

// Проверяем, существует ли папка mongodb
const outputDir = "C:/Users/Olga/WebstormProjects/SQL-keel/sql/mongodb";
if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
}

// Функция получения списка таблиц
function getTables(callback) {
    connection.query("SHOW TABLES", (err, results) => {
        if (err) throw err;
        const tables = results.map(row => Object.values(row)[0]);
        callback(tables);
    });
}

// Функция экспорта таблиц в JSON
function exportTablesToJson(tables) {
    let databaseJson = {};
    let remaining = tables.length;

    tables.forEach(table => {
        connection.query(`SELECT * FROM ${table}`, (err, results) => {
            if (err) throw err;
            databaseJson[table] = results;
            remaining--;

            if (remaining === 0) {
                fs.writeFileSync(`${outputDir}/dump.json`, JSON.stringify(databaseJson, null, 4), 'utf8');
                console.log("✅ База данных успешно конвертирована в JSON!");
                connection.end();
            }
        });
    });
}

// Запуск процесса
getTables(exportTablesToJson);
