import 'package:flutter/material.dart';
import '../../../data/models/lote_model.dart';

class DetallesLoteScreen extends StatelessWidget {
  final Lote lote;

  const DetallesLoteScreen({Key? key, required this.lote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Lote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Producto: ${lote.producto}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Cantidad Total: ${lote.cantidadTotal}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Cantidad Disponible: ${lote.cantidadDisponible}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Peso Comercial: ${lote.pesoComercial}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para editar el lote
              },
              child: Text('Editar Lote'),
            ),
          ],
        ),
      ),
    );
  }
}