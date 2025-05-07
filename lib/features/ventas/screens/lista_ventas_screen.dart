import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/venta_controller.dart';
import '../../../data/models/venta_model.dart';
import '../widgets/venta_list_tile.dart';
import 'package:intl/intl.dart';

class ListaVentasScreen extends StatelessWidget {
  const ListaVentasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ventaController = Provider.of<VentaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ventas'),
      ),
      body: FutureBuilder<List<Venta>>(
        future: ventaController.fetchVentas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay ventas registradas.'));
          } else {
            final ventas = snapshot.data!;
            return ListView.builder(
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                final venta = ventas[index];
                return VentaListTile(
                  titulo: 'Venta ID: ${venta.id}',
                  subtitulo: 'Fecha: ${venta.fecha.toLocal().toString().split(' ')[0]}',
                  onTap: () {
                    Navigator.pushNamed(context, '/detalles_venta', arguments: venta);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registro_venta');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}