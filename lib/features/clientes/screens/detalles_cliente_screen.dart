import 'package:flutter/material.dart';

class DetallesClienteScreen extends StatelessWidget {
  final Map<String, String> cliente;

  const DetallesClienteScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${cliente['nombre']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${cliente['nombre']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Contacto: ${cliente['contacto']}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para editar cliente
                Navigator.pushNamed(context, '/registro_cliente', arguments: cliente);
              },
              child: const Text('Editar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}