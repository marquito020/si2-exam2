import 'dart:convert';

class Tarjeta {
  /* id, numero, fecha_ven, cvs, id_usuario, createdAt */
  int? id;
  String numero;
  String fecha_ven;
  String cvs;
  int? id_usuario;
  DateTime createdAt;

  Tarjeta({
    this.id,
    required this.numero,
    required this.fecha_ven,
    required this.cvs,
    this.id_usuario,
    required this.createdAt,
  });

  factory Tarjeta.fromJson(String str) => Tarjeta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tarjeta.fromMap(Map<String, dynamic> json) => Tarjeta(
        id: json["id"],
        numero: json["numero"],
        fecha_ven: json["fecha_ven"],
        cvs: json["cvs"],
        id_usuario: json["id_usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "numero": numero,
        "fecha_ven": fecha_ven,
        "cvs": cvs,
        "id_usuario": id_usuario,
        "createdAt": createdAt.toIso8601String(),
      };

  /* List */
  static List<Tarjeta> fromJsonList(List list) {
    if (list.isEmpty) return List<Tarjeta>.empty();
    return list.map((item) => Tarjeta.fromMap(item)).toList();
  }

  static List<Tarjeta> fromJsonListString(String str) {
    if (str.isEmpty) return List<Tarjeta>.empty();
    return json
        .decode(str)
        .map((item) => Tarjeta.fromMap(item))
        .toList()
        .cast<Tarjeta>();
  }
}
