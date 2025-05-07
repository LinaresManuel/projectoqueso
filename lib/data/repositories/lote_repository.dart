import '../models/lote_model.dart';
import '../services/api_service.dart';

class LoteRepository {
  final ApiService _apiService;

  LoteRepository(this._apiService);

  // Obtener la lista de lotes
  Future<List<Lote>> obtenerLotes() async {
    final response = await _apiService.obtenerLotes();
    if (response['success']) {
      return (response['data'] as List)
          .map((loteJson) => Lote.fromJson(loteJson))
          .toList();
    } else {
      throw Exception(response['message']);
    }
  }

  // Obtener detalles de un lote específico
  Future<Lote> obtenerDetallesLote(int loteId) async {
    final response = await _apiService.detallesLote(loteId.toString());
    if (response['success']) {
      return Lote.fromJson(response['data']);
    } else {
      throw Exception(response['message']);
    }
  }

  // Registrar un nuevo lote
  Future<void> registrarLote(Map<String, dynamic> loteData) async {
    final response = await _apiService.registrarLote(loteData);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  // Eliminar un lote
  Future<void> eliminarLote(String id) async {
    final response = await _apiService.eliminarLote(id);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }
}