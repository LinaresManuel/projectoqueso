<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener el resumen del inventario
$sql = "SELECT * FROM vista_resumen_inventario";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $resumen_inventario = [];
    while ($row = $result->fetch_assoc()) {
        $resumen_inventario[] = $row;
    }
    echo json_encode(["success" => true, "data" => $resumen_inventario]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron datos del inventario."]);
}

// Cerrar la conexión
$conexion->close();
?>