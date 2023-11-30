import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/notificacion/widget/notificacion_item.dart';
import 'package:app_movil/services/asistencia_service.dart';
import 'package:app_movil/services/notificacion_service.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaNotificacionesScreen extends StatefulWidget {
  const ListaNotificacionesScreen({super.key});

  @override
  State<ListaNotificacionesScreen> createState() =>
      _ListaNotificacionesScreenState();
}

class _ListaNotificacionesScreenState extends State<ListaNotificacionesScreen> {
  List<Asistencia> asistenciaList = [];
  @override
  Widget build(BuildContext context) {
    final asistencia = Provider.of<NotificacionService>(context);

    if (asistencia.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    asistenciaList = asistencia.notificacionList;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title:
            const Text('Notificaciones', style: TextStyle(color: background)),
        /* Add */
        /* actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/tecnico/add');
            },
          )
        ], */
      ),
      drawer: DrawerWidget(pageNombre: "Notificaciones"),
      body: ListView.builder(
        itemCount: asistenciaList.length,
        itemBuilder: (BuildContext context, int index) {
          return NotificacionItem(notificacion: asistenciaList[index]);
        },
      ),
    );
  }
}
