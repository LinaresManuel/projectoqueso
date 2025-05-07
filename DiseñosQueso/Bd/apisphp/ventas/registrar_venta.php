<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibieron los datos necesarios
if (isset($_POST['cliente_id']) && isset($_POST['lote_id']) && isset($_POST['cantidad']) && isset($_POST['precio_unitario'])) {
    $cliente_id = $conexion->real_escape_string($_POST['cliente_id']);
    $lote_id = $conexion->real_escape_string($_POST['lote_id']);
    $cantidad = $conexion->real_escape_string($_POST['cantidad']);
    $precio_unitario = $conexion->real_escape_string($_POST['precio_unitario']);

    // Preparar la consulta SQL para registrar una nueva venta
    $sql = "INSERT INTO ma_ventas (cliente_id, lote_id, cantidad, precio_unitario) VALUES ('$cliente_id', '$lote_id', '$cantidad', '$precio_unitario')";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Venta registrada exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar la venta: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Faltan datos requeridos (cliente_id, lote_id, cantidad, precio_unitario)."]);
}

// Cerrar la conexión
$conexion->close();
?>