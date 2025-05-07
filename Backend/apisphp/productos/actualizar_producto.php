<?php
include_once '../cors.php';
include_once '../conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $conexion->real_escape_string($_POST['id']);
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $unidad = $conexion->real_escape_string($_POST['unidad']);

    $sql = "UPDATE ma_productos SET nombre = '$nombre', unidad = '$unidad' WHERE id = '$id'";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Producto actualizado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al actualizar el producto: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Método no permitido"]);
}

$conexion->close();
?>