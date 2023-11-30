import 'package:dio/dio.dart';
import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:flutter/foundation.dart';

class RolService extends ChangeNotifier {
  List<Rol> rolList = [];
  bool isLoading = false;

  RolService() {
    getRoles();
  }

  Future<List<Rol>> getRoles() async {
    isLoading = true;
    notifyListeners();
    rolList = [];
    try {
      final dio = DioConfig.dio;
      final response = await dio.get('/api/rol');
      final List<dynamic> data = response.data['obj'];
      rolList = data.map((e) => Rol.fromMap(e)).toList();
      isLoading = false;
      notifyListeners();
      return rolList;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      isLoading = false;
      return rolList;
    } catch (e) {
      isLoading = false;
      return rolList;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
