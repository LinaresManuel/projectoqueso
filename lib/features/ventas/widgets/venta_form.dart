import 'package:flutter/material.dart';

class VentaForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(Map<String, dynamic>) onSubmitVenta; // Cambiar el tipo del callback para aceptar datos del formulario

  VentaForm({Key? key, required this.onSubmitVenta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController productoController = TextEditingController();
    final TextEditingController cantidadController = TextEditingController();

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
            controller: cantidadController,
            decoration: InputDecoration(labelText: 'Cantidad'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmitVenta({
                  'producto': productoController.text,
                  'cantidad': cantidadController.text,
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