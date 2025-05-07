import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static const String _cacheBoxName = 'cacheBox';

  // Inicializar Hive
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_cacheBoxName);
  }

  // Guardar datos en la caché
  Future<void> saveToCache(String key, dynamic value) async {
    final box = Hive.box(_cacheBoxName);
    await box.put(key, value);
  }

  // Obtener datos de la caché
  dynamic getFromCache(String key) {
    final box = Hive.box(_cacheBoxName);
    return box.get(key);
  }

  // Eliminar datos de la caché
  Future<void> removeFromCache(String key) async {
    final box = Hive.box(_cacheBoxName);
    await box.delete(key);
  }

  // Limpiar toda la caché
  Future<void> clearCache() async {
    final box = Hive.box(_cacheBoxName);
    await box.clear();
  }
}