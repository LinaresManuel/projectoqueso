<?php
// Archivo de conexión a la base de datos

$host = "localhost";
$user = "ducjinsp_sena";
$password = "senaguainia2025";
$dbname = "ducjinsp_demo";

// Crear conexión
$conexion = new mysqli($host, $user, $password, $dbname);

// Verificar conexión
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
} else {
    echo "Conexión exitosa a la base de datos.";
}

// Establecer el conjunto de caracteres a utf8
$conexion->set_charset("utf8");

?>