<?php
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibió el ID del cliente
if (isset($_GET['cliente_id'])) {
    $cliente_id = $conexion->real_escape_string($_GET['cliente_id']);

    // Consulta para obtener el historial de ventas del cliente
    $sql = "SELECT * FROM vista_historial_ventas WHERE cliente_id = '$cliente_id'";
    $result = $conexion->query($sql);

    if ($result->num_rows > 0) {
        $ventas = [];
        while ($row = $result->fetch_assoc()) {
            $ventas[] = $row;
        }
        echo json_encode(["success" => true, "data" => $ventas]);
    } else {
        echo json_encode(["success" => false, "message" => "No se encontraron ventas para este cliente."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Falta el ID del cliente."]);
}

// Cerrar la conexión
$conexion->close();
?>