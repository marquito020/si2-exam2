import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TarjetaService extends ChangeNotifier {
  List<Tarjeta> tarjetaList = [];

  bool isLoading = false;

  TarjetaService() {
    getAllTarjeta();
  }

  Future<void> getAllTarjeta() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    tarjetaList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/targeta');
      /* print(response.data); */

      final List<dynamic> allTarjeta = response.data['obj'];

      for (var element in allTarjeta) {
        final Tarjeta tarjeta = Tarjeta.fromMap(element);
        if (tarjeta.id_usuario == prefs.id) {
          tarjetaList.add(tarjeta);
        }
        /* TarjetaList.add(Tarjeta); */
      }
    } on DioException {
      // if (e.response != null) return [];
      // print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> registerNewTarjeta(Tarjeta tarjeta) async {
    final prefs = UserPreferences();
    try {
      final data = {};
      data['numero'] = tarjeta.numero;
      data['fecha_ven'] = tarjeta.fecha_ven;
      data['cvs'] = tarjeta.cvs;
      data['id_usuario'] = prefs.id;

      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      print(data);

      final response = await dio.post('/api/targeta', data: data);

      print(response.data);

      var dataTarjeta = response.data['obj'];

      final newTarjeta = Tarjeta(
          id: dataTarjeta['id'],
          numero: dataTarjeta['numero'],
          fecha_ven: dataTarjeta['fecha_ven'],
          cvs: dataTarjeta['cvs'],
          id_usuario: dataTarjeta['id_usuario'],
          createdAt: DateTime.parse(dataTarjeta['createdAt']));

      tarjetaList = tarjetaList.reversed.toList();
      tarjetaList.add(newTarjeta);
      tarjetaList = tarjetaList.reversed.toList();

      notifyListeners();
      return response.data;
    } on DioException catch (e) {
      print(e);
      if (e.response != null) return e.response?.data;
      return {'message': "Ocurrio un error en el server"};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /* Delete */
  Future<bool> deleteTarjeta(int id) async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;
      final response = await dio.delete('/api/targeta/$id');
      final dataResponse = response.data;
      print(dataResponse);
      if (dataResponse['obj'] != "") {
        tarjetaList.removeWhere((element) => element.id == id);
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

  Future<void> resetTarjetaList() async {
    tarjetaList = [];
    isLoading = true;
    notifyListeners();

    // Aquí puedes realizar las operaciones necesarias para cargar los datos nuevamente
    await getAllTarjeta();

    isLoading = false;
    notifyListeners();
  }

  Future<void> resetCreditCardList() async {
    tarjetaList = [];
    isLoading = true;
    notifyListeners();

    // Aquí puedes realizar las operaciones necesarias para cargar los datos nuevamente
    await getAllTarjeta();

    isLoading = false;
    notifyListeners();
  }
}
