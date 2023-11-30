import 'package:app_movil/models/img_model.dart';
import 'package:flutter/material.dart';

class ImgFomrController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Img img;
  bool _isLoading = false;

  ImgFomrController(this.img);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
