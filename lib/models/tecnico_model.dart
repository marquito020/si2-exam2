import 'dart:convert';

class Tecnico {
  /* id, sueldo, hora_ini, hora_fin, id_usuario, id_taller, createdAt */
  int? id;
  int sueldo;
  String hora_ini;
  String hora_fin;
  int id_usuario;
  int id_taller;
  DateTime? createdAt;

  Tecnico({
    this.id,
    required this.sueldo,
    required this.hora_ini,
    required this.hora_fin,
    required this.id_usuario,
    required this.id_taller,
    this.createdAt,
  });

  factory Tecnico.fromJson(String str) => Tecnico.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tecnico.fromMap(Map<String, dynamic> json) => Tecnico(
        id: json["id"],
        sueldo: json["sueldo"],
        hora_ini: json["hora_ini"],
        hora_fin: json["hora_fin"],
        id_usuario: json["id_usuario"],
        id_taller: json["id_taller"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sueldo": sueldo,
        "hora_ini": hora_ini,
        "hora_fin": hora_fin,
        "id_usuario": id_usuario,
        "id_taller": id_taller,
        "createdAt": createdAt?.toIso8601String(),
      };

  /* List */
  static List<Tecnico> fromJsonList(List list) {
    if (list.isEmpty) return List<Tecnico>.empty();
    return list.map((item) => Tecnico.fromMap(item)).toList();
  }

  static List<Tecnico> fromJsonListString(String str) {
    if (str.isEmpty) return List<Tecnico>.empty();
    return json
        .decode(str)
        .map((item) => Tecnico.fromMap(item))
        .toList()
        .cast<Tecnico>();
  }
}
