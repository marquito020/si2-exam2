import 'package:app_movil/models/index.dart';
import 'package:flutter/material.dart';

/* Taller */
class TallerFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Taller taller;
  bool _isLoading = false;

  TallerFormController(this.taller);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}