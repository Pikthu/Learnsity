const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcryptjs');
const cors = require('cors');

const app = express();
const PORT = 3000;

// --- Middleware ---
app.use(cors());
app.use(express.json());

// --- Configuración de la Conexión a la Base de Datos ---
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // Contraseña de tu MySQL en XAMPP (usualmente vacía)
    database: 'dbLearnsityMultidimensional'
});

db.connect((err) => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('Conectado exitosamente a la base de datos MySQL.');
});

// --- Función Auxiliar para la Fecha ---
// Genera un ID de fecha en formato AAAAMMDD
function getFechaId(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return parseInt(`${year}${month}${day}`);
}


// --- Rutas de la API ---

// RUTA PARA REGISTRAR UN NUEVO USUARIO
app.post('/register', (req, res) => {
    const { Nombre_Completo, Nickname, Correo, Fecha_Nacimiento, password } = req.body;

    // 1. Verificar si el correo ya existe
    db.query('SELECT Correo FROM Dim_Usuario WHERE Correo = ?', [Correo], async (err, result) => {
        if (err) {
            console.error('Error en SELECT Dim_Usuario:', err);
            return res.status(500).json({ message: 'Error en el servidor.' });
        }
        if (result.length > 0) {
            return res.status(400).json({ message: 'El correo electrónico ya está registrado.' });
        }

        // 2. Hashear la contraseña
        const hashedPassword = await bcrypt.hash(password, 8);
        const newUser = { Nombre_Completo, Nickname, Correo, Fecha_Nacimiento, Password_Hash: hashedPassword };

        // 3. Insertar el nuevo usuario en Dim_Usuario
        db.query('INSERT INTO Dim_Usuario SET ?', newUser, (err, result) => {
            if (err) {
                console.error('Error en INSERT Dim_Usuario:', err);
                return res.status(500).json({ message: 'No se pudo registrar al usuario.' });
            }
            
            // ¡NUEVO! Registrar el evento en Hecho_Registros_Usuario
            const nuevoUsuarioId = result.insertId; // Obtenemos el ID del usuario recién creado
            const fechaId = getFechaId(new Date());
            const registroHecho = {
                ID_Usuario_CS: nuevoUsuarioId,
                ID_Fecha_Registro_CS: fechaId
            };

            db.query('INSERT INTO Hecho_Registros_Usuario SET ?', registroHecho, (err, result) => {
                if (err) {
                    // Si esto falla, no deberíamos detener todo. Solo registrar el error.
                    console.error('Error al registrar en Hecho_Registros_Usuario:', err);
                } else {
                    console.log('Evento de registro guardado en la tabla de hechos.');
                }
            });

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

    // 1. Encontrar al usuario por su correo
    db.query('SELECT * FROM Dim_Usuario WHERE Correo = ?', [Correo], async (err, results) => {
        if (err) {
            console.error('Error en SELECT Dim_Usuario (login):', err);
            return res.status(500).json({ message: 'Error en el servidor.' });
        }

        if (results.length === 0) {
            return res.status(401).json({ message: 'Correo o contraseña incorrectos.' });
        }

        const user = results[0];
        // 2. Comparar la contraseña ingresada con el hash guardado
        const isMatch = await bcrypt.compare(password, user.Password_Hash);

        if (!isMatch) {
            return res.status(401).json({ message: 'Correo o contraseña incorrectos.' });
        }
        
        // ¡NUEVO! Registrar el evento en Hecho_Logins
        const fechaId = getFechaId(new Date());
        const loginHecho = {
            ID_Usuario_CS: user.ID_Usuario_CS,
            ID_Fecha_Login_CS: fechaId
        };
        db.query('INSERT INTO Hecho_Logins SET ?', loginHecho, (err, result) => {
            if (err) {
                console.error('Error al registrar en Hecho_Logins:', err);
            } else {
                console.log('Evento de login guardado en la tabla de hechos.');
            }
        });
        
        // 3. Preparar y enviar los datos del usuario al frontend
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
