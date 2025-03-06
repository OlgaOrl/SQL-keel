const express = require('express');
const { PrismaClient } = require('@prisma/client');
const exphbs = require('express-handlebars');
const app = express();
const port = 3000;

const prisma = new PrismaClient();

// Настройка Handlebars
app.engine('handlebars', exphbs.engine());
app.set('view engine', 'handlebars');
app.set('views', './views');

app.get('/', async (req, res) => {
    try {
        const students = await prisma.student_data.findMany();
        const formattedStudents = students.map(student => ({
            ...student,
            birth_date: student.birth_date.toISOString().split('T')[0], // Оставляем только дату
        }));
        res.render('home', { students: formattedStudents });
    } catch (error) {
        console.error('Ошибка на сервере:', error);
        res.status(500).send('Internal Server Error');
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${3000}`);
});
