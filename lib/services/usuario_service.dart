import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  List<User> userList = [];

  bool isLoading = false;

  UserService() {
    getAllUsers();
  }

  Future<bool> getAllUsers() async {
    isLoading = true;
    notifyListeners();
    final prefs = UserPreferences();
    userList = [];

    try {
      final dio = DioConfig.dio;
      dio.options.headers['token'] = prefs.token;

      final response = await dio.get('/api/usuario');
      print(response.data);

      final List<dynamic> allPersonas = response.data['obj'];

      for (var element in allPersonas) {
        final User persona = User.fromMap(element);
        userList.add(persona);
      }

      print(userList);

      isLoading = false;

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
}
