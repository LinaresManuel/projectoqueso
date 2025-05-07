import 'package:flutter/material.dart';

class LoteForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(Map<String, dynamic>) onSubmitLote;

  LoteForm({Key? key, required this.onSubmitLote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController productoController = TextEditingController();
    final TextEditingController cantidadTotalController = TextEditingController();
    final TextEditingController pesoComercialController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: productoController,
            decoration: InputDecoration(labelText: 'Producto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el producto';
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
          TextFormField(
            controller: pesoComercialController,
            decoration: InputDecoration(labelText: 'Peso Comercial'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el peso comercial';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmitLote({
                  'producto': productoController.text,
                  'cantidadTotal': cantidadTotalController.text,
                  'pesoComercial': pesoComercialController.text,
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