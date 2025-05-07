class Cliente {
  final int id;
  final String nombre;
  final String contacto;
  final double balance;

  Cliente({
    required this.id,
    required this.nombre,
    required this.contacto,
    required this.balance,
  });

  // Método para convertir un mapa JSON a un objeto Cliente
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      contacto: json['contacto'],
      balance: (json['balance'] as num).toDouble(),
    );
  }

  // Método para convertir un objeto Cliente a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'contacto': contacto,
      'balance': balance,
    };
  }
}