import 'config.dart';

class ApiEndpoints {
  static const String registrarCliente = "$baseUrl/clientes/registrar_cliente.php";
  static const String obtenerClientes = "$baseUrl/clientes/obtener_clientes.php";
  static const String historialVentasCliente = "$baseUrl/clientes/historial_ventas_cliente.php";
  static const String historialPagosCliente = "$baseUrl/clientes/historial_pagos_cliente.php";
  static const String clientesEndeudados = "$baseUrl/clientes/clientes_endeudados.php";
  static const String resumenVentasCliente = "$baseUrl/inventario/resumen_ventas_cliente.php";
  static const String resumenInventario = "$baseUrl/inventario/resumen_inventario.php";
  static const String detallesLote = "$baseUrl/lotes/detalles_lote.php";
  static const String obtenerLotes = "$baseUrl/lotes/obtener_lotes.php";
  static const String historialIngresosLote = "$baseUrl/lotes/historial_ingresos_lote.php";
  static const String registrarLote = "$baseUrl/lotes/registrar_lote.php";
  static const String eliminarLote = "$baseUrl/lotes/eliminar_lote.php";
  static const String detallesRecepcion = "$baseUrl/recepciones/detalles_recepcion.php";
  static const String obtenerRecepciones = "$baseUrl/recepciones/obtener_recepciones.php";
  static const String registrarRecepcion = "$baseUrl/recepciones/registrar_recepcion.php";
  static const String eliminarRecepcion = "$baseUrl/recepciones/eliminar_recepcion.php";
  static const String ventasPendientes = "$baseUrl/ventas/ventas_pendientes.php";
  static const String registrarVenta = "$baseUrl/ventas/registrar_venta.php";
  static const String obtenerVentas = "$baseUrl/ventas/obtener_ventas.php";
  static const String actualizarCliente = "$baseUrl/clientes/actualizar_cliente.php";
  static const String eliminarCliente = "$baseUrl/clientes/eliminar_cliente.php";
  static const String eliminarVenta = "$baseUrl/ventas/eliminar_venta.php";
  static const String registrarProducto = "$baseUrl/productos/registrar_producto.php";
  static const String obtenerProductos = "$baseUrl/productos/obtener_productos.php";
  static const String actualizarProducto = "$baseUrl/productos/actualizar_producto.php";
  static const String eliminarProducto = "$baseUrl/productos/eliminar_producto.php";
}