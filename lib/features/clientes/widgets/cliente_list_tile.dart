import 'package:flutter/material.dart';

class ClienteListTile extends StatelessWidget {
  final String nombre;
  final String contacto;
  final VoidCallback onTap;

  const ClienteListTile({
    Key? key,
    required this.nombre,
    required this.contacto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(contacto),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}