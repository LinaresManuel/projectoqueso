-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gestion_quesos;
USE gestion_quesos;

-- Tabla PROVEEDORES
CREATE TABLE IF NOT EXISTS proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla LOTES
CREATE TABLE IF NOT EXISTS lotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    peso_real DECIMAL(10,2) NOT NULL COMMENT 'Peso en gramos',
    peso_comercial DECIMAL(10,2) NOT NULL COMMENT 'Peso en gramos',
    sobrante DECIMAL(10,2) GENERATED ALWAYS AS (peso_real - peso_comercial) STORED,
    costo_total DECIMAL(12,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Tabla CLIENTES
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion TEXT,
    balance DECIMAL(12,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla VENTAS (versión optimizada)
CREATE TABLE IF NOT EXISTS ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    lote_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    tipo_queso VARCHAR(50) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    unidad_medida ENUM('kg', 'lb') NOT NULL DEFAULT 'kg',
    precio_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    metodo_pago ENUM('Efectivo', 'Transferencia', 'Abono') NOT NULL DEFAULT 'Efectivo',
    pagado DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    saldo_pendiente DECIMAL(12,2) GENERATED ALWAYS AS (total - pagado) STORED,
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

-- Tabla PAGOS
CREATE TABLE IF NOT EXISTS pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    venta_id INT COMMENT 'Opcional: vincular a venta específica',
    monto DECIMAL(12,2) NOT NULL,
    fecha DATETIME NOT NULL,
    metodo ENUM('Efectivo', 'Transferencia') NOT NULL DEFAULT 'Efectivo',
    referencia VARCHAR(100),
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (venta_id) REFERENCES ventas(id)
);

-- Tabla AJUSTES_INVENTARIO
CREATE TABLE IF NOT EXISTS ajustes_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lote_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL COMMENT 'Peso en gramos',
    tipo ENUM('entrada', 'salida', 'ajuste') NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

