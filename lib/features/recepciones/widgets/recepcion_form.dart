import 'package:flutter/material.dart';

class RecepcionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(Map<String, dynamic>) onSubmitRecepcion;

  RecepcionForm({Key? key, required this.onSubmitRecepcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController proveedorController = TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    final TextEditingController cantidadTotalController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: proveedorController,
            decoration: InputDecoration(labelText: 'Proveedor'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el proveedor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: fechaController,
            decoration: InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la fecha';
              }
              return null;
            },
          ),
          TextFormField(
            controller: cantidadTotalController,
            decoration: InputDecoration(labelText: 'Cantidad Total'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad total';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmitRecepcion({
                  'proveedor': proveedorController.text,
                  'fecha': fechaController.text,
                  'cantidadTotal': cantidadTotalController.text,
                });
              }
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}