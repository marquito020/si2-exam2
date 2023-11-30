import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoriaItem extends StatefulWidget {
  const HistoriaItem({Key? key, required this.historia});

  final Asistencia historia;

  @override
  State<HistoriaItem> createState() => _HistoriaItemState();
}

class _HistoriaItemState extends State<HistoriaItem> {
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
    /* Color getColorBasedOnState() {
      if (widget.historia.pago == true) {
        return Colors.green;
      } else if (widget.historia.state_verf == true) {
        return Colors.orange;
      } else {
        return Colors.white;
      }
    } */

    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 10),
      decoration: BoxDecoration(
        /* color: getColorBasedOnState(), */
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
                    Text("Id: ${widget.historia.id}"),
                    Text(
                        "Tarjeta?: ${widget.historia.pago_targeta == true ? "Si" : "No"}"),
                    /* Text("Id Usuario: ${widget.Historia.id_usuario}"), */
                    Text(
                        "Servicio: ${servicios.firstWhere((element) => element.id == widget.historia.id_servicio).servicio}"),
                    /* Corro Usuario */
                    Text(
                        "Correo Usuario: ${usersList.firstWhere((element) => element.id == widget.historia.id_usuario).correo}"),
                  ],
                ),
                const SizedBox(width: 10),
                /* Icon see */
                /* const Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 30,
                ), */
              ],
            )
          ],
        ),
      ),
    );
  }
}
