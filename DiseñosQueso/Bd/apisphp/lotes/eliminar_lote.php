<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID del lote
if (isset($_POST['id'])) {
    $id = $conexion->real_escape_string($_POST['id']);

    // Preparar la consulta SQL para eliminar el lote
    $sql = "DELETE FROM ma_lotes WHERE id = '$id'";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Lote eliminado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al eliminar el lote: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID del lote."]);
}

// Cerrar la conexión
$conexion->close();
?>