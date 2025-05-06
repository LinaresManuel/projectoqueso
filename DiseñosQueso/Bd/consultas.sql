-- Vistas para consultas frecuentes

-- Vista para clientes endeudados
CREATE OR REPLACE VIEW vista_clientes_endeudados AS
SELECT id, nombre, contacto, balance
FROM clientes
WHERE balance < 0;

-- Vista para historial de ventas de un cliente
CREATE OR REPLACE VIEW vista_historial_ventas AS
SELECT v.id AS venta_id, v.cliente_id, c.nombre AS cliente, v.fecha, v.cantidad, v.precio_unitario, 
       v.total, v.monto_pagado, v.pagado, l.producto_id
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN lotes l ON v.lote_id = l.id;

-- Vista para historial de pagos de un cliente
CREATE OR REPLACE VIEW vista_historial_pagos AS
SELECT p.id AS pago_id, p.cliente_id, c.nombre AS cliente, p.fecha, p.monto, p.venta_id
FROM pagos_clientes p
JOIN clientes c ON p.cliente_id = c.id;

-- Vista para lista de lotes activos
CREATE OR REPLACE VIEW vista_lotes_activos AS
SELECT l.id AS lote_id, p.nombre AS producto, l.cantidad_total, l.peso_comercial, 
       l.cantidad_disponible, l.sobrante
FROM lotes l
JOIN productos p ON l.producto_id = p.id;

-- Vista para lista de recepciones
CREATE OR REPLACE VIEW vista_lista_recepciones AS
SELECT r.id AS recepcion_id, r.fecha, pr.nombre AS proveedor, r.observaciones
FROM recepciones r
JOIN proveedores pr ON r.proveedor_id = pr.id;

-- Vista para resumen de inventario
CREATE OR REPLACE VIEW vista_resumen_inventario AS
SELECT p.nombre AS producto, SUM(l.cantidad_disponible) AS cantidad_disponible, 
       SUM(l.cantidad_vendida) AS cantidad_vendida
FROM lotes l
JOIN productos p ON l.producto_id = p.id
GROUP BY p.nombre;

-- Vista para resumen de ventas por cliente
CREATE OR REPLACE VIEW vista_resumen_ventas_cliente AS
SELECT c.nombre AS cliente, COUNT(v.id) AS total_ventas, SUM(v.total) AS monto_total
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.nombre;

-- Vista para resumen de pagos por cliente
CREATE OR REPLACE VIEW vista_resumen_pagos_cliente AS
SELECT c.nombre AS cliente, SUM(p.monto) AS total_pagado
FROM pagos_clientes p
JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.nombre;

-- Consultas específicas

-- Clientes endeudados
SELECT * FROM vista_clientes_endeudados;

-- Historial de ventas de un cliente
SELECT * FROM vista_historial_ventas WHERE cliente_id = ?;

-- Historial de pagos de un cliente
SELECT * FROM vista_historial_pagos WHERE cliente_id = ?;

-- Lista de lotes activos
SELECT * FROM vista_lotes_activos;

-- Detalles de un lote específico
SELECT l.id AS lote_id, p.nombre AS producto, l.cantidad_total, l.peso_comercial, 
       l.cantidad_disponible, l.sobrante
FROM lotes l
JOIN productos p ON l.producto_id = p.id
WHERE l.id = ?;

-- Historial de ingresos a un lote
SELECT i.id AS ingreso_id, i.cantidad, i.detalles, i.fecha_ingreso
FROM ingresos_productos i
WHERE i.lote_id = ?;

-- Lista de recepciones
SELECT * FROM vista_lista_recepciones;

-- Detalles de una recepción específica
SELECT i.id AS ingreso_id, pr.nombre AS producto, i.cantidad, i.detalles
FROM ingresos_productos i
JOIN productos pr ON i.producto_id = pr.id
WHERE i.recepcion_id = ?;

-- Resumen de inventario
SELECT * FROM vista_resumen_inventario;

-- Resumen de ventas por cliente
SELECT * FROM vista_resumen_ventas_cliente;

-- Resumen de pagos por cliente
SELECT * FROM vista_resumen_pagos_cliente;