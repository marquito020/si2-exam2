import 'package:animate_do/animate_do.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TecnicoItem extends StatefulWidget {
  const TecnicoItem({super.key, required this.tecnico});

  final Tecnico tecnico;

  @override
  State<TecnicoItem> createState() => _TecnicoItemState();
}

class _TecnicoItemState extends State<TecnicoItem> {
  List<User> usersList = [];
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    usersList = userService.userList;
    return FadeIn(
      delay: const Duration(milliseconds: 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id: ${widget.tecnico.id}"),
                  Text(
                      "Correo: ${usersList.firstWhere((element) => element.id == widget.tecnico.id_usuario).correo}"),
                  Text("Hora Inicio: ${widget.tecnico.hora_ini}"),
                  Text("Hora Fin: ${widget.tecnico.hora_fin}"),
                  Text("Sueldo: ${widget.tecnico.sueldo}"),
                ],
              ),
            ),
            /* const SizedBox(height: 10), */
          ],
        ),
      ),
    );
  }
}
