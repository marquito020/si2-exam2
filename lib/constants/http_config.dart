import 'package:dio/dio.dart';
// final prefs = UserPreferences();

class DioConfig {
  static final dio = Dio(BaseOptions(
    /* baseUrl: 'https://back-housesales-7bce9e05430c.herokuapp.com', */
    baseUrl: 'https://app-car-assistan-backend-2f259e7a068f.herokuapp.com',
    /* baseUrl: 'http://192.168.0.202:8000', */
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ));

  // void _configureDio() {
  //   _dio.options.baseUrl = HttpConfig.BASE_URL;
  //   _dio.options.connectTimeout = const Duration(seconds: 60);
  //   _dio.options.receiveTimeout = const Duration(seconds: 60);
  // _dio.options.sendTimeout = const Duration(seconds: 60);
  // }
}

class HttpConfig {
  /* static const String baseUrl = 'https://back-housesales-7bce9e05430c.herokuapp.com'; */

  /* static const String baseUrl = 'http://10.0.2.2:8000'; */
  /* static const String baseUrl = '192.168.0.202:8000'; */
  static const String baseUrl = 'https://app-car-assistan-backend-2f259e7a068f.herokuapp.com';

  // static Map<String, String> HEADERS = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.acceptHeader: 'application/json'
  // };
}

//    HttpHeaders.authorizationHeader: 'Bearer ${prefs.token}',