import 'package:flutter/material.dart';
// import 'dart:io';

import 'package:app_movil/models/index.dart';

class RegisterFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user;
  Persona persona;

  bool _isLoading = false;

  RegisterFormController(this.user, this.persona);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // void uploadPhoto(String path) {
  //   File? newPictureFile = File.fromUri(Uri(path: path));
  //   person.photo = path;
  //   notifyListeners();
  // }
}
