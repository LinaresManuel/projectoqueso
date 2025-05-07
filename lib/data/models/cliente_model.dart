class Cliente {
  final int id;
  final String nombre;
  final String contacto;
  final double balance;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cliente({
    required this.id,
    required this.nombre,
    required this.contacto,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: int.parse(json['id'].toString()),  // Convertir String a int
      nombre: json['nombre'] as String,
      contacto: json['contacto'] as String,
      balance: double.parse(json['balance'].toString()),  // Convertir String a double
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),  // Convertir a String para el API
      'nombre': nombre,
      'contacto': contacto,
      'balance': balance.toString(),  // Convertir a String para el API
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}