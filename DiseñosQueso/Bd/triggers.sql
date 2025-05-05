-- Triggers para gestión automática
DELIMITER //

-- Actualiza balance al insertar venta
CREATE TRIGGER after_venta_insert
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    UPDATE clientes 
    SET balance = balance - NEW.saldo_pendiente,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.cliente_id;
    
    -- Actualiza inventario (convierte kg/lb a gramos)
    UPDATE lotes 
    SET peso_comercial = peso_comercial - (
        CASE 
            WHEN NEW.unidad_medida = 'kg' THEN NEW.cantidad * 1000
            WHEN NEW.unidad_medida = 'lb' THEN NEW.cantidad * 453.592
        END
    ),
    updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.lote_id;
END//

-- Actualiza balance al modificar venta
CREATE TRIGGER after_venta_update
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
    -- Revertir balance anterior
    UPDATE clientes 
    SET balance = balance + OLD.saldo_pendiente,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.cliente_id;
    
    -- Aplicar nuevo balance
    UPDATE clientes 
    SET balance = balance - NEW.saldo_pendiente,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.cliente_id;
    
    -- Ajustar inventario si cambia la cantidad
    IF OLD.cantidad != NEW.cantidad OR OLD.unidad_medida != NEW.unidad_medida THEN
        -- Revertir cantidad anterior
        UPDATE lotes 
        SET peso_comercial = peso_comercial + (
            CASE 
                WHEN OLD.unidad_medida = 'kg' THEN OLD.cantidad * 1000
                WHEN OLD.unidad_medida = 'lb' THEN OLD.cantidad * 453.592
            END
        ),
        updated_at = CURRENT_TIMESTAMP
        WHERE id = OLD.lote_id;
        
        -- Aplicar nueva cantidad
        UPDATE lotes 
        SET peso_comercial = peso_comercial - (
            CASE 
                WHEN NEW.unidad_medida = 'kg' THEN NEW.cantidad * 1000
                WHEN NEW.unidad_medida = 'lb' THEN NEW.cantidad * 453.592
            END
        ),
        updated_at = CURRENT_TIMESTAMP
        WHERE id = NEW.lote_id;
    END IF;
END//

-- Actualiza balance al registrar pago
CREATE TRIGGER after_pago_insert
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    UPDATE clientes 
    SET balance = balance + NEW.monto,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.cliente_id;
    
    -- Si el pago está vinculado a una venta, actualiza saldo pendiente
    IF NEW.venta_id IS NOT NULL THEN
        UPDATE ventas 
        SET pagado = pagado + NEW.monto,
            updated_at = CURRENT_TIMESTAMP
        WHERE id = NEW.venta_id;
    END IF;
END//

DELIMITER ;

-- Vistas para reportes
CREATE VIEW view_deudores AS
SELECT 
    c.id, 
    c.nombre, 
    c.telefono, 
    c.balance AS deuda_total,
    COUNT(v.id) AS ventas_pendientes,
    SUM(v.saldo_pendiente) AS saldo_confirmado
FROM clientes c
LEFT JOIN ventas v ON c.id = v.cliente_id AND v.saldo_pendiente > 0
WHERE c.balance < 0
GROUP BY c.id;

CREATE VIEW view_inventario AS
SELECT 
    l.id,
    l.peso_comercial / 1000 AS peso_disponible_kg,
    (SELECT SUM(
        CASE 
            WHEN v.unidad_medida = 'kg' THEN v.cantidad * 1000
            WHEN v.unidad_medida = 'lb' THEN v.cantidad * 453.592
        END / 1000
    ) FROM ventas v WHERE v.lote_id = l.id) AS cantidad_vendida_kg,
    l.peso_comercial / 1000 - IFNULL((
        SELECT SUM(
            CASE 
                WHEN v.unidad_medida = 'kg' THEN v.cantidad
                WHEN v.unidad_medida = 'lb' THEN v.cantidad * 0.453592
            END
        ) 
        FROM ventas v 
        WHERE v.lote_id = l.id
    ), 0) AS saldo_actual_kg
FROM lotes l;