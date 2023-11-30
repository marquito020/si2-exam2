import 'dart:convert';

class Rol {
  /* id, rol, descripcion, createdAt */
  int id;
  String rol;
  String descripcion;
  DateTime createdAt;

  Rol({
    required this.id,
    required this.rol,
    required this.descripcion,
    required this.createdAt,
  });

  factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json["id"],
        rol: json["rol"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rol": rol,
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
      };

  /* List */
  static List<Rol> fromJsonList(List list) {
    if (list.isEmpty) return List<Rol>.empty();
    return list.map((item) => Rol.fromMap(item)).toList();
  }

  static List<Rol> fromJsonListString(String str) {
    if (str.isEmpty) return List<Rol>.empty();
    return json
        .decode(str)
        .map((item) => Rol.fromMap(item))
        .toList()
        .cast<Rol>();
  }
}