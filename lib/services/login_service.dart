import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:dio/dio.dart';
import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/index.dart';

class LoginService {
  // final _dio = Dio();

  // LoginService() {
  //   _configureDio();
  // }

  // void _configureDio() {
  //   _dio.options.baseUrl = HttpConfig.BASE_URL;
  //   _dio.options.connectTimeout = const Duration(seconds: 60);
  //   _dio.options.receiveTimeout = const Duration(seconds: 60);
  // _dio.options.sendTimeout = const Duration(seconds: 60);
  // }

  Future<Map<String, dynamic>> authenticate(User user) async {
    try {
      // final Map<String, String> data = {
      //   'email': user.email,
      //   'password': user.password
      // };
      // final response = await _dio.post('/api/login', data: data);
      final response =
          await DioConfig.dio.post('/api/auth/login', data: user.toMap());

      /*
      // Capturando las cookies
      String rawCookies = response.headers.map['set-cookie']!.join('; ');
      List<Cookie> cookies = parseCookies(rawCookies);

      // Procesar las cookies según sea necesario
      for (var cookie in cookies) {
        print('Cookie: ${cookie.name} = ${cookie.value}');
        // Puedes guardar, manipular o utilizar estas cookies aquí
      }
      */
      print(response.data);
      UserPreferences.saveUserPreferences(response.data);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) return e.response?.data;
      return {'message': "Ocurrio un error en el server"};
    } catch (e) {
      return {'message': "Ocurrio un error en el server"};
    }
  }
}
