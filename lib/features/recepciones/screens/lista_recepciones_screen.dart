import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/recepcion_controller.dart';
import '../../../data/models/recepcion_model.dart';
import '../widgets/recepcion_list_tile.dart';

class ListaRecepcionesScreen extends StatelessWidget {
  const ListaRecepcionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recepcionController = Provider.of<RecepcionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Recepciones'),
      ),
      body: FutureBuilder<List<Recepcion>>(
        future: recepcionController.fetchRecepciones(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay recepciones registradas.'));
          } else {
            final recepciones = snapshot.data!;
            return ListView.builder(
              itemCount: recepciones.length,
              itemBuilder: (context, index) {
                final recepcion = recepciones[index];
                return RecepcionListTile(
                  titulo: recepcion.proveedor,
                  subtitulo: 'Fecha: ${recepcion.fecha.toLocal().toString().split(' ')[0]}',
                  onTap: () {
                    Navigator.pushNamed(context, '/detalles_recepcion', arguments: recepcion);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registro_recepcion');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}