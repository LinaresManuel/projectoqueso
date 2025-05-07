<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID del cliente
if (isset($_GET['cliente_id'])) {
    $cliente_id = $conexion->real_escape_string($_GET['cliente_id']);

    // Consulta para obtener el historial de pagos del cliente
    $sql = "SELECT * FROM vista_historial_pagos WHERE cliente_id = '$cliente_id'";
    $result = $conexion->query($sql);

    if ($result->num_rows > 0) {
        $pagos = [];
        while ($row = $result->fetch_assoc()) {
            $pagos[] = $row;
        }
        echo json_encode(["success" => true, "data" => $pagos]);
    } else {
        echo json_encode(["success" => false, "message" => "No se encontraron pagos para este cliente."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID del cliente."]);
}

// Cerrar la conexión
$conexion->close();
?>