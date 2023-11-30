import 'package:app_movil/controllers/asistencia_controller.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAsistenciaScreen extends StatefulWidget {
  const RegisterAsistenciaScreen({Key? key}) : super(key: key);

  @override
  _RegisterAsistenciaScreenState createState() =>
      _RegisterAsistenciaScreenState();
}

class _RegisterAsistenciaScreenState extends State<RegisterAsistenciaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AsistenciaFormController(
              Asistencia(
                id_servicio: 0,
                id_usuario: 0,
                pago_targeta: false,
              ),
            ),
        child: const AsistenciaFormWidget());
  }
}
