import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificacionService extends ChangeNotifier {
  List<Asistencia> notificacionList = [];

  bool isLoading = false;

  NotificacionService() {
    getAllAsistencia();
  }

  Future<void> getAllAsistencia() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    notificacionList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/asistencia');
      print(response.data);

      final List<dynamic> allAsistencia = response.data['obj'];

      for (var element in allAsistencia) {
        final Asistencia asistencia = Asistencia.fromMap(element);
        notificacionList.add(asistencia);
        /* notificacionList.add(Asistencia); */
      }
      isLoading = false;
      notifyListeners();
    } on DioException {
      // if (e.response != null) return [];
      // print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerNewAsistencia(Asistencia asistencia) async {
    isLoading = false;
    notifyListeners();
    try {
      final prefs = UserPreferences();
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      var data = {
        "id_usuario": prefs.id,
        "id_servicio": asistencia.id_servicio,
        "ubicacion": "(${asistencia.ubicacion?.x}, ${asistencia.ubicacion?.y})",
        "pago_targeta": asistencia.pago_targeta,
        "id_taller": 1,
        "id_tecnico": 1
      };
      print(data);

      final response = await dio.post('/api/asistencia', data: data);

      final dataResponse = response.data;
      print(dataResponse);
      final asistenciaResponse = Asistencia.fromMap(dataResponse['obj']);
      notificacionList = notificacionList.reversed.toList();
      notificacionList.add(asistenciaResponse);
      notificacionList = notificacionList.reversed.toList();
      if (dataResponse['obj'] != "") {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /* Update Asistencia */
  Future<bool> updateAsistencia(Asistencia asistencia) async {
    isLoading = false;
    notifyListeners();
    try {
      final prefs = UserPreferences();
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      var data = {
        /* "id_usuario": asistencia.id_usuario,
        "id_servicio": asistencia.id_servicio,
        "ubicacion": "(${asistencia.ubicacion?.x}, ${asistencia.ubicacion?.y})",
        "pago_targeta": asistencia.pago_targeta,
        "id_tecnico": 1, */
        "id_taller": asistencia.id_taller,
        "costo": asistencia.costo!.toInt(),
        "state_verif": true,
      };
      print(asistencia.id);
      print(data);

      final response =
          await dio.put('/api/asistencia/${asistencia.id}', data: data);

      final dataResponse = response.data;
      print(dataResponse);
      final asistenciaResponse = Asistencia.fromMap(dataResponse['obj']);
      notificacionList.removeWhere((element) => element.id == asistencia.id);
      notificacionList = notificacionList.reversed.toList();
      notificacionList.add(asistenciaResponse);
      notificacionList = notificacionList.reversed.toList();
      if (dataResponse['obj'] != "") {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetnotificacionList() {
    notificacionList = [];
    getAllAsistencia();
    notifyListeners();
  }
}
