import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TecnicoService extends ChangeNotifier {
  List<Tecnico> tecnicoList = [];

  bool isLoading = false;

  TecnicoService() {
    getAllTecnico();
  }

  Future<bool> getAllTecnico() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    tecnicoList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/tecnicos');
      /* print(response.data); */

      final List<dynamic> allTecnico = response.data['obj'];

      for (var element in allTecnico) {
        final Tecnico tecnico = Tecnico.fromMap(element);
        tecnicoList.add(tecnico);
      }
      return true;
    } on DioException {
      // if (e.response != null) return [];
      // print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerNewTecnico(Tecnico tecnico) async {
    final prefs = UserPreferences();
    try {
      final data = {
        "sueldo": tecnico.sueldo.toString(),
        "hora_ini": tecnico.hora_ini,
        "hora_fin": tecnico.hora_fin,
        "id_usuario": tecnico.id_usuario,
        "id_taller": tecnico.id_taller,
      };

      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      print(data);

      final response = await dio.post('/api/tecnicos', data: data);
      print(response.data);

      final newTecnico = Tecnico.fromMap(response.data['obj']);
      tecnicoList.add(newTecnico);
      return true;
    } on DioException catch (e) {
      // if (e.response != null) return [];
      print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
