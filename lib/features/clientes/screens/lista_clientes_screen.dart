import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import '../controllers/cliente_controller.dart';
import '../widgets/cliente_list_tile.dart';

class ListaClientesScreen extends StatefulWidget {
  const ListaClientesScreen({Key? key}) : super(key: key);

  @override
  _ListaClientesScreenState createState() => _ListaClientesScreenState();
}

class _ListaClientesScreenState extends State<ListaClientesScreen> {
  @override
  void initState() {
    super.initState();
    // Usar addPostFrameCallback para asegurar que el contexto está listo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final clienteController = Provider.of<ClienteController>(context, listen: false);
      clienteController.fetchClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clienteController = Provider.of<ClienteController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              log('Solicitando actualización manual');
              clienteController.fetchClientes();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          log('Pull to refresh activado');
          await clienteController.fetchClientes();
        },
        child: Builder(
          builder: (context) {
            log('Estado actual - isLoading: ${clienteController.isLoading}, error: ${clienteController.errorMessage}, clientes: ${clienteController.clientes.length}');
            
            if (clienteController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (clienteController.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${clienteController.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        log('Intentando reintentar');
                        clienteController.fetchClientes();
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }
            
            if (clienteController.clientes.isEmpty) {
              return const Center(
                child: Text(
                  'No hay clientes registrados.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            
            return ListView.builder(
              itemCount: clienteController.clientes.length,
              itemBuilder: (context, index) {
                final cliente = clienteController.clientes[index];
                return ClienteListTile(
                  nombre: cliente.nombre,
                  contacto: cliente.contacto,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detalles_cliente',
                      arguments: cliente,  // Pasar el objeto Cliente directamente
                    );
                  },
                );
              },
            );
          },
        ),
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