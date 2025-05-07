import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/venta_model.dart';

class DetallesVentaScreen extends StatelessWidget {
  final Venta venta;

  const DetallesVentaScreen({super.key, required this.venta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lote ID: ${venta.loteId}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Cantidad: ${venta.cantidad}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Precio Unitario: ${venta.precioUnitario}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Total: ${venta.total}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Fecha: ${DateFormat('dd/MM/yyyy').format(venta.fecha)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para eliminar o editar la venta
              },
              child: const Text('Editar Venta'),
            ),
          ],
        ),
      ),
    );
  }
}