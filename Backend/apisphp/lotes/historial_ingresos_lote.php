<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID del lote
if (isset($_GET['lote_id'])) {
    $lote_id = $conexion->real_escape_string($_GET['lote_id']);

    // Consulta para obtener el historial de ingresos de un lote
    $sql = "SELECT i.id AS ingreso_id, i.cantidad, i.detalles, i.fecha_ingreso FROM ma_ingresos_productos i WHERE i.lote_id = '$lote_id'";
    $result = $conexion->query($sql);

    if ($result->num_rows > 0) {
        $historial_ingresos = [];
        while ($row = $result->fetch_assoc()) {
            $historial_ingresos[] = $row;
        }
        echo json_encode(["success" => true, "data" => $historial_ingresos]);
    } else {
        echo json_encode(["success" => false, "message" => "No se encontraron ingresos para este lote."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID del lote."]);
}

// Cerrar la conexión
$conexion->close();
?>