import 'package:flutter/material.dart';
import '../../../data/models/lote_model.dart';
import '../../../data/repositories/lote_repository.dart';
import '../../../data/services/api_service.dart';

class LoteController extends ChangeNotifier {
  final LoteRepository _loteRepository;

  LoteController() : _loteRepository = LoteRepository(ApiService());

  List<Lote> _lotes = [];
  List<Lote> get lotes => _lotes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<Lote>> fetchLotes() async {
    _isLoading = true;
    notifyListeners();
    try {
      final lotes = await _loteRepository.obtenerLotes();
      _lotes = lotes;
      return lotes;
    } catch (e) {
      print('Error al obtener lotes: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registrarLote(Lote lote) async {
    try {
      await _loteRepository.registrarLote(lote.toJson());
      await fetchLotes();
    } catch (e) {
      print('Error al registrar lote: $e');
    }
  }

  Future<void> eliminarLote(String id) async {
    try {
      await _loteRepository.eliminarLote(id);
      await fetchLotes();
    } catch (e) {
      print('Error al eliminar lote: $e');
    }
  }
}