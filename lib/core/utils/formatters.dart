import 'package:intl/intl.dart';

class Formatters {
  // Formatear fechas a un formato legible
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  // Formatear números como moneda
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    return formatter.format(amount);
  }

  // Formatear texto a título (capitalizar)
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}