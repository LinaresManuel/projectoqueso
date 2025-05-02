import 'package:flutter/material.dart';
import '../main.dart'; // Importa el Drawer

class ResumenDiarioScreen extends StatelessWidget {
  const ResumenDiarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumen = {
      "totalVentas": 200.0,
      "metodosPago": {
        "Efectivo": 100.0,
        "Transferencia": 50.0,
        "Crédito": 50.0,
      },
      "tiposQueso": {"Fresco": 120.0, "Maduro": 80.0},
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen Diario"),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), // Agrega el Drawer aquí
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total de Ventas
            Text(
              "Total Ventas: \$${resumen["totalVentas"]}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Desglose por Método de Pago
            const Text(
              "Desglose por Método de Pago",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...(resumen["metodosPago"] as Map<String, double>).entries.map(
              (entry) => ListTile(
                title: Text(entry.key),
                trailing: Text("\$${entry.value.toStringAsFixed(2)}"),
              ),
            ),
            const SizedBox(height: 16),

            // Desglose por Tipo de Queso
            const Text(
              "Desglose por Tipo de Queso",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...(resumen["tiposQueso"] as Map<String, double>).entries.map(
              (entry) => ListTile(
                title: Text(entry.key),
                trailing: Text("\$${entry.value.toStringAsFixed(2)}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
