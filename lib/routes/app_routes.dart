import 'package:flutter/material.dart';
import '../main_navigation_screen.dart';
import '../features/clientes/screens/lista_clientes_screen.dart';
import '../features/ventas/screens/lista_ventas_screen.dart';
import '../features/lotes/screens/lista_lotes_screen.dart';
import '../features/recepciones/screens/lista_recepciones_screen.dart';
import '../features/clientes/screens/registro_cliente_screen.dart';
import '../features/clientes/screens/detalles_cliente_screen.dart';
import '../features/lotes/screens/registro_lote_screen.dart';
import '../features/lotes/screens/detalles_lote_screen.dart';
import '../features/ventas/screens/registro_venta_screen.dart';
import '../features/ventas/screens/detalles_venta_screen.dart';
import '../features/recepciones/screens/registro_recepcion_screen.dart';
import '../features/recepciones/screens/detalles_recepcion_screen.dart';
import '../data/models/cliente_model.dart';  // Agregamos esta importación

class AppRoutes {
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const MainNavigationScreen(),
      // Rutas de Clientes
      '/clientes': (context) => const ListaClientesScreen(),
      '/registro_cliente': (context) => const RegistroClienteScreen(),
      '/detalles_cliente': (context) {
        final Cliente cliente = ModalRoute.of(context)!.settings.arguments as Cliente;
        return DetallesClienteScreen(cliente: cliente);
      },
      // Rutas de Lotes
      '/lotes': (context) => ListaLotesScreen(),
      '/registro_lote': (context) => RegistroLoteScreen(),
      '/detalles_lote': (context) {
        final lote = ModalRoute.of(context)!.settings.arguments as dynamic;
        return DetallesLoteScreen(lote: lote);
      },
      // Rutas de Ventas
      '/ventas': (context) => ListaVentasScreen(),
      '/registro_venta': (context) => RegistroVentaScreen(),
      '/detalles_venta': (context) {
        final venta = ModalRoute.of(context)!.settings.arguments as dynamic;
        return DetallesVentaScreen(venta: venta);
      },
      // Rutas de Recepciones
      '/recepciones': (context) => ListaRecepcionesScreen(),
      '/registro_recepcion': (context) => RegistroRecepcionScreen(),
      '/detalles_recepcion': (context) {
        final recepcion = ModalRoute.of(context)!.settings.arguments as dynamic;
        return DetallesRecepcionScreen(recepcion: recepcion);
      },
    };
  }
}