import 'package:animate_do/animate_do.dart';
import 'package:app_movil/services/index.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/models/index.dart';
import 'package:provider/provider.dart';

class VehiculoItem extends StatefulWidget {
  const VehiculoItem({super.key, required this.vehiculo});

  final Vehiculo vehiculo;

  @override
  State<VehiculoItem> createState() => _VehiculoItemState();
}

class _VehiculoItemState extends State<VehiculoItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoService =
        Provider.of<VehiculoService>(context, listen: false);
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      /* image assets */
                      image:
                          Image.network(widget.vehiculo.img.toString()).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Placa: ${widget.vehiculo.placa}"),
                          Text("Marca: ${widget.vehiculo.marca}"),
                          Text("Modelo: ${widget.vehiculo.modelo}"),
                          Text("Color: ${widget.vehiculo.color}"),
                        ],
                      ),
                      /* Delete */
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () async {
                          /* bool response =  */ await vehiculoService
                              .deleteVehiculo(widget.vehiculo.id);
                          /* if (mounted) {
                            // Verifica si el widget está montado
                            if (response) {
                              succesModal(context, "Vehiculo eliminado");
                            } else {
                              failedModal(
                                  context, "Error al eliminar vehiculo");
                            }
                          } */
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
