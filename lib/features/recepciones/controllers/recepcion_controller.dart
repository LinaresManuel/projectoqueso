import 'package:flutter/material.dart';
import '../../../data/models/recepcion_model.dart';
import '../../../data/repositories/recepcion_repository.dart';
import '../../../data/services/api_service.dart';

class RecepcionController extends ChangeNotifier {
  final RecepcionRepository _recepcionRepository;

  RecepcionController() : _recepcionRepository = RecepcionRepository(ApiService());

  List<Recepcion> _recepciones = [];
  List<Recepcion> get recepciones => _recepciones;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<Recepcion>> fetchRecepciones() async {
    _isLoading = true;
    notifyListeners();
    try {
      final recepciones = await _recepcionRepository.obtenerRecepciones();
      _recepciones = recepciones;
      return recepciones;
    } catch (e) {
      print('Error al obtener recepciones: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registrarRecepcion(Recepcion recepcion) async {
    try {
      await _recepcionRepository.registrarRecepcion(recepcion.toJson());
      await fetchRecepciones();
    } catch (e) {
      print('Error al registrar recepción: $e');
    }
  }

  Future<void> eliminarRecepcion(String id) async {
    try {
      await _recepcionRepository.eliminarRecepcion(id);
      await fetchRecepciones();
    } catch (e) {
      print('Error al eliminar recepción: $e');
    }
  }
}