<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener el resumen de ventas por cliente
$sql = "SELECT * FROM vista_resumen_ventas_cliente";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $resumen_ventas = [];
    while ($row = $result->fetch_assoc()) {
        $resumen_ventas[] = $row;
    }
    echo json_encode(["success" => true, "data" => $resumen_ventas]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron datos de ventas por cliente."]);
}

// Cerrar la conexión
$conexion->close();
?>