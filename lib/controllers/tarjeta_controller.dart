import 'package:app_movil/models/index.dart';
import 'package:flutter/material.dart';

class TarjetaFormController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Tarjeta creditCard;
  bool _isLoading = false;

  TarjetaFormController(this.creditCard);

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}