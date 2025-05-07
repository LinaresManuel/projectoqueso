import 'package:flutter/material.dart';
import '../../../data/models/recepcion_model.dart';

class DetallesRecepcionScreen extends StatelessWidget {
  final Recepcion recepcion;

  const DetallesRecepcionScreen({Key? key, required this.recepcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Recepción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proveedor: ${recepcion.proveedor}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Fecha: ${recepcion.fecha}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Cantidad Total: ${recepcion.cantidadTotal}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para editar la recepción
              },
              child: Text('Editar Recepción'),
            ),
          ],
        ),
      ),
    );
  }
}