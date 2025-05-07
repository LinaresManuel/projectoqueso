import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recepcion_controller.dart';
import '../widgets/recepcion_form.dart';
import '../../../data/models/recepcion_model.dart';

class RegistroRecepcionScreen extends StatelessWidget {
  final RecepcionController _recepcionController = Get.put(RecepcionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Recepción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RecepcionForm(
          onSubmitRecepcion: (recepcionData) {
            final recepcion = Recepcion(
              id: 0, // ID temporal, será asignado por el backend
              proveedorId: int.parse(recepcionData['proveedorId']), // Proveer proveedorId
              fecha: DateTime.parse(recepcionData['fecha']),
              proveedor: recepcionData['proveedor'],
              cantidadTotal: double.parse(recepcionData['cantidadTotal']),
              observaciones: recepcionData['observaciones'],
            );
            _recepcionController.registrarRecepcion(recepcion);
            Get.back();
          },
        ),
      ),
    );
  }
}