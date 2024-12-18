const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    await prisma.student_data.createMany({
        data: [
            {
                first_name: 'Olga',
                last_name: 'Orlova',
                birth_date: new Date('1988-01-21'),
                phone_number: '+37255643098',
                email: 'olga.orlova@vikk.ee',
            },
            {
                first_name: 'James',
                last_name: 'Holm',
                birth_date: new Date('1985-06-07'),
                phone_number: '+37255884466',
                email: 'jamesholm@gmail.com',
            },
            {
                first_name: 'Linda',
                last_name: 'Kask',
                birth_date: new Date('1990-03-15'),
                phone_number: '+37255643098',
                email: `lindakask@gmail.com`,
            },
            {
                first_name: 'Mati',
                last_name: 'Maasikas',
                birth_date: new Date('1952-10-07'),
                phone_number: '+37255643098',
                email: `matimaasikas@gmail.com`,
            },
        ],
    });
}

main()
    .then(() => {
        console.log('Seed data added successfully');
        prisma.$disconnect();
    })
    .catch((error) => {
        console.error('Error seeding data:', error);
        prisma.$disconnect();
    });
