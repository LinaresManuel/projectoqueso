<?php
include_once '../cors.php';
include_once '../conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $unidad = $conexion->real_escape_string($_POST['unidad']);

    $sql = "INSERT INTO ma_productos (nombre, unidad) VALUES ('$nombre', '$unidad')";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Producto registrado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar el producto: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Método no permitido"]);
}

$conexion->close();
?>