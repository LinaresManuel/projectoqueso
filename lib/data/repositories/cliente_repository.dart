import 'dart:developer';
import '../services/api_service.dart';
import '../models/cliente_model.dart';

class ClienteRepository {
  final ApiService _apiService;

  ClienteRepository(this._apiService);

  // Obtener la lista de clientes
  Future<List<Cliente>> getClientes() async {
    try {
      final response = await _apiService.obtenerClientes();
      
      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((json) => Cliente.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(response['message'] ?? 'Error desconocido al obtener clientes');
      }
    } catch (e) {
      throw Exception('Error al obtener los clientes: $e');
    }
  }

  // Registrar un nuevo cliente
  Future<void> _handleResponse(Future<Map<String, dynamic>> Function() apiCall) async {
    final response = await apiCall();
    if (!response['success']) {
      throw Exception(response['message']);
    }
  }

  Future<void> addCliente(String nombre, String contacto) async {
    await _handleResponse(() => _apiService.registrarCliente(nombre, contacto));
  }

  // Actualizar un cliente existente
  Future<void> updateCliente(int id, String nombre, String contacto) async {
    await _handleResponse(() => _apiService.actualizarCliente(id.toString(), nombre, contacto));
  }

  // Eliminar un cliente
  Future<void> deleteCliente(int id) async {
    await _handleResponse(() => _apiService.eliminarCliente(id.toString()));
  }
}