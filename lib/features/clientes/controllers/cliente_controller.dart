import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../data/repositories/cliente_repository.dart';
import '../../../data/models/cliente_model.dart';
import '../../../data/services/api_service.dart';

class ClienteController extends ChangeNotifier {
  final ClienteRepository _clienteRepository;

  ClienteController() : _clienteRepository = ClienteRepository(ApiService());

  List<Cliente> _clientes = [];
  List<Cliente> get clientes => _clientes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchClientes() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      log('Iniciando fetchClientes');
      _clientes = await _clienteRepository.getClientes();
      log('Clientes obtenidos exitosamente: ${_clientes.length}');
    } catch (e) {
      log('Error en fetchClientes: $e');
      _errorMessage = e.toString();
      _clientes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _handleOperation(Future<void> Function() operation) async {
    try {
      await operation();
      await fetchClientes();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addCliente(String nombre, String contacto) async {
    await _handleOperation(() => _clienteRepository.addCliente(nombre, contacto));
  }

  Future<void> updateCliente(int id, String nombre, String contacto) async {
    await _handleOperation(() => _clienteRepository.updateCliente(id, nombre, contacto));
  }

  Future<void> deleteCliente(int id) async {
    await _handleOperation(() => _clienteRepository.deleteCliente(id));
  }
}