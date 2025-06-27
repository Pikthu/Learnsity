// js/auth.js

// Al cargar cualquier página, actualiza el header según la sesión
document.addEventListener('DOMContentLoaded', () => {
    updateHeader();
});

function updateHeader() {
    const navButtonsContainer = document.getElementById('nav-auth-buttons');
    if (!navButtonsContainer) return;

    const user = JSON.parse(sessionStorage.getItem('user'));

    if (user && user.nickname) {
        // Usuario ha iniciado sesión
        navButtonsContainer.innerHTML = `
            <button onclick="location.href='../Modelo/foro.html'">Foro</button>
            <button onclick="location.href='../Modelo/mi_perfil.html'">👤 ${user.nickname}</button>
            <button onclick="logout()">Cerrar Sesión</button>
        `;
    } else {
        // Usuario no ha iniciado sesión
        navButtonsContainer.innerHTML = `
            <button onclick="location.href='../Modelo/foro.html'">Foro</button>
            <button onclick="location.href='../Modelo/login.html'">Iniciar Sesión</button>
            <button onclick="location.href='../Modelo/registro.html'">Registrarse</button>
        `;
    }
}

// --- Lógica de Registro ---
async function handleRegister(event) {
    event.preventDefault();
    if (!validateRegistrationForm()) {
        showPopup('Por favor, corrija los errores del formulario.', 'error');
        return;
    }
    const form = event.target;
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    try {
        const response = await fetch('http://localhost:3000/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        const result = await response.json();
        if (response.ok) {
            showPopup(result.message, 'success');
            setTimeout(() => { window.location.href = 'login.html'; }, 2000);
        } else {
            showPopup(`Error: ${result.message}`, 'error');
        }
    } catch (error) {
        showPopup('Error de conexión con el servidor.', 'error');
    }
}

// --- Lógica de Login ---
async function handleLogin(event) {
    event.preventDefault();
    const form = event.target;
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    try {
        const response = await fetch('http://localhost:3000/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        const result = await response.json();
        if (response.ok) {
            sessionStorage.setItem('user', JSON.stringify(result.user));
            showPopup(result.message, 'success');
            setTimeout(() => { window.location.href = 'index.html'; }, 1500);
        } else {
            showPopup(`Error: ${result.message}`, 'error');
        }
    } catch (error) {
        showPopup('Error de conexión con el servidor.', 'error');
    }
}

// --- Lógica de Logout ---
function logout() {
    sessionStorage.removeItem('user');
    showPopup('Has cerrado sesión.', 'success');
    setTimeout(() => { window.location.href = 'index.html'; }, 1500);
}


// --- Función de Validación (movida desde tu registro.html) ---
function validateRegistrationForm() {
    let isValid = true;
    const nicknameError = document.getElementById('nicknameError');
    const correoError = document.getElementById('correoError');
    const fechaError = document.getElementById('fechaError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');

    document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
    
    // Aquí va TODO el código de validación que tenías en registro.html
    const nickname = document.getElementById('nickname').value;
    if (nickname.length > 16) {
        nicknameError.textContent = 'El nickname no puede tener más de 16 caracteres.';
        nicknameError.style.display = 'block';
        isValid = false;
    }
    const correo = document.getElementById('correo').value;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(correo)) {
        correoError.textContent = 'Por favor, ingrese un formato de correo válido.';
        correoError.style.display = 'block';
        isValid = false;
    }
    const fechaNacimiento = new Date(document.getElementById('fecha-nacimiento').value);
    if (!isNaN(fechaNacimiento.getTime())) {
        const hoy = new Date();
        let edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
        const m = hoy.getMonth() - fechaNacimiento.getMonth();
        if (m < 0 || (m === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
            edad--;
        }
        if (edad < 12 || edad > 100) {
            fechaError.textContent = 'Debes tener entre 12 y 100 años para registrarte.';
            fechaError.style.display = 'block';
            isValid = false;
        }
    } else {
        fechaError.textContent = 'Por favor, ingrese una fecha válida.';
        fechaError.style.display = 'block';
        isValid = false;
    }
    const password = document.getElementById('password').value;
    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{6,}$/;
    if (password.length < 6) {
        passwordError.textContent = 'La contraseña debe tener al menos 6 caracteres.';
        passwordError.style.display = 'block';
        isValid = false;
    } else if (!passwordRegex.test(password)) {
        passwordError.textContent = 'Debe incluir al menos una mayúscula, un número y un símbolo.';
        passwordError.style.display = 'block';
        isValid = false;
    }
    const confirmPassword = document.getElementById('confirm-password').value;
    if (password !== confirmPassword) {
        confirmPasswordError.textContent = 'Las contraseñas no coinciden.';
        confirmPasswordError.style.display = 'block';
        isValid = false;
    }
    return isValid;
}

// --- Función de POP-UP ---
function showPopup(message, type = 'success') {
    const popup = document.createElement('div');
    popup.className = `popup ${type}`;
    popup.textContent = message;
    document.body.appendChild(popup);

    setTimeout(() => { popup.classList.add('show'); }, 10);
    setTimeout(() => {
        popup.classList.remove('show');
        setTimeout(() => { document.body.removeChild(popup); }, 500);
    }, 3000);
}