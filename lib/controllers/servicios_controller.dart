import 'package:app_movil/models/servicio_model.dart';
import 'package:flutter/material.dart';

class ServicioFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Servicio servicio;
  bool _isLoading = false;

  ServicioFormController(this.servicio);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}