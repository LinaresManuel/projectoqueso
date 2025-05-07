import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cliente_controller.dart';
import '../../../data/models/cliente_model.dart';

class DetallesClienteScreen extends StatefulWidget {
  final Cliente cliente;  // Cambiado de Map<String, String> a Cliente

  const DetallesClienteScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  State<DetallesClienteScreen> createState() => _DetallesClienteScreenState();
}

class _DetallesClienteScreenState extends State<DetallesClienteScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${widget.cliente.nombre}'),  // Accediendo directamente a la propiedad
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context, 
                '/registro_cliente',
                arguments: widget.cliente,  // Pasando el objeto Cliente
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _mostrarDialogoConfirmacion();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balance pendiente: \$${widget.cliente.balance.toStringAsFixed(2)}',  // Formateando el balance
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTabButton('Información', 0),
                    ),
                    Expanded(
                      child: _buildTabButton('Compras', 1),
                    ),
                    Expanded(
                      child: _buildTabButton('Pagos', 2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildSelectedView(),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 2 
        ? FloatingActionButton(
            onPressed: () {
              _mostrarDialogoRegistroPago();
            },
            child: const Icon(Icons.add),
          )
        : null,
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Text(text),
    );
  }

  Widget _buildSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return _buildInformacionView();
      case 1:
        return _buildComprasView();
      case 2:
        return _buildPagosView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildInformacionView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre: ${widget.cliente.nombre}',  // Accediendo directamente a la propiedad
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Text(
            'Contacto: ${widget.cliente.contacto}',  // Accediendo directamente a la propiedad
            style: const TextStyle(fontSize: 16)
          ),
          const SizedBox(height: 8),
          Text(
            'Fecha de registro: ${widget.cliente.createdAt.toString().split('.')[0]}',  // Formateando la fecha
            style: const TextStyle(fontSize: 16)
          ),
        ],
      ),
    );
  }

  Widget _buildComprasView() {
    return ListView.builder(
      itemCount: 0, // Reemplazar con la lista real de compras
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text('Compra ejemplo'),
          subtitle: Text('Detalles de la compra'),
        );
      },
    );
  }

  Widget _buildPagosView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<String>(
                hint: const Text('Filtrar por'),
                items: const [
                  DropdownMenuItem(value: 'todos', child: Text('Todos')),
                  DropdownMenuItem(value: 'efectivo', child: Text('Efectivo')),
                  DropdownMenuItem(value: 'transferencia', child: Text('Transferencia')),
                ],
                onChanged: (value) {
                  // Implementar filtrado
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 0, // Reemplazar con la lista real de pagos
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text('20/04/2023'),
                subtitle: Text('Efectivo - Pago parcial'),
                trailing: Text('+\$200', style: TextStyle(color: Colors.green)),
              );
            },
          ),
        ),
      ],
    );
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Está seguro que desea eliminar este cliente?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final clienteController = Provider.of<ClienteController>(context, listen: false);
                try {
                  await clienteController.deleteCliente(widget.cliente.id);  // Usando el ID del cliente
                  if (mounted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cliente eliminado exitosamente')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al eliminar el cliente: $e')),
                    );
                  }
                }
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoRegistroPago() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registrar Pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Método de pago',
                ),
                items: const [
                  DropdownMenuItem(value: 'efectivo', child: Text('Efectivo')),
                  DropdownMenuItem(value: 'transferencia', child: Text('Transferencia')),
                ],
                onChanged: (value) {
                  // Implementar selección de método de pago
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implementar registro de pago
                Navigator.of(context).pop();
              },
              child: const Text('Registrar'),
            ),
          ],
        );
      },
    );
  }
}