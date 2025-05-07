import 'package:flutter/material.dart';

class VentaListTile extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  VentaListTile({
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titulo),
      subtitle: Text(subtitulo),
      onTap: onTap,
    );
  }
}