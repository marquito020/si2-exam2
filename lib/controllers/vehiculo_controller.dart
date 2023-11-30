import 'package:flutter/material.dart';
import 'package:app_movil/models/index.dart';

class VehiculoFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Vehiculo vehiculo;
  bool _isLoading = false;

  VehiculoFormController(this.vehiculo);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
