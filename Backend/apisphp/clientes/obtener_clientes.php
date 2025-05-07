<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener todos los clientes
$sql = "SELECT * FROM ma_clientes";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $clientes = [];
    while ($row = $result->fetch_assoc()) {
        $clientes[] = $row;
    }
    echo json_encode(["success" => true, "data" => $clientes]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron clientes."]);
}

// Cerrar la conexión
$conexion->close();
?>