import 'package:app_movil/models/index.dart';
import 'package:flutter/material.dart';

/* Tecnico */
class TecnicoFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Tecnico tecnico;
  bool _isLoading = false;

  TecnicoFormController(this.tecnico);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}