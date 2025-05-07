import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lote_controller.dart';
import '../widgets/lote_form.dart';
import '../../../data/models/lote_model.dart';

class RegistroLoteScreen extends StatelessWidget {
  final LoteController _loteController = Get.put(LoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Lote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoteForm(
          onSubmitLote: (loteData) {
            final lote = Lote(
              id: 0, // ID temporal, será asignado por el backend
              productoId: int.parse(loteData['productoId']), // Proveer productoId
              cantidadTotal: double.parse(loteData['cantidadTotal']),
              cantidadDisponible: double.parse(loteData['cantidadTotal']), // Inicialmente igual a la cantidad total
              pesoComercial: double.parse(loteData['pesoComercial']),
              sobrante: double.parse(loteData['sobrante']), // Proveer sobrante
              producto: loteData['producto'],
            );
            _loteController.registrarLote(lote);
            Get.back();
          },
        ),
      ),
    );
  }
}