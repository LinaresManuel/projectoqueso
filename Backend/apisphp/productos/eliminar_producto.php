<?php
include_once '../cors.php';
include_once '../conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $conexion->real_escape_string($_POST['id']);

    $sql = "DELETE FROM ma_productos WHERE id = '$id'";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Producto eliminado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al eliminar el producto: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Método no permitido"]);
}

$conexion->close();
?>