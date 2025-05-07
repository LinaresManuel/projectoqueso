class Validators {
  // Validar si un campo no está vacío
  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    return null;
  }

  // Validar si un valor es un número válido
  static String? validateNumber(String? value) {
    if (value == null || double.tryParse(value) == null) {
      return 'Por favor, ingrese un número válido';
    }
    return null;
  }

  // Validar si un correo electrónico es válido
  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (value == null || !emailRegex.hasMatch(value)) {
      return 'Por favor, ingrese un correo electrónico válido';
    }
    return null;
  }
}