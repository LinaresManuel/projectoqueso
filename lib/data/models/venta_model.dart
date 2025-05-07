class Venta {
  final String id;
  final String clienteId;
  final String loteId;
  final double cantidad;
  final double precioUnitario;
  final double total;
  final double montoPagado;
  final bool pagado;
  final DateTime fecha;

  Venta({
    required this.id,
    required this.clienteId,
    required this.loteId,
    required this.cantidad,
    required this.precioUnitario,
    required this.total,
    required this.montoPagado,
    required this.pagado,
    required this.fecha,
  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: json['id'],
      clienteId: json['cliente_id'],
      loteId: json['lote_id'],
      cantidad: (json['cantidad'] as num).toDouble(),
      precioUnitario: (json['precio_unitario'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      montoPagado: (json['monto_pagado'] as num).toDouble(),
      pagado: json['pagado'] == 1,
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente_id': clienteId,
      'lote_id': loteId,
      'cantidad': cantidad,
      'precio_unitario': precioUnitario,
      'total': total,
      'monto_pagado': montoPagado,
      'pagado': pagado ? 1 : 0,
      'fecha': fecha.toIso8601String(),
    };
  }
}