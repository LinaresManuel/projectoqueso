<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener la lista de lotes activos
$sql = "SELECT * FROM vista_lotes_activos";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $lotes = [];
    while ($row = $result->fetch_assoc()) {
        $lotes[] = $row;
    }
    echo json_encode(["success" => true, "data" => $lotes]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron lotes activos."]);
}

// Cerrar la conexión
$conexion->close();
?>