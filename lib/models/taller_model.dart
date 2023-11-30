import 'dart:convert';
import 'dart:math';

class Taller {
  /* id, nombre, ubicacion, createdAt, id_usuario*/
  int? id;
  String nombre;
  Point ubicacion;
  DateTime? createdAt;
  int id_usuario;

  Taller({
    this.id,
    required this.nombre,
    required this.ubicacion,
    this.createdAt,
    required this.id_usuario,
  });

  factory Taller.fromJson(String str) => Taller.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Taller.fromMap(Map<String, dynamic> json) => Taller(
        id: json["id"],
        nombre: json["nombre"],
        ubicacion: Point(json["ubicacion"]["x"], json["ubicacion"]["y"]),
        createdAt: DateTime.parse(json["createdAt"]),
        id_usuario: json["id_usuario"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "latitud": ubicacion.x,
        "longitud": ubicacion.y,
        "createdAt": createdAt!.toIso8601String(),
        "id_usuario": id_usuario,
      };

  /* List */
  static List<Taller> fromJsonList(List list) {
    if (list.isEmpty) return List<Taller>.empty();
    return list.map((item) => Taller.fromMap(item)).toList();
  }

  static List<Taller> fromJsonListString(String str) {
    if (str.isEmpty) return List<Taller>.empty();
    return json
        .decode(str)
        .map((item) => Taller.fromMap(item))
        .toList()
        .cast<Taller>();
  }
}
