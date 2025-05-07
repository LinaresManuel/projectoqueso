import '../services/api_service.dart';

class ClienteRepository {
  final ApiService _apiService;

  ClienteRepository(this._apiService);

  Future<List<Map<String, String>>> getClientes() async {
    final response = await _apiService.obtenerClientes();
    if (response['success']) {
      return List<Map<String, String>>.from(response['data']);
    } else {
      throw Exception(response['message']);
    }
  }

  Future<void> addCliente(Map<String, String> cliente) async {
    final response = await _apiService.registrarCliente(cliente['nombre']!, cliente['contacto']!);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  Future<void> updateCliente(Map<String, String> cliente) async {
    final response = await _apiService.actualizarCliente(
      cliente['id']!,
      cliente['nombre']!,
      cliente['contacto']!,
    );
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  Future<void> deleteCliente(String id) async {
    final response = await _apiService.eliminarCliente(id);
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }
}