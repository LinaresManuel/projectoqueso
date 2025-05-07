<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener las ventas pendientes
$sql = "SELECT * FROM ma_ventas WHERE pagado = FALSE";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $ventas_pendientes = [];
    while ($row = $result->fetch_assoc()) {
        $ventas_pendientes[] = $row;
    }
    echo json_encode(["success" => true, "data" => $ventas_pendientes]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron ventas pendientes."]);
}

// Cerrar la conexión
$conexion->close();
?>