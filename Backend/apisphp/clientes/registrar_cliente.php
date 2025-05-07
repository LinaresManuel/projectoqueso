<?php
include_once '../cors.php';
// Incluir el archivo de conexión
include_once '../conexion.php';

// Verificar si se recibieron los datos necesarios
if (isset($_POST['nombre']) && isset($_POST['contacto'])) {
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $contacto = $conexion->real_escape_string($_POST['contacto']);

    // Preparar la consulta SQL para insertar un nuevo cliente
    $sql = "INSERT INTO ma_clientes (nombre, contacto) VALUES ('$nombre', '$contacto')";

    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Cliente registrado exitosamente."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar el cliente: " . $conexion->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Faltan datos requeridos (nombre, contacto)."]);
}

// Cerrar la conexión
$conexion->close();
?>