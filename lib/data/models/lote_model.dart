class Lote {
  final int id;
  final int productoId;
  final double cantidadTotal;
  final double pesoComercial;
  final double cantidadDisponible;
  final double sobrante;
  final String producto; // Nuevo campo para el nombre del producto

  Lote({
    required this.id,
    required this.productoId,
    required this.cantidadTotal,
    required this.pesoComercial,
    required this.cantidadDisponible,
    required this.sobrante,
    required this.producto, // Inicialización del nuevo campo
  });

  // Método para convertir un mapa JSON a un objeto Lote
  factory Lote.fromJson(Map<String, dynamic> json) {
    return Lote(
      id: json['id'],
      productoId: json['producto_id'],
      cantidadTotal: (json['cantidad_total'] as num).toDouble(),
      pesoComercial: (json['peso_comercial'] as num).toDouble(),
      cantidadDisponible: (json['cantidad_disponible'] as num).toDouble(),
      sobrante: (json['sobrante'] as num).toDouble(),
      producto: json['producto'], // Asignación del nuevo campo
    );
  }

  // Método para convertir un objeto Lote a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'producto_id': productoId,
      'cantidad_total': cantidadTotal,
      'peso_comercial': pesoComercial,
      'cantidad_disponible': cantidadDisponible,
      'sobrante': sobrante,
      'producto': producto, // Serialización del nuevo campo
    };
  }
}