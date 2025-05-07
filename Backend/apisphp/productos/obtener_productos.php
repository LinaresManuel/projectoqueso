<?php
include_once '../cors.php';
include_once '../conexion.php';

$sql = "SELECT * FROM ma_productos";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $productos = [];
    while ($row = $result->fetch_assoc()) {
        $productos[] = $row;
    }
    echo json_encode(["success" => true, "data" => $productos]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron productos."]);
}

$conexion->close();
?>