import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/lote_controller.dart';
import '../../../data/models/lote_model.dart';
import '../widgets/lote_list_tile.dart';

class ListaLotesScreen extends StatelessWidget {
  const ListaLotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loteController = Provider.of<LoteController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Lotes'),
      ),
      body: FutureBuilder<List<Lote>>(
        future: loteController.fetchLotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay lotes registrados.'));
          } else {
            final lotes = snapshot.data!;
            return ListView.builder(
              itemCount: lotes.length,
              itemBuilder: (context, index) {
                final lote = lotes[index];
                return LoteListTile(
                  titulo: lote.producto,
                  subtitulo: 'Cantidad: ${lote.cantidadDisponible}',
                  onTap: () {
                    Navigator.pushNamed(context, '/detalles_lote', arguments: lote);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registro_lote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}