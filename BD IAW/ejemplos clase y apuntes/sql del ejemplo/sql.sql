-- Creamos el usuario "usuario" con la contraseña "usuario".
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'usuario';

-- Creamos la base de datos tienda y sus tablas
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

-- Tabla 1: Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Tabla 2: Pedidos (uno-a-muchos con clientes)
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATE DEFAULT CURRENT_DATE,
    estado ENUM('pendiente', 'enviado', 'entregado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla 3: Productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Tabla 4: Relación muchos-a-muchos entre pedidos y productos
CREATE TABLE pedido_producto (
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT DEFAULT 1,
    PRIMARY KEY (pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);

-- Insertar clientes
INSERT INTO clientes (nombre, correo) VALUES
('Ana Torres', 'ana@example.com'),
('Luis Pérez', 'luis@example.com');

-- Insertar productos
INSERT INTO productos (nombre, precio, stock) VALUES
('Teclado mecánico', 45.99, 20),
('Ratón inalámbrico', 25.50, 35),
('Monitor 24"', 150.00, 10);

-- Insertar pedidos
INSERT INTO pedidos (cliente_id, fecha_pedido, estado) VALUES
(1, '2025-11-15', 'enviado'),
(2, '2025-11-16', 'pendiente');

-- Insertar relación pedido-producto
INSERT INTO pedido_producto (pedido_id, producto_id, cantidad) VALUES
(1, 1, 2),  -- Pedido 1: 2 teclados
(1, 2, 1),  -- Pedido 1: 1 ratón
(2, 3, 1);  -- Pedido 2: 1 monitor

-- Finalmente le damos permisos al usuario `usuario` sobre esta base de datos recién creada.
GRANT ALL PRIVILEGES ON `tienda`.* TO 'usuario'@'localhost';

-- Guardamos los cambios realizados
FLUSH PRIVILEGES;