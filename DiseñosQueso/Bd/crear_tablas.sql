-- Tablas relacionadas con proveedores, lotes e inventarios
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(20) NOT NULL
);

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    unidad ENUM('kg', 'lb', 'litro', 'unidad') NOT NULL
);

CREATE TABLE recepciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    fecha DATE NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

CREATE TABLE lotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad_total DECIMAL(10,2) DEFAULT 0,
    peso_comercial DECIMAL(10,2),
    sobrante DECIMAL(10,2) GENERATED ALWAYS AS (cantidad_total - peso_comercial) STORED,
    cantidad_vendida DECIMAL(10,2) DEFAULT 0,
    cantidad_disponible DECIMAL(10,2) GENERATED ALWAYS AS (peso_comercial - cantidad_vendida) STORED,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    UNIQUE KEY (proveedor_id, producto_id) -- Un lote activo por producto/proveedor
);

CREATE TABLE ingresos_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recepcion_id INT NOT NULL,
    producto_id INT NOT NULL,
    lote_id INT NULL, -- Se asigna después al lote correspondiente
    cantidad DECIMAL(10,2) NOT NULL,
    detalles TEXT,
    FOREIGN KEY (recepcion_id) REFERENCES recepciones(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

CREATE TABLE pagos_proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    lote_id INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total_pago DECIMAL(12,2) GENERATED ALWAYS AS (precio_unitario * (SELECT peso_comercial FROM lotes WHERE id = lote_id)) STORED,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

-- Tablas relacionadas con clientes y ventas
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(20),
    balance DECIMAL(12,2) DEFAULT 0.00 COMMENT 'Saldo del cliente (positivo: depósito, negativo: deuda)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    lote_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    monto_pagado DECIMAL(12,2) DEFAULT 0.00 COMMENT 'Monto pagado por el cliente en esta venta',
    pagado BOOLEAN DEFAULT FALSE COMMENT 'Indica si la venta fue completamente pagada',
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

CREATE TABLE pagos_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    venta_id INT NULL COMMENT 'Pago vinculado a una venta específica (opcional)',
    monto DECIMAL(12,2) NOT NULL COMMENT 'Monto del pago o depósito',
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (venta_id) REFERENCES ventas(id)
);

-- Triggers para automatización
DELIMITER //

-- Asignar ingresos a lotes existentes o crear nuevos
CREATE TRIGGER after_ingreso_insert
AFTER INSERT ON ingresos_productos
FOR EACH ROW
BEGIN
    DECLARE v_lote_id INT;
    
    -- Buscar lote existente para este producto/proveedor
    SELECT id INTO v_lote_id FROM lotes 
    WHERE proveedor_id = (
        SELECT proveedor_id FROM recepciones WHERE id = NEW.recepcion_id
    ) AND producto_id = NEW.producto_id
    LIMIT 1;
    
    -- Si no existe, crear uno nuevo
    IF v_lote_id IS NULL THEN
        INSERT INTO lotes (proveedor_id, producto_id)
        VALUES (
            (SELECT proveedor_id FROM recepciones WHERE id = NEW.recepcion_id),
            NEW.producto_id
        );
        SET v_lote_id = LAST_INSERT_ID();
    END IF;
    
    -- Actualizar lote y vincular ingreso
    UPDATE lotes 
    SET cantidad_total = cantidad_total + NEW.cantidad
    WHERE id = v_lote_id;
    
    UPDATE ingresos_productos 
    SET lote_id = v_lote_id 
    WHERE id = NEW.id;
END//

-- Actualizar lote al vender
CREATE TRIGGER after_venta_insert
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    -- Actualizar la cantidad vendida en el lote
    UPDATE lotes
    SET cantidad_vendida = cantidad_vendida + NEW.cantidad
    WHERE id = NEW.lote_id;

    -- Actualizar la cantidad disponible en el lote
    UPDATE lotes
    SET cantidad_disponible = peso_comercial - cantidad_vendida
    WHERE id = NEW.lote_id;
END//

-- Actualizar balance del cliente y monto pagado en la venta
CREATE TRIGGER after_pago_insert
AFTER INSERT ON pagos_clientes
FOR EACH ROW
BEGIN
    -- Actualizar el balance del cliente
    UPDATE clientes
    SET balance = balance + NEW.monto
    WHERE id = NEW.cliente_id;

    -- Si el pago está vinculado a una venta, actualizar el monto pagado en la venta
    IF NEW.venta_id IS NOT NULL THEN
        UPDATE ventas
        SET monto_pagado = monto_pagado + NEW.monto
        WHERE id = NEW.venta_id;

        -- Si el monto pagado cubre el total de la venta, ajustar el balance del cliente
        IF (SELECT monto_pagado FROM ventas WHERE id = NEW.venta_id) >= 
           (SELECT total FROM ventas WHERE id = NEW.venta_id) THEN
            UPDATE ventas
            SET pagado = TRUE
            WHERE id = NEW.venta_id;

            UPDATE clientes
            SET balance = balance - 
                ((SELECT monto_pagado FROM ventas WHERE id = NEW.venta_id) - 
                 (SELECT total FROM ventas WHERE id = NEW.venta_id))
            WHERE id = NEW.cliente_id;
        END IF;
    END IF;
END//

DELIMITER ;