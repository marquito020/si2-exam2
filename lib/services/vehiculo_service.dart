import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:flutter/foundation.dart';

class VehiculoService extends ChangeNotifier {
  List<Vehiculo> vehiculoList = [];
  bool isLoading = false;

  VehiculoService() {
    getVehiculos();
  }

  Future<List<Vehiculo>> getVehiculos() async {
    isLoading = true;
    notifyListeners();
    vehiculoList = [];
    final prefs = UserPreferences();
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;
      final response = await dio.get('/api/vehiculo');
      final List<dynamic> data = response.data['obj'];
      /* vehiculoList = data.map((e) => Vehiculo.fromMap(e)).toList(); */
      for (var element in data) {
        final Vehiculo vehiculo = Vehiculo.fromMap(element);
        if (vehiculo.id_usuario == prefs.id) {
          vehiculoList.add(vehiculo);
        }
      }
      isLoading = false;
      /* print(prefs.nombre); */
      return vehiculoList;
    } on DioException {
      isLoading = false;
      return vehiculoList;
    } catch (e) {
      isLoading = false;
      return vehiculoList;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /* Register */
  Future<bool> registerVehiculo(Vehiculo vehiculo) async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    /* print(prefs.id); */
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;
      final response = await dio.post('/api/vehiculo', data: {
        "placa": vehiculo.placa.toString(),
        "anio": vehiculo.anio.toInt(),
        "modelo": vehiculo.modelo.toString(),
        "marca": vehiculo.marca.toString(),
        "color": vehiculo.color.toString(),
        "img": vehiculo.img.toString(),
        "id_usuario": prefs.id.toInt(),
      });
      final dataResponse = response.data;
      /* print(dataResponse); */
      final vehiculoResponse = Vehiculo.fromMap(dataResponse['obj']);
      vehiculoList = vehiculoList.reversed.toList();
      vehiculoList.add(vehiculoResponse);
      vehiculoList = vehiculoList.reversed.toList();
      if (dataResponse['obj'] != "") {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } on DioException {
      /* if (kDebugMode) {
        print(e.response?.data);
      } */
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

  /* Delete */
  Future<bool> deleteVehiculo(int? id) async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;
      final response = await dio.delete('/api/vehiculo/del/$id');
      final dataResponse = response.data;
      /* print(dataResponse); */
      if (dataResponse['obj'] != "") {
        /*  */
        vehiculoList.removeWhere((element) => element.id == id);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } on DioException {
      /* if (kDebugMode) {
        print(e.response?.data);
      } */
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

  void resetVehiculoList() async {
    vehiculoList = [];
    isLoading = true;
    notifyListeners();
    await getVehiculos();
    isLoading = false;
    notifyListeners();
  }
}
