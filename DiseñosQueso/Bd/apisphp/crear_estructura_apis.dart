import 'dart:io';

void main() {
  final baseDir = 'c:\\Users\\APRENDIZ SENA\\Desktop\\ADSO\\Flutteros\\queso\\DiseñosQueso\\Bd\\apisphp';

  // Subcarpetas y archivos
  final structure = {
    'clientes': [
      'obtener_clientes.php',
      'registrar_cliente.php',
      'historial_ventas_cliente.php',
      'historial_pagos_cliente.php',
      'clientes_endeudados.php',
    ],
    'ventas': [
      'obtener_ventas.php',
      'registrar_venta.php',
      'ventas_pendientes.php',
    ],
    'lotes': [
      'obtener_lotes.php',
      'detalles_lote.php',
      'historial_ingresos_lote.php',
    ],
    'recepciones': [
      'obtener_recepciones.php',
      'detalles_recepcion.php',
    ],
    'inventario': [
      'resumen_inventario.php',
      'resumen_ventas_cliente.php',
    ],
  };

  // Crear subcarpetas y archivos
  structure.forEach((folder, files) {
    final folderPath = '$baseDir\\$folder';
    Directory(folderPath).createSync(recursive: true);
    print('Carpeta creada: $folderPath');

    for (var file in files) {
      final filePath = '$folderPath\\$file';
      File(filePath).createSync();
      print('Archivo creado: $filePath');
    }
  });

  // Crear archivo de conexión
  final conexionFile = File('$baseDir\\conexion.php');
  conexionFile.createSync();
  print('Archivo creado: ${conexionFile.path}');

  print('Estructura de APIs creada exitosamente.');
}