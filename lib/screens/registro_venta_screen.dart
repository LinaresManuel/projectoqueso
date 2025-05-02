import 'package:flutter/material.dart';
import '../main.dart'; // Importa el Drawer

class RegistroVentaScreen extends StatelessWidget {
  const RegistroVentaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Venta"),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), // Agrega el Drawer aquí
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Cliente"),
              items: const [
                DropdownMenuItem(value: "1", child: Text("María González")),
                DropdownMenuItem(value: "2", child: Text("Juan Pérez")),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: isMobile ? 8 : 16), // Espaciado dinámico
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Tipo de Queso"),
              items: const [
                DropdownMenuItem(value: "fresco", child: Text("Queso Fresco")),
                DropdownMenuItem(value: "maduro", child: Text("Queso Maduro")),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: isMobile ? 8 : 16), // Espaciado dinámico
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Peso (kg)"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 16), // Espaciado dinámico
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Precio/kg (\$)",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 8 : 16), // Espaciado dinámico
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Método de Pago"),
              items: const [
                DropdownMenuItem(value: "efectivo", child: Text("Efectivo")),
                DropdownMenuItem(
                  value: "transferencia",
                  child: Text("Transferencia"),
                ),
                DropdownMenuItem(value: "credito", child: Text("Crédito")),
              ],
              onChanged: (value) {},
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                minimumSize: Size(
                  double.infinity,
                  isMobile ? 40 : 50,
                ), // Altura dinámica
              ),
              child: const Text("Registrar Venta"),
            ),
          ],
        ),
      ),
    );
  }
}
