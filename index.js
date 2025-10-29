    require('dotenv').config();
    const express = require('express');
    const bodyParser = require('body-parser');
    const sql = require('mssql');

    const app = express();
    app.use(bodyParser.json());

    const config = {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        server: process.env.DB_SERVER,
        database: process.env.DB_NAME,
        port: parseInt(process.env.DB_PORT),
        options: {
            encrypt: false,
            trustServerCertificate: true
        }
    };

    app.get('/mascotas', async (req, res) => {
        try {
            let pool = await sql.connect(config);
            let result = await pool.request().query('SELECT * FROM Mascotas');
            res.json(result.recordset);
        } catch (err) {
            res.status(500).send(err.message);
        }
    });

    app.listen(3000, () => console.log('API corriendo en http://localhost:3000'));
