<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener todas las ventas
$sql = "SELECT v.id AS venta_id, c.nombre AS cliente, l.id AS lote_id, v.cantidad, v.precio_unitario, v.total, v.monto_pagado, v.pagado, v.fecha FROM ma_ventas v JOIN ma_clientes c ON v.cliente_id = c.id JOIN ma_lotes l ON v.lote_id = l.id";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $ventas = [];
    while ($row = $result->fetch_assoc()) {
        $ventas[] = $row;
    }
    echo json_encode(["success" => true, "data" => $ventas]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron ventas."]);
}

// Cerrar la conexión
$conexion->close();
?>