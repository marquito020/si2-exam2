import 'package:app_movil/constants/http_config.dart';
import 'package:app_movil/models/img_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImgService extends ChangeNotifier {
  List<Img> imgList = [];

  bool isLoading = false;

  ImgService() {
    getAllImg();
  }

  Future<bool> getAllImg() async {
    isLoading = true;
    notifyListeners();
    imgList = [];
    try {
      final dio = DioConfig.dio;
      final response = await dio.get('/api/img');
      final List<dynamic> allImg = response.data['obj'];
      for (var element in allImg) {
        final Img img = Img.fromMap(element);
        imgList.add(img);
      }
      isLoading = false;
      notifyListeners();
      return true;
    } on DioException {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /* Reset Imagenes */
  void resetImgList() async {
    imgList = [];
    isLoading = true;
    notifyListeners();
    await getAllImg();
    isLoading = false;
    notifyListeners();
  }
}
