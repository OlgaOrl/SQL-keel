const redis = require('redis');
const client = redis.createClient();

client.on('error', (err) => console.error('Redis error:', err));

client.connect().then(async () => {
    console.log('✅ Подключено к Redis');

    // Добавляем студентов в Redis как JSON-строку
    await client.set('students', JSON.stringify([
        { student_id: 1, first_name: 'James', last_name: 'Holm', city: 'Tartu' },
        { student_id: 2, first_name: 'Linda', last_name: 'Kask', city: 'Tallinn' },
        { student_id: 3, first_name: 'Olga', last_name: 'Orlova', city: 'Narva' },
        { student_id: 4, first_name: 'Mati', last_name: 'Maasikas', city: 'Tartu' },
        { student_id: 5, first_name: 'Karl', last_name: 'Koiv', city: 'Pärnu' }
    ]));

    console.log('✅ Данные загружены в Redis');

    client.quit();
});
