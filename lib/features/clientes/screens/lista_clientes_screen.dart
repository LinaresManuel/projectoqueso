import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cliente_controller.dart';
import '../widgets/cliente_list_tile.dart';

class ListaClientesScreen extends StatelessWidget {
  const ListaClientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteController = Provider.of<ClienteController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: FutureBuilder(
        future: clienteController.fetchClientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (clienteController.clientes.isEmpty) {
            return const Center(child: Text('No hay clientes registrados.'));
          } else {
            return ListView.builder(
              itemCount: clienteController.clientes.length,
              itemBuilder: (context, index) {
                final cliente = clienteController.clientes[index];
                return ClienteListTile(
                  nombre: cliente['nombre']!,
                  contacto: cliente['contacto']!,
                  onTap: () {
                    Navigator.pushNamed(context, '/detalles_cliente', arguments: cliente);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registro_cliente');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}