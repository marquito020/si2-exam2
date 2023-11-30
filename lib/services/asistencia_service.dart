import 'dart:io';

import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/cloudinary_service.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AsistenciaService extends ChangeNotifier {
  List<Asistencia> asistenciaList = [];

  bool isLoading = false;

  AsistenciaService() {
    getAllAsistencia();
  }

  Future<void> getAllAsistencia() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    asistenciaList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/asistencia');
      print(response.data);

      final List<dynamic> allAsistencia = response.data['obj'];

      for (var element in allAsistencia) {
        final Asistencia asistencia = Asistencia.fromMap(element);
        if (asistencia.id_usuario == prefs.id) {
          asistenciaList.add(asistencia);
        }
        /* AsistenciaList.add(Asistencia); */
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

  Future<bool> registerNewAsistencia(
      Asistencia asistencia, List<File> Imagenes) async {
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
      asistenciaList = asistenciaList.reversed.toList();
      asistenciaList.add(asistenciaResponse);
      asistenciaList = asistenciaList.reversed.toList();
      for (var element in Imagenes) {
        await uploadImage(element, asistenciaResponse.id!);
      }
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

  /* Subir Imagenes */
  Future<bool> uploadImage(File path, int id) async {
    isLoading = false;
    notifyListeners();
    try {
      final prefs = UserPreferences();
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      var urlImage = await CloudinaryService().urlCloudinary(path);
      String url = urlImage.toString();

      if (urlImage == null) {
        return false;
      }

      var data = {
        "img": url,
        "id_asistencia": id.toInt(),
      };

      print(data);

      final response = await dio.post('/api/img', data: data);

      final dataResponse = response.data;
      /* print(dataResponse);
      final asistenciaResponse = Asistencia.fromMap(dataResponse['obj']);
      asistenciaList = asistenciaList.reversed.toList();
      asistenciaList.add(asistenciaResponse);
      asistenciaList = asistenciaList.reversed.toList(); */
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
  Future<bool> updateAsistencia(int id) async {
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
        "pago": true,
      };
      print(data);

      final response =
          await dio.put('/api/asistencia/$id', data: data);

      final dataResponse = response.data;
      print(dataResponse);
      final asistenciaResponse = Asistencia.fromMap(dataResponse['obj']);
      asistenciaList.removeWhere((element) => element.id == id);
      asistenciaList = asistenciaList.reversed.toList();
      asistenciaList.add(asistenciaResponse);
      asistenciaList = asistenciaList.reversed.toList();
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

  void resetAsistenciaList() {
    asistenciaList = [];
    getAllAsistencia();
    notifyListeners();
  }
}
