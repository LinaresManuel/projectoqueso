import 'package:flutter/material.dart';
import '../../../data/repositories/cliente_repository.dart';
import '../../../data/services/api_service.dart';

class ClienteController extends ChangeNotifier {
  final ClienteRepository _clienteRepository;

  ClienteController() : _clienteRepository = ClienteRepository(ApiService());

  List<Map<String, String>> _clientes = [];
  List<Map<String, String>> get clientes => _clientes;

  Future<void> fetchClientes() async {
    _clientes = await _clienteRepository.getClientes();
    notifyListeners();
  }

  Future<void> addCliente(Map<String, String> cliente) async {
    await _clienteRepository.addCliente(cliente);
    await fetchClientes();
  }

  Future<void> updateCliente(Map<String, String> cliente) async {
    await _clienteRepository.updateCliente(cliente);
    await fetchClientes();
  }

  Future<void> deleteCliente(String id) async {
    await _clienteRepository.deleteCliente(id);
    await fetchClientes();
  }
}