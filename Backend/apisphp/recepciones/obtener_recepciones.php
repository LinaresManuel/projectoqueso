<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Consulta para obtener la lista de recepciones
$sql = "SELECT * FROM vista_lista_recepciones";
$result = $conexion->query($sql);

if ($result->num_rows > 0) {
    $recepciones = [];
    while ($row = $result->fetch_assoc()) {
        $recepciones[] = $row;
    }
    echo json_encode(["success" => true, "data" => $recepciones]);
} else {
    echo json_encode(["success" => false, "message" => "No se encontraron recepciones."]);
}

// Cerrar la conexión
$conexion->close();
?>