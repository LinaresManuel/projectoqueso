<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID del lote
if (isset($_GET['lote_id'])) {
    $lote_id = $conexion->real_escape_string($_GET['lote_id']);

    // Consulta para obtener los detalles de un lote específico
    $sql = "SELECT l.id AS lote_id, p.nombre AS producto, l.cantidad_total, l.peso_comercial, l.cantidad_disponible, l.sobrante FROM ma_lotes l JOIN ma_productos p ON l.producto_id = p.id WHERE l.id = '$lote_id'";
    $result = $conexion->query($sql);

    if ($result->num_rows > 0) {
        $detalles_lote = $result->fetch_assoc();
        echo json_encode(["success" => true, "data" => $detalles_lote]);
    } else {
        echo json_encode(["success" => false, "message" => "No se encontraron detalles para este lote."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID del lote."]);
}

// Cerrar la conexión
$conexion->close();
?>