import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cliente_controller.dart';

class ClienteForm extends StatefulWidget {
  final Map<String, String>? cliente;

  const ClienteForm({Key? key, this.cliente}) : super(key: key);

  @override
  State<ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends State<ClienteForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _contactoController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.cliente?['nombre'] ?? '');
    _contactoController = TextEditingController(text: widget.cliente?['contacto'] ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _contactoController.dispose();
    super.dispose();
  }

  Future<void> _guardarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final clienteController = Provider.of<ClienteController>(context, listen: false);
      
      if (widget.cliente != null && widget.cliente!['id'] != null) {
        // Actualizar cliente existente
        await clienteController.updateCliente(
          int.parse(widget.cliente!['id']!),
          _nombreController.text,
          _contactoController.text,
        );
      } else {
        // Registrar nuevo cliente
        await clienteController.addCliente(
          _nombreController.text,
          _contactoController.text,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente guardado exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contactoController,
            decoration: const InputDecoration(
              labelText: 'Contacto',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un contacto';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _guardarCliente,
            child: _isLoading
                ? const CircularProgressIndicator()
                : Text(widget.cliente == null ? 'Registrar' : 'Actualizar'),
          ),
        ],
      ),
    );
  }
}