<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID de la recepción
if (isset($_POST['id'])) {
    $id = $conexion->real_escape_string($_POST['id']);

    // Preparar la consulta SQL para eliminar la recepción
    $sql = "DELETE FROM ma_recepciones WHERE id = '$id'";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Recepción eliminada exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al eliminar la recepción: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID de la recepción."]);
}

// Cerrar la conexión
$conexion->close();
?>