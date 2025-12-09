-- ============================================
-- CREAR BASE DE DATOS
-- ============================================

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS mi_base_datos 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Seleccionar la base de datos para trabajar con ella
USE mi_base_datos;

-- ============================================
-- CREAR TABLA DE USUARIOS
-- ============================================

-- Crear la tabla usuarios con todos los campos necesarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- ID autoincremental, clave primaria
    nombre VARCHAR(100) NOT NULL,                -- Nombre del usuario (máximo 100 caracteres)
    email VARCHAR(150) NOT NULL UNIQUE,          -- Email único (no pueden haber emails duplicados)
    password VARCHAR(255) NOT NULL,              -- Contraseña hasheada (255 caracteres para el hash)
    pais VARCHAR(50) NOT NULL,                   -- País del usuario
    mensaje TEXT,                                -- Mensaje opcional (puede ser NULL)
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro (se asigna automáticamente)
    INDEX idx_email (email),                     -- Índice en email para búsquedas más rápidas
    INDEX idx_pais (pais)                        -- Índice en país para filtros más rápidos
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INSERTAR DATOS DE EJEMPLO (OPCIONAL)
-- ============================================

-- Insertar algunos usuarios de prueba
INSERT INTO usuarios (nombre, email, password, pais, mensaje) VALUES
('Juan Pérez', 'juan@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'España', 'Usuario de prueba'),
('María García', 'maria@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'México', 'Otro usuario de prueba'),
('Carlos López', 'carlos@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Argentina', NULL);

-- ============================================
-- CONSULTAS ÚTILES PARA PRUEBAS
-- ============================================

-- Ver todos los usuarios
SELECT * FROM usuarios;

-- Ver solo nombre y email
SELECT nombre, email FROM usuarios;

-- Buscar usuario por email
SELECT * FROM usuarios WHERE email = 'juan@email.com';

-- Contar cuántos usuarios hay
SELECT COUNT(*) as total_usuarios FROM usuarios;

-- Ver usuarios por país
SELECT pais, COUNT(*) as cantidad FROM usuarios GROUP BY pais;

-- Eliminar un usuario por ID
-- DELETE FROM usuarios WHERE id = 1;

-- Actualizar datos de un usuario
-- UPDATE usuarios SET nombre = 'Nuevo Nombre' WHERE id = 1;

-- Vaciar la tabla (eliminar todos los registros)
-- TRUNCATE TABLE usuarios;

-- Eliminar la tabla completa
-- DROP TABLE usuarios;