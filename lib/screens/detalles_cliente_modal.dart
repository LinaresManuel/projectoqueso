import 'package:flutter/material.dart';

class DetallesClienteModal extends StatelessWidget {
  final Map<String, dynamic> cliente;

  const DetallesClienteModal({required this.cliente, super.key});

  @override
  Widget build(BuildContext context) {
    final compras = [
      {
        "fecha": "2025-04-01",
        "producto": "Queso Fresco",
        "cantidad": 2,
        "total": 40.0,
      },
      {
        "fecha": "2025-04-15",
        "producto": "Queso Maduro",
        "cantidad": 1,
        "total": 30.0,
      },
    ];

    final pagos = [
      {"fecha": "2025-04-05", "metodo": "Efectivo", "monto": 20.0},
      {"fecha": "2025-04-20", "metodo": "Transferencia", "monto": 50.0},
    ];

    return AlertDialog(
      title: Text(cliente["nombre"] as String),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Teléfono: 123-456-7890"),
            Text("Dirección: Calle Falsa 123"),
            Text(
              "Balance: \$${(cliente["balance"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                color:
                    (cliente["balance"] as double) < 0
                        ? Colors.red
                        : Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Historial de Compras",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...compras.map(
              (compra) => ListTile(
                title: Text("${compra["producto"]} (${compra["cantidad"]} kg)"),
                subtitle: Text("Fecha: ${compra["fecha"]}"),
                trailing: Text("\$${compra["total"]}"),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Pagos Recientes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...pagos.map(
              (pago) => ListTile(
                title: Text("Método: ${pago["metodo"]}"),
                subtitle: Text("Fecha: ${pago["fecha"]}"),
                trailing: Text("\$${pago["monto"]}"),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cerrar"),
        ),
      ],
    );
  }
}
