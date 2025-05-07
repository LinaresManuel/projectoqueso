import '../models/recepcion_model.dart';
import '../services/api_service.dart';

class RecepcionRepository {
  final ApiService _apiService;

  RecepcionRepository(this._apiService);

  // Obtener la lista de recepciones
  Future<List<Recepcion>> obtenerRecepciones() async {
    final response = await _apiService.obtenerRecepciones();
    if (response['success']) {
      return (response['data'] as List)
          .map((recepcionJson) => Recepcion.fromJson(recepcionJson))
          .toList();
    } else {
      throw Exception(response['message']);
    }
  }

  // Obtener detalles de una recepción específica
  Future<List<Map<String, dynamic>>> obtenerDetallesRecepcion(int recepcionId) async {
    final response = await _apiService.detallesRecepcion(recepcionId.toString());
    if (response['success']) {
      return (response['data'] as List).cast<Map<String, dynamic>>();
    } else {
      throw Exception(response['message']);
    }
  }

  // Registrar una nueva recepción
  Future<void> registrarRecepcion(Map<String, dynamic> recepcionData) async {
    final response = await _apiService.registrarRecepcion(recepcionData);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  // Eliminar una recepción
  Future<void> eliminarRecepcion(String id) async {
    final response = await _apiService.eliminarRecepcion(id);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }
}