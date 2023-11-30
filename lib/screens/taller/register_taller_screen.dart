import 'dart:math';

import 'package:app_movil/controllers/taller_controller.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/taller/widget/taller_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTallerScreen extends StatefulWidget {
  const RegisterTallerScreen({Key? key}) : super(key: key);

  @override
  _RegisterTallerScreenState createState() => _RegisterTallerScreenState();
}

class _RegisterTallerScreenState extends State<RegisterTallerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => TallerFormController(
              Taller(
                nombre: "",
                ubicacion: const Point(0, 0),
                id_usuario: 0,
              ),
            ),
        child: const TallerFormWidget());
  }
}
