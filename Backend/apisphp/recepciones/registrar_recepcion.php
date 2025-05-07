<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibieron los datos necesarios
if (isset($_POST['proveedor_id']) && isset($_POST['fecha']) && isset($_POST['cantidad_total'])) {
    $proveedor_id = $conexion->real_escape_string($_POST['proveedor_id']);
    $fecha = $conexion->real_escape_string($_POST['fecha']);
    $cantidad_total = $conexion->real_escape_string($_POST['cantidad_total']);

    // Preparar la consulta SQL para registrar una nueva recepción
    $sql = "INSERT INTO ma_recepciones (proveedor_id, fecha, cantidad_total) VALUES ('$proveedor_id', '$fecha', '$cantidad_total')";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Recepción registrada exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar la recepción: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Faltan datos requeridos (proveedor_id, fecha, cantidad_total)."]);
}

// Cerrar la conexión
$conexion->close();
?>