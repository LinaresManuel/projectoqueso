import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'features/clientes/controllers/cliente_controller.dart';
import 'features/lotes/controllers/lote_controller.dart';
import 'features/recepciones/controllers/recepcion_controller.dart';
import 'features/ventas/controllers/venta_controller.dart';
import 'data/repositories/cliente_repository.dart';
import 'data/services/api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClienteController()),
        ChangeNotifierProvider(create: (_) => LoteController()),
        ChangeNotifierProvider(create: (_) => RecepcionController()),
        ChangeNotifierProvider(create: (_) => VentaController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Ventas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.initialRoute,  // Esto ahora apuntará a '/'
      routes: AppRoutes.getRoutes(),
    );
  }
}