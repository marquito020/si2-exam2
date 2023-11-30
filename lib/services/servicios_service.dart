import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/servicio_model.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ServicioService extends ChangeNotifier {
  List<Servicio> servicioList = [];

  bool isLoading = false;

  ServicioService() {
    getAllServicio();
  }

  Future<void> getAllServicio() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    servicioList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/servicio');
      /* print(response.data); */

      final List<dynamic> allServicio = response.data['obj'];

      for (var element in allServicio) {
        final Servicio servicio = Servicio.fromMap(element);
        servicioList.add(servicio);
      }
    } on DioException {
      // if (e.response != null) return [];
      // print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerNewServicio(Servicio servicio) async {
    final prefs = UserPreferences();
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      var data = {
        "precio": servicio.precio.toInt(),
        "servicio": servicio.servicio,
        "descripcion": servicio.descripcion,
        "id_taller": servicio.id_taller?.toInt(),
      };

      print(data);

      final response = await dio.post('/api/servicio', data: data);

      final dataResponse = response.data;
      if (dataResponse['obj'] != "") {
        final Servicio newServicio = Servicio.fromMap(dataResponse['obj']);
        servicioList.add(newServicio);
        notifyListeners();
        return true;
      }
      return false;
    } on DioException catch (e) {
      print(e);
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

  /* Reset Servicio */
  void resetServicioList() async {
    servicioList = [];
    isLoading = true;
    notifyListeners();
    await getAllServicio();
    isLoading = false;
    notifyListeners();
  }
}
