import 'dart:convert';

class Img {
  int? id;
  String? img;
  int? id_asistencia;

  Img({
    this.id,
    this.img,
    this.id_asistencia,
  });

  factory Img.fromJson(String str) => Img.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Img.fromMap(Map<String, dynamic> json) => Img(
        id: json["id"],
        img: json["img"],
        id_asistencia: json["id_asistencia"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "img": img,
        "id_asistencia": id_asistencia,
      };

  /* List */
  static List<Img> fromJsonList(List list) {
    if (list.isEmpty) return List<Img>.empty();
    return list.map((item) => Img.fromMap(item)).toList();
  }
}