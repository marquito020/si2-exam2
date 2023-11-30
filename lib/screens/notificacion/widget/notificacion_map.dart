import 'package:app_movil/controllers/asistencia_controller.dart';
import 'package:app_movil/models/asistencia_model.dart';
import 'package:app_movil/screens/notificacion/widget/notificacion_map_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarAsistencia extends StatefulWidget {
  const RegistrarAsistencia({super.key, required this.asistencia});

  final Asistencia asistencia;

  @override
  State<RegistrarAsistencia> createState() => _RegistrarAsistenciaState();
}

class _RegistrarAsistenciaState extends State<RegistrarAsistencia> {
  @override
  void initState() {
    // TODO: implement initState
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
        child: NotificacionFormWidget(
          asistencia: widget.asistencia,
        ));
  }
}
