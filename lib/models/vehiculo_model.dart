import 'dart:convert';

class Vehiculo {
  /* id?, placa, anio, modelo, marca, color, id_usuario, createdAt, img */
  int? id;
  String placa;
  int anio;
  String modelo;
  String marca;
  String color;
  int id_usuario;
  DateTime createdAt;
  String img;

  Vehiculo({
    this.id,
    required this.placa,
    required this.anio,
    required this.modelo,
    required this.marca,
    required this.color,
    required this.id_usuario,
    required this.createdAt,
    required this.img,
  });

  factory Vehiculo.fromJson(String str) => Vehiculo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehiculo.fromMap(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        placa: json["placa"],
        anio: json["anio"],
        modelo: json["modelo"],
        marca: json["marca"],
        color: json["color"],
        id_usuario: json["id_usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "placa": placa,
        "anio": anio,
        "modelo": modelo,
        "marca": marca,
        "color": color,
        "id_usuario": id_usuario,
        "createdAt": createdAt.toIso8601String(),
        "img": img,
      };

  /* List */
  static List<Vehiculo> fromJsonList(List list) {
    if (list.isEmpty) return List<Vehiculo>.empty();
    return list.map((item) => Vehiculo.fromMap(item)).toList();
  }

  static List<Vehiculo> fromJsonListString(String str) {
    if (str.isEmpty) return List<Vehiculo>.empty();
    return json
        .decode(str)
        .map((item) => Vehiculo.fromMap(item))
        .toList()
        .cast<Vehiculo>();
  }
}
