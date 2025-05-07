<?php
include_once '../cors.php';
include '../conexion.php'; // Ajuste de ruta para la conexión a la base de datos.

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    if (!empty($id)) {
        $query = "DELETE FROM ma_ventas WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Venta eliminada correctamente.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Error al eliminar la venta.']);
        }

        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'ID de venta no proporcionado.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Método no permitido.']);
}

$conn->close();
?>