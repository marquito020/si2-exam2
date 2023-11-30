import 'package:animate_do/animate_do.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/taller/widget/taller_map_widget.dart';
import 'package:flutter/material.dart';

class TallerItem extends StatelessWidget {
  const TallerItem({super.key, required this.taller});

  final Taller taller;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 0),
      child: GestureDetector(
        onTap: () {
          /* print("Tapped"); */
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TallerMapWidget(
                taller: taller,
              ),
            ),
          );
        },
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
                    Text("Nombre: ${taller.id}"),
                    Text("Nombre: ${taller.nombre}"),
                  ],
                ),
              ),
              /* const SizedBox(height: 10), */
            ],
          ),
        ),
      ),
    );
  }
}
