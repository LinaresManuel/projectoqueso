import '../models/venta_model.dart';
import '../services/api_service.dart';

class VentaRepository {
  final ApiService _apiService;

  VentaRepository(this._apiService);

  // Obtener la lista de ventas
  Future<List<Venta>> obtenerVentas() async {
    final response = await _apiService.obtenerVentas();
    if (response['success']) {
      return (response['data'] as List)
          .map((ventaJson) => Venta.fromJson(ventaJson))
          .toList();
    } else {
      throw Exception(response['message']);
    }
  }

  // Registrar una nueva venta
  Future<void> registrarVenta(Map<String, dynamic> ventaData) async {
    final response = await _apiService.registrarVenta(ventaData);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  // Eliminar una venta
  Future<void> eliminarVenta(String id) async {
    final response = await _apiService.eliminarVenta(id);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }
}