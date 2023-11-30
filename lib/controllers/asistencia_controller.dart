import 'package:app_movil/models/index.dart';
import 'package:flutter/material.dart';

class AsistenciaFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Asistencia asistencia;
  bool _isLoading = false;

  AsistenciaFormController(this.asistencia);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
