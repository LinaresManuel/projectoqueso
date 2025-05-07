import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/clientes/controllers/cliente_controller.dart';
import 'routes/app_routes.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClienteController()..fetchClientes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestión de Ventas'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildNavigationTile(context, 'Clientes', Icons.people, '/clientes'),
            _buildNavigationTile(context, 'Lotes', Icons.inventory, '/lotes'),
            _buildNavigationTile(context, 'Recepciones', Icons.receipt, '/recepciones'),
            _buildNavigationTile(context, 'Ventas', Icons.shopping_cart, '/ventas'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8.0),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}