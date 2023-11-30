import 'dart:convert';

class Servicio {
  /* id?, servicio, descripcion, createdAt, id_taller, precio */
  int? id;
  String servicio;
  String descripcion;
  DateTime createdAt;
  int? id_taller;
  int precio;

  Servicio({
    this.id,
    required this.servicio,
    required this.descripcion,
    required this.createdAt,
    this.id_taller,
    required this.precio,
  });

  factory Servicio.fromJson(String str) => Servicio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Servicio.fromMap(Map<String, dynamic> json) => Servicio(
        id: json["id"],
        servicio: json["servicio"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
        id_taller: json["id_taller"],
        precio: json["precio"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "servicio": servicio,
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
        "id_taller": id_taller,
        "precio": precio,
      };

  /* List */
  static List<Servicio> fromJsonList(List list) {
    if (list.isEmpty) return List<Servicio>.empty();
    return list.map((item) => Servicio.fromMap(item)).toList();
  }

  static List<Servicio> fromJsonListString(String str) {
    if (str.isEmpty) return List<Servicio>.empty();
    return json
        .decode(str)
        .map((item) => Servicio.fromMap(item))
        .toList()
        .cast<Servicio>();
  }

  @override
  String toString() {
    return 'Servicio{id: $id, servicio: $servicio, descripcion: $descripcion, createdAt: $createdAt, id_taller: $id_taller, precio: $precio}';
  }
}
