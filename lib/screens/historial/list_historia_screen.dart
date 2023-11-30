import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/historial/widget/historia_item.dart';
import 'package:app_movil/screens/notificacion/widget/notificacion_item.dart';
import 'package:app_movil/services/asistencia_service.dart';
import 'package:app_movil/services/notificacion_service.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaHistoriaScreen extends StatefulWidget {
  const ListaHistoriaScreen({super.key});

  @override
  State<ListaHistoriaScreen> createState() => _ListaHistoriaScreenState();
}

class _ListaHistoriaScreenState extends State<ListaHistoriaScreen> {
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
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Historial'),
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
      drawer: DrawerWidget(pageNombre: "Historial"),
      body: ListView.builder(
        itemCount: asistenciaList.length,
        itemBuilder: (BuildContext context, int index) {
          return HistoriaItem(historia: asistenciaList[index]);
        },
      ),
    );
  }
}
