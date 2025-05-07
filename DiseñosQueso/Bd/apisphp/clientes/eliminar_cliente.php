<?php
require_once '../conexion.php';

$response = ["success" => false, "message" => ""];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'] ?? '';

    if (empty($id)) {
        $response['message'] = 'El ID del cliente es obligatorio';
    } else {
        $query = "DELETE FROM clientes WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param('i', $id);

        if ($stmt->execute()) {
            $response['success'] = true;
            $response['message'] = 'Cliente eliminado correctamente';
        } else {
            $response['message'] = 'Error al eliminar el cliente';
        }

        $stmt->close();
    }
} else {
    $response['message'] = 'Método no permitido';
}

header('Content-Type: application/json');
echo json_encode($response);
?>