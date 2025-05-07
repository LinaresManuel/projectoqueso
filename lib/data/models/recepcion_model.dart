class Recepcion {
  final int id;
  final int proveedorId;
  final DateTime fecha;
  final String? observaciones;
  final String proveedor; // Nuevo campo para el nombre del proveedor
  final double cantidadTotal; // Nuevo campo para la cantidad total

  Recepcion({
    required this.id,
    required this.proveedorId,
    required this.fecha,
    required this.proveedor, // Inicialización del nuevo campo
    required this.cantidadTotal, // Inicialización del nuevo campo
    this.observaciones,
  });

  // Método para convertir un mapa JSON a un objeto Recepcion
  factory Recepcion.fromJson(Map<String, dynamic> json) {
    return Recepcion(
      id: json['id'],
      proveedorId: json['proveedor_id'],
      fecha: DateTime.parse(json['fecha']),
      proveedor: json['proveedor'], // Asignación del nuevo campo
      cantidadTotal: (json['cantidad_total'] as num).toDouble(), // Asignación del nuevo campo
      observaciones: json['observaciones'],
    );
  }

  // Método para convertir un objeto Recepcion a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'proveedor_id': proveedorId,
      'fecha': fecha.toIso8601String(),
      'proveedor': proveedor, // Serialización del nuevo campo
      'cantidad_total': cantidadTotal, // Serialización del nuevo campo
      'observaciones': observaciones,
    };
  }
}