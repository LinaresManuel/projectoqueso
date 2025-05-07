import 'package:flutter/material.dart';
import '../features/clientes/screens/lista_clientes_screen.dart';
import '../features/ventas/screens/lista_ventas_screen.dart';
import '../features/lotes/screens/lista_lotes_screen.dart';
import '../features/recepciones/screens/lista_recepciones_screen.dart';

class AppRoutes {
  static const String initialRoute = '/clientes';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/clientes': (context) => const ListaClientesScreen(),
      '/ventas': (context) => ListaVentasScreen(),
      '/lotes': (context) => ListaLotesScreen(),
      '/recepciones': (context) => ListaRecepcionesScreen(),
    };
  }
}