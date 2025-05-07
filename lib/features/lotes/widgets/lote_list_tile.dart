import 'package:flutter/material.dart';

class LoteListTile extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  const LoteListTile({
    Key? key,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titulo, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitulo),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}