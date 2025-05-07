<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener los clientes endeudados
$sql = "SELECT * FROM vista_clientes_endeudados";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $clientes_endeudados = [];
    while ($row = $result->fetch_assoc()) {
        $clientes_endeudados[] = $row;
    }
    echo json_encode(["success" => true, "data" => $clientes_endeudados]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron clientes endeudados."]);
}

// Cerrar la conexión
$conexion->close();
?>