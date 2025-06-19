const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcryptjs');
const cors = require('cors');

const app = express();
const PORT = 3000;

// --- Middleware ---
// Habilita CORS para permitir que tu frontend (archivos HTML) se comunique con este servidor
app.use(cors());
// Permite al servidor entender los datos JSON enviados desde el frontend
app.use(express.json());

// --- Configuración de la Conexión a la Base de Datos ---
// Asegúrate de que estos datos coincidan con tu configuración de XAMPP.
// 'root' y una contraseña vacía son los valores por defecto de XAMPP.
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'dbLearnsityMultidimensional' // Nombre de la base de datos
});

db.connect((err) => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('Conectado exitosamente a la base de datos MySQL.');
});

// --- Rutas de la API ---

// RUTA PARA REGISTRAR UN NUEVO USUARIO
app.post('/register', async (req, res) => {
    const { Nombre_Completo, Nickname, Correo, Fecha_Nacimiento, password } = req.body;

    // Verificar si el correo ya existe
    db.query('SELECT Correo FROM Dim_Usuario WHERE Correo = ?', [Correo], async (err, result) => {
        if (err) {
            return res.status(500).json({ message: 'Error en el servidor.' });
        }
        if (result.length > 0) {
            return res.status(400).json({ message: 'El correo electrónico ya está registrado.' });
        }

        // Hashear la contraseña antes de guardarla
        const hashedPassword = await bcrypt.hash(password, 8);

        const newUser = {
            Nombre_Completo,
            Nickname,
            Correo,
            Fecha_Nacimiento,
            Password_Hash: hashedPassword
        };

        db.query('INSERT INTO Dim_Usuario SET ?', newUser, (err, result) => {
            if (err) {
                console.error('Error al registrar usuario:', err);
                return res.status(500).json({ message: 'No se pudo registrar al usuario.' });
            }
            res.status(201).json({ message: '¡Usuario registrado con éxito! Serás redirigido.' });
        });
    });
});

// RUTA PARA INICIAR SESIÓN
app.post('/login', (req, res) => {
    const { Correo, password } = req.body;

    if (!Correo || !password) {
        return res.status(400).json({ message: 'Por favor, ingrese correo y contraseña.' });
    }

    db.query('SELECT * FROM Dim_Usuario WHERE Correo = ?', [Correo], async (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error en el servidor.' });
        }

        if (results.length === 0) {
            return res.status(401).json({ message: 'Correo o contraseña incorrectos.' });
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.Password_Hash);

        if (!isMatch) {
            return res.status(401).json({ message: 'Correo o contraseña incorrectos.' });
        }
        
        // No enviar el hash de la contraseña al cliente
        const userToSend = {
            id: user.ID_Usuario_CS,
            nickname: user.Nickname,
            nombre: user.Nombre_Completo,
            correo: user.Correo
        };

        res.status(200).json({
            message: '¡Inicio de sesión exitoso!',
            user: userToSend
        });
    });
});


// --- Iniciar el Servidor ---
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});