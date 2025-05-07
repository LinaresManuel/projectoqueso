import 'package:flutter/material.dart';
import '../widgets/cliente_form.dart';

class RegistroClienteScreen extends StatelessWidget {
  final Map<String, String>? cliente;

  const RegistroClienteScreen({Key? key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cliente == null ? 'Registrar Cliente' : 'Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClienteForm(cliente: cliente),
      ),
    );
  }
}