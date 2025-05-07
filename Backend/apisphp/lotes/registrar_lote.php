<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibieron los datos necesarios
if (isset($_POST['producto_id']) && isset($_POST['cantidad_total']) && isset($_POST['peso_comercial'])) {
    $producto_id = $conexion->real_escape_string($_POST['producto_id']);
    $cantidad_total = $conexion->real_escape_string($_POST['cantidad_total']);
    $peso_comercial = $conexion->real_escape_string($_POST['peso_comercial']);

    // Preparar la consulta SQL para registrar un nuevo lote
    $sql = "INSERT INTO ma_lotes (producto_id, cantidad_total, peso_comercial) VALUES ('$producto_id', '$cantidad_total', '$peso_comercial')";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Lote registrado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar el lote: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Faltan datos requeridos (producto_id, cantidad_total, peso_comercial)."]);
}

// Cerrar la conexión
$conexion->close();
?>