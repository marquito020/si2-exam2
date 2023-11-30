import 'package:animate_do/animate_do.dart';
import 'package:app_movil/models/servicio_model.dart';
import 'package:flutter/material.dart';

class ServicioItem extends StatelessWidget {
  const ServicioItem({super.key, required this.servicio});

  final Servicio servicio;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 10),
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
                  Text("Servicio: ${servicio.servicio}"),
                  Text("Descripcion: ${servicio.descripcion}"),
                  /* Text("Expira: ${creditCard.expirationDate}"), */
                  Text("Precio: ${servicio.precio}"),
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
