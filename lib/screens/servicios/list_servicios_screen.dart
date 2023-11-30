import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/servicios/widget/servicio_item.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListServicioScreen extends StatefulWidget {
  const ListServicioScreen({super.key});

  @override
  State<ListServicioScreen> createState() => _ListServicioScreenState();
}

class _ListServicioScreenState extends State<ListServicioScreen> {
  List<Servicio> servicios = [];
  List<Taller> talleres = [];
  @override
  Widget build(BuildContext context) {
    final servicioService = Provider.of<ServicioService>(context);
    final tallerService = Provider.of<TallerService>(context);

    if (servicioService.isLoading && tallerService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    servicios = servicioService.servicioList;
    talleres = tallerService.tallerList;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Servicios'),
        /* Add */
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/servicio/add');
            },
          )
        ],
      ),
      drawer: DrawerWidget(pageNombre: "Servicios"),
      body: ListView.builder(
        itemCount: servicios.length,
        itemBuilder: (BuildContext context, int index) {
          if (talleres.map((e) => e.id).contains(servicios[index].id_taller)) {
            return ServicioItem(servicio: servicios[index]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
          /* return ServicioItem(servicio: servicios[index]); */