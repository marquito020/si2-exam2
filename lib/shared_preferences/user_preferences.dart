
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  late SharedPreferences _prefs;

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get prefsUser => _prefs;

  String get token => _prefs.getString('token') ?? '';
  int get id => _prefs.getInt('id') ?? 0;
  String get correo => _prefs.getString('correo') ?? '';
  String get nombre => _prefs.getString('nombre') ?? '';
  int get celular => _prefs.getInt('celular') ?? 0;
  String get img => _prefs.getString('img') ?? '';
  int get id_rol => _prefs.getInt('id_rol') ?? 0;
  /* fecha_nac */
  String get fecha_nac => _prefs.getString('fecha_nac') ?? '';

  set token(String token) => _prefs.setString('token', token);
  set id(int id) => _prefs.setInt('id', id);
  set correo(String correo) => _prefs.setString('correo', correo);
  set nombre(String nombre) => _prefs.setString('nombre', nombre);
  set celular(int celular) => _prefs.setInt('celular', celular);
  set img(String img) => _prefs.setString('img', img);
  set id_rol(int id_rol) => _prefs.setInt('id_rol', id_rol);
  /* fecha_nac */
  set fecha_nac(String fecha_nac) => _prefs.setString('fecha_nac', fecha_nac);

  static void saveUserPreferences(Map<String, dynamic> dataMap) {
    if (kDebugMode) {
      /* print(dataMap["user"]["id"]);
      print(dataMap["user"]["correo"]);
      print(dataMap["user"]["nombre"]);
      print(dataMap["user"]["calular"]);
      print(dataMap["user"]["img"]);
      print(dataMap["user"]["id_rol"]);
      print(dataMap["user"]["fecha_nac"]); */
    }
    final prefs = UserPreferences();

    prefs.token = dataMap['token'];
    prefs.id = dataMap['user']['id'] as int;
    prefs.correo = dataMap["user"]["correo"] as String;
    prefs.nombre = dataMap["user"]["nombre"] as String;
    prefs.celular = dataMap["user"]["calular"] as int;
    prefs.img = dataMap["user"]["img"] as String;
    prefs.id_rol = dataMap["user"]["id_rol"] as int;
    prefs.fecha_nac = dataMap["user"]["fecha_nac"] as String;
  }

  void clearUser() {
    _prefs.setString('token', '');
    _prefs.setString('id', '');
    _prefs.setString('correo', '');
    _prefs.setString('nombre', '');
    _prefs.setInt('celular', 0);
    _prefs.setString('img', '');
    _prefs.setInt('id_rol', 0);
    _prefs.setString('fecha_nac', '');
  }
}
