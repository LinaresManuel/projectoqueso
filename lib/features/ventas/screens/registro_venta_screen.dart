import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/venta_controller.dart';
import '../widgets/venta_form.dart';
import '../../../data/models/venta_model.dart';

class RegistroVentaScreen extends StatelessWidget {
  final VentaController _ventaController = Get.put(VentaController());

  RegistroVentaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VentaForm(
          onSubmitVenta: (ventaData) {
            final venta = Venta(
              id: '', // ID temporal, será asignado por el backend
              clienteId: ventaData['clienteId'],
              loteId: ventaData['loteId'],
              cantidad: double.parse(ventaData['cantidad']),
              precioUnitario: double.parse(ventaData['precioUnitario']),
              total: double.parse(ventaData['cantidad']) * double.parse(ventaData['precioUnitario']),
              montoPagado: 0.0,
              pagado: false,
              fecha: DateTime.now(),
            );
            _ventaController.registrarVenta(venta);
            Get.back();
          },
        ),
      ),
    );
  }
}