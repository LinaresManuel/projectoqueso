import 'dart:io';

void main() {
  final directories = [
    'lib/core/constants',
    'lib/core/utils',
    'lib/core/widgets',
    'lib/data/models',
    'lib/data/repositories',
    'lib/data/services',
    'lib/features/clientes/screens',
    'lib/features/clientes/widgets',
    'lib/features/clientes/controllers',
    'lib/features/ventas/screens',
    'lib/features/ventas/widgets',
    'lib/features/ventas/controllers',
    'lib/features/lotes/screens',
    'lib/features/lotes/widgets',
    'lib/features/lotes/controllers',
    'lib/features/recepciones/screens',
    'lib/features/recepciones/widgets',
    'lib/features/recepciones/controllers',
    'lib/routes',
  ];

  final files = [
    'lib/main.dart',
    'lib/core/constants/api_endpoints.dart',
    'lib/core/utils/formatters.dart',
    'lib/core/utils/validators.dart',
    'lib/core/widgets/custom_button.dart',
    'lib/core/widgets/custom_text_field.dart',
    'lib/core/widgets/loading_indicator.dart',
    'lib/data/models/cliente_model.dart',
    'lib/data/models/venta_model.dart',
    'lib/data/models/lote_model.dart',
    'lib/data/models/recepcion_model.dart',
    'lib/data/repositories/cliente_repository.dart',
    'lib/data/repositories/venta_repository.dart',
    'lib/data/repositories/lote_repository.dart',
    'lib/data/repositories/recepcion_repository.dart',
    'lib/data/services/api_service.dart',
    'lib/data/services/database_service.dart',
    'lib/features/clientes/screens/lista_clientes_screen.dart',
    'lib/features/clientes/screens/detalles_cliente_screen.dart',
    'lib/features/clientes/screens/registro_cliente_screen.dart',
    'lib/features/clientes/widgets/cliente_list_tile.dart',
    'lib/features/clientes/widgets/cliente_form.dart',
    'lib/features/clientes/controllers/cliente_controller.dart',
    'lib/features/ventas/screens/lista_ventas_screen.dart',
    'lib/features/ventas/screens/detalles_venta_screen.dart',
    'lib/features/ventas/screens/registro_venta_screen.dart',
    'lib/features/ventas/widgets/venta_list_tile.dart',
    'lib/features/ventas/widgets/venta_form.dart',
    'lib/features/ventas/controllers/venta_controller.dart',
    'lib/features/lotes/screens/lista_lotes_screen.dart',
    'lib/features/lotes/screens/detalles_lote_screen.dart',
    'lib/features/lotes/screens/registro_lote_screen.dart',
    'lib/features/lotes/widgets/lote_list_tile.dart',
    'lib/features/lotes/widgets/lote_form.dart',
    'lib/features/lotes/controllers/lote_controller.dart',
    'lib/features/recepciones/screens/lista_recepciones_screen.dart',
    'lib/features/recepciones/screens/detalles_recepcion_screen.dart',
    'lib/features/recepciones/screens/registro_recepcion_screen.dart',
    'lib/features/recepciones/widgets/recepcion_list_tile.dart',
    'lib/features/recepciones/widgets/recepcion_form.dart',
    'lib/features/recepciones/controllers/recepcion_controller.dart',
    'lib/routes/app_routes.dart',
  ];

  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created directory: $dir');
  }

  for (var file in files) {
    File(file).createSync(recursive: true);
    print('Created file: $file');
  }

  print('Project structure created successfully!');
}