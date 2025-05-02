import 'package:flutter/material.dart';
import 'screens/registro_venta_screen.dart';
import 'screens/lista_clientes_screen.dart';
import 'screens/resumen_diario_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[800],
        scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Beige
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistroVentaScreen(),
        '/clientes': (context) => const ListaClientesScreen(),
        '/resumen': (context) => const ResumenDiarioScreen(),
      },
    );
  }
}

// Drawer Widget
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green[800]),
            child: const Text(
              'Menú Principal',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Ventas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/clientes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Resumen'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/resumen');
            },
          ),
        ],
      ),
    );
  }
}
