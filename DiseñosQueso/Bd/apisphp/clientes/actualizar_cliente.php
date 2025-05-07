<?php
require_once '../conexion.php';

$response = ["success" => false, "message" => ""];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'] ?? '';
    $nombre = $_POST['nombre'] ?? '';
    $contacto = $_POST['contacto'] ?? '';

    if (empty($id) || empty($nombre) || empty($contacto)) {
        $response['message'] = 'Todos los campos son obligatorios';
    } else {
        $query = "UPDATE clientes SET nombre = ?, contacto = ? WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param('ssi', $nombre, $contacto, $id);

        if ($stmt->execute()) {
            $response['success'] = true;
            $response['message'] = 'Cliente actualizado correctamente';
        } else {
            $response['message'] = 'Error al actualizar el cliente';
        }

        $stmt->close();
    }
} else {
    $response['message'] = 'Método no permitido';
}

header('Content-Type: application/json');
echo json_encode($response);
?>