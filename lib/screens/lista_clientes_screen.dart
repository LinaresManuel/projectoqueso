import 'package:flutter/material.dart';
import 'detalles_cliente_modal.dart';

import '../main.dart'; // Importa el Drawer

class ListaClientesScreen extends StatelessWidget {
  const ListaClientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clientes = [
      {"nombre": "María González", "balance": -50.0},
      {"nombre": "Juan Pérez", "balance": 0.0},
      {"nombre": "Ana López", "balance": 100.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Clientes"),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), // Agrega el Drawer aquí
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          final balance = cliente["balance"] as double;
          final color =
              balance < 0
                  ? Colors.red
                  : balance == 0
                  ? Colors.amber
                  : Colors.green;

          return ListTile(
            title: Text(cliente["nombre"] as String),
            subtitle: Text("Balance: \$${balance.toStringAsFixed(2)}"),
            trailing: Icon(Icons.circle, color: color),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetallesClienteModal(cliente: cliente),
              );
            },
          );
        },
      ),
    );
  }
}
