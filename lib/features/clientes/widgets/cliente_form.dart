import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
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
            decoration: const InputDecoration(labelText: 'Contacto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un contacto';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Guardar cliente
                final nuevoCliente = {
                  'nombre': _nombreController.text,
                  'contacto': _contactoController.text,
                };
                Navigator.pop(context, nuevoCliente);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}