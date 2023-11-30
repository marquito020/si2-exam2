import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/* TallerService */
class TallerService extends ChangeNotifier {
  List<Taller> tallerList = [];

  bool isLoading = false;

  TallerService() {
    getAllTaller();
  }

  Future<void> getAllTaller() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    tallerList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/taller');
      /* print(response.data); */

      final List<dynamic> allTaller = response.data['obj'];

      for (var element in allTaller) {
        final Taller taller = Taller.fromMap(element);
        if (taller.id_usuario == prefs.id) {
          tallerList.add(taller);
        }
      }
    } on DioException {
      // if (e.response != null) return [];
      // print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerNewTaller(Taller taller) async {
    final prefs = UserPreferences();
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      String x = taller.ubicacion.x.toString();
      String y = taller.ubicacion.y.toString();

      var data = {
        "nombre": taller.nombre,
        /* "ubicacion": taller.ubicacion, */
        "ubicacion": "($x,$y)",
        "id_usuario": prefs.id.toInt(),
      };

      print(data);

      final response = await dio.post('/api/taller', data: data);

      print(response.data);

      if (response.statusCode == 200) {
        tallerList.add(Taller.fromMap(response.data['obj']));
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      if (e.response != null) return false;
      print(e);
    }
    return false;
  }

  Future<void> resetTallerList() async {
    tallerList = [];
    isLoading = true;
    notifyListeners();

    // Aquí puedes realizar las operaciones necesarias para cargar los datos nuevamente
    await getAllTaller();

    isLoading = false;
    notifyListeners();
  }
}
