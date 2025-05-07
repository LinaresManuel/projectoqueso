<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID de la recepción
if (isset($_GET['recepcion_id'])) {
    $recepcion_id = $conexion->real_escape_string($_GET['recepcion_id']);

    // Consulta para obtener los detalles de una recepción específica
    $sql = "SELECT i.id AS ingreso_id, pr.nombre AS producto, i.cantidad, i.detalles FROM ma_ingresos_productos i JOIN ma_productos pr ON i.producto_id = pr.id WHERE i.recepcion_id = '$recepcion_id'";
    $result = $conexion->query($sql);

    if ($result->num_rows > 0) {
        $detalles_recepcion = [];
        while ($row = $result->fetch_assoc()) {
            $detalles_recepcion[] = $row;
        }
        echo json_encode(["success" => true, "data" => $detalles_recepcion]);
    } else {
        echo json_encode(["success" => false, "message" => "No se encontraron detalles para esta recepción."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID de la recepción."]);
}

// Cerrar la conexión
$conexion->close();
?>