import 'dart:convert';

class Persona {
  /* nombre, celular, id_rol, img, fecha_nac */
  String nombre;
  int celular;
  int id_rol;
  String img;
  String fecha_nac;

  Persona({
    required this.nombre,
    required this.celular,
    required this.id_rol,
    required this.img,
    required this.fecha_nac,
  });

  factory Persona.fromJson(String str) => Persona.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        nombre: json["nombre"],
        celular: json["celular"],
        id_rol: json["id_rol"],
        img: json["img"],
        fecha_nac: (json["fecha_nac"]),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "celular": celular,
        "id_rol": id_rol,
        "img": img,
        "fecha_nac": fecha_nac,
      };
}
