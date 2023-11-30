import 'dart:convert';
import 'dart:math';

class Asistencia {
  /* id?, id_usuario, ?id_tecnico, id_servicio, ?id_taller, ubicacion, ?str_ruta, costo, pago_targeta, state_verf */
  int? id;
  int? id_usuario;
  int? id_tecnico;
  int id_servicio;
  int? id_taller;
  Point? ubicacion;
  bool? str_ruta;
  int? costo;
  bool? pago_targeta;
  bool? state_verf;
  bool? pago;

  Asistencia({
    this.id,
    this.id_usuario,
    this.id_tecnico,
    required this.id_servicio,
    this.id_taller,
    this.ubicacion,
    this.str_ruta,
    this.costo,
    required this.pago_targeta,
    this.state_verf,
    this.pago,
  });

  factory Asistencia.fromJson(String str) =>
      Asistencia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Asistencia.fromMap(Map<String, dynamic> json) => Asistencia(
        id: json["id"],
        id_usuario: json["id_usuario"],
        id_tecnico: json["id_tecnico"],
        id_servicio: json["id_servicio"],
        id_taller: json["id_taller"],
        ubicacion: Point(json["ubicacion"]["x"], json["ubicacion"]["y"]),
        str_ruta: json["str_ruta"],
        costo: json["costo"],
        pago_targeta: json["pago_targeta"],
        state_verf: json["state_verif"],
        pago: json["pago"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_usuario": id_usuario,
        "id_tecnico": id_tecnico,
        "id_servicio": id_servicio,
        "id_taller": id_taller,
        "ubicacion": ubicacion,
        "str_ruta": str_ruta,
        "costo": costo,
        "pago_targeta": pago_targeta,
        "state_verif": state_verf,
        "pago": pago,
      };

  /* List */
  static List<Asistencia> fromJsonList(List list) {
    if (list.isEmpty) return List<Asistencia>.empty();
    return list.map((item) => Asistencia.fromMap(item)).toList();
  }

  static List<Asistencia> fromJsonListString(String str) {
    if (str.isEmpty) return List<Asistencia>.empty();
    return json
        .decode(str)
        .map((item) => Asistencia.fromMap(item))
        .toList()
        .cast<Asistencia>();
  }

  @override
  String toString() {
    return 'Asistencia{id: $id, id_usuario: $id_usuario, id_tecnico: $id_tecnico, id_servicio: $id_servicio, id_taller: $id_taller, ubicacion: $ubicacion, str_ruta: $str_ruta, costo: $costo, pago_targeta: $pago_targeta, state_verf: $state_verf}';
  }
}
