import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_endpoints.dart';
import 'dart:developer';

class ApiService {
  Future<Map<String, dynamic>> _handleRequest(Future<http.Response> request) async {
    try {
      final response = await request;
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> registrarCliente(String nombre, String contacto) async {
    final url = Uri.parse(ApiEndpoints.registrarCliente);
    return _handleRequest(http.post(
      url,
      body: {
        'nombre': nombre,
        'contacto': contacto,
      },
    ));
  }

  Future<Map<String, dynamic>> obtenerClientes() async {
    final url = Uri.parse(ApiEndpoints.obtenerClientes);
    try {
      final response = await http.get(url);
      log('Respuesta raw del servidor: ${response.body}'); // Para depuración
      
      if (response.statusCode == 200) {
        try {
          // Encontrar el inicio del JSON (primer '{')
          final jsonStartIndex = response.body.indexOf('{');
          if (jsonStartIndex != -1) {
            final jsonStr = response.body.substring(jsonStartIndex);
            return json.decode(jsonStr);
          } else {
            return {
              'success': false,
              'message': 'Formato de respuesta inválido'
            };
          }
        } catch (e) {
          log('Error al decodificar JSON: $e');
          return {
            'success': false,
            'message': 'Error al procesar la respuesta del servidor: $e'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> historialVentasCliente(String clienteId) async {
    final url = Uri.parse("${ApiEndpoints.historialVentasCliente}?cliente_id=$clienteId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> historialPagosCliente(String clienteId) async {
    final url = Uri.parse("${ApiEndpoints.historialPagosCliente}?cliente_id=$clienteId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> clientesEndeudados() async {
    final url = Uri.parse(ApiEndpoints.clientesEndeudados);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> resumenVentasCliente() async {
    final url = Uri.parse(ApiEndpoints.resumenVentasCliente);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> resumenInventario() async {
    final url = Uri.parse(ApiEndpoints.resumenInventario);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> detallesLote(String loteId) async {
    final url = Uri.parse("${ApiEndpoints.detallesLote}?lote_id=$loteId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> obtenerLotes() async {
    final url = Uri.parse(ApiEndpoints.obtenerLotes);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> historialIngresosLote(String loteId) async {
    final url = Uri.parse("${ApiEndpoints.historialIngresosLote}?lote_id=$loteId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> detallesRecepcion(String recepcionId) async {
    final url = Uri.parse("${ApiEndpoints.detallesRecepcion}?recepcion_id=$recepcionId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> obtenerRecepciones() async {
    final url = Uri.parse(ApiEndpoints.obtenerRecepciones);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> ventasPendientes() async {
    final url = Uri.parse(ApiEndpoints.ventasPendientes);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> registrarVenta(Map<String, dynamic> ventaData) async {
    final url = Uri.parse(ApiEndpoints.registrarVenta);
    try {
      final response = await http.post(
        url,
        body: ventaData,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> obtenerVentas() async {
    final url = Uri.parse(ApiEndpoints.obtenerVentas);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> actualizarCliente(String id, String nombre, String contacto) async {
    final url = Uri.parse(ApiEndpoints.actualizarCliente);
    try {
      final response = await http.post(
        url,
        body: {
          'id': id,
          'nombre': nombre,
          'contacto': contacto,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> eliminarCliente(String id) async {
    final url = Uri.parse(ApiEndpoints.eliminarCliente);
    try {
      final response = await http.post(
        url,
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> eliminarVenta(String id) async {
    final url = Uri.parse(ApiEndpoints.eliminarVenta);
    try {
      final response = await http.post(
        url,
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> registrarLote(Map<String, dynamic> loteData) async {
    final url = Uri.parse(ApiEndpoints.registrarLote);
    try {
      final response = await http.post(
        url,
        body: loteData,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> eliminarLote(String id) async {
    final url = Uri.parse(ApiEndpoints.eliminarLote);
    try {
      final response = await http.post(
        url,
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> registrarRecepcion(Map<String, dynamic> recepcionData) async {
    final url = Uri.parse(ApiEndpoints.registrarRecepcion);
    try {
      final response = await http.post(
        url,
        body: recepcionData,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  Future<Map<String, dynamic>> eliminarRecepcion(String id) async {
    final url = Uri.parse(ApiEndpoints.eliminarRecepcion);
    try {
      final response = await http.post(
        url,
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error en la solicitud: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }
}