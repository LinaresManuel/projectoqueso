import 'package:flutter/material.dart';
import '../../../data/models/venta_model.dart';
import '../../../data/repositories/venta_repository.dart';
import '../../../data/services/api_service.dart';

class VentaController extends ChangeNotifier {
  final VentaRepository _ventaRepository;

  VentaController() : _ventaRepository = VentaRepository(ApiService());

  List<Venta> _ventas = [];
  List<Venta> get ventas => _ventas;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<Venta>> fetchVentas() async {
    _isLoading = true;
    notifyListeners();
    try {
      final ventas = await _ventaRepository.obtenerVentas();
      _ventas = ventas;
      return ventas;
    } catch (e) {
      print('Error al obtener ventas: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registrarVenta(Venta venta) async {
    try {
      await _ventaRepository.registrarVenta(venta.toJson());
      await fetchVentas();
    } catch (e) {
      print('Error al registrar venta: $e');
    }
  }

  Future<void> eliminarVenta(String id) async {
    try {
      await _ventaRepository.eliminarVenta(id);
      await fetchVentas();
    } catch (e) {
      print('Error al eliminar venta: $e');
    }
  }
}