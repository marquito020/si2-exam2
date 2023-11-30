import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/notificacion/widget/notificacion_map.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificacionItem extends StatefulWidget {
  const NotificacionItem({Key? key, required this.notificacion});

  final Asistencia notificacion;

  @override
  State<NotificacionItem> createState() => _NotificacionItemState();
}

class _NotificacionItemState extends State<NotificacionItem> {
  List<User> usersList = [];
  List<Servicio> servicios = [];
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    usersList = userService.userList;
    final servicioService = Provider.of<ServicioService>(context);
    if (servicioService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    servicios = servicioService.servicioList;
    Color getColorBasedOnState() {
      if (widget.notificacion.pago == true) {
        return Color.fromARGB(255, 85, 64, 95);
      } else if (widget.notificacion.state_verf == true) {
        return Color.fromARGB(255, 144, 145, 56);
      } else {
        return Colors.white;
      }
    }

    return GestureDetector(
      onTap: () {
        print("Tapped");
        /* RegistrarAsistencia(asistencia: notificacion); */
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrarAsistencia(
              asistencia: widget.notificacion,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 10),
        decoration: BoxDecoration(
          color: getColorBasedOnState(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Id: ${widget.notificacion.id}"),
                      Text(
                          "Tarjeta?: ${widget.notificacion.pago_targeta == true ? "Si" : "No"}"),
                      /* Text("Id Usuario: ${widget.notificacion.id_usuario}"), */
                      Text(
                          "Servicio: ${servicios.firstWhere((element) => element.id == widget.notificacion.id_servicio).servicio}"),
                      /* Corro Usuario */
                      Text(
                          "Correo Usuario: ${usersList.firstWhere((element) => element.id == widget.notificacion.id_usuario).correo}"),
                      widget.notificacion.pago == true
                          ? Text("Pago: Realizado",
                              style: TextStyle(color: Colors.white))
                          : Text("Pago: Pendiente",
                              style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  const SizedBox(width: 10),
                  /* Icon see */
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
