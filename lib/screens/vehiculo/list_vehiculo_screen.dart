import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:app_movil/widgets/vehiculo/item_vehiculo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListVehiculoScreen extends StatefulWidget {
  const ListVehiculoScreen({super.key});

  @override
  State<ListVehiculoScreen> createState() => _ListVehiculoScreenState();
}

class _ListVehiculoScreenState extends State<ListVehiculoScreen> {
  List<Vehiculo> vehiculos = [];
  @override
  Widget build(BuildContext context) {
    final vehiculoService = Provider.of<VehiculoService>(context);

    if (vehiculoService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    vehiculos = vehiculoService.vehiculoList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Vehiculos'),
        /* Add */
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/vehiculo/add');
            },
          )
        ],
      ),
      drawer: DrawerWidget(pageNombre: "Vehiculos"),
      body: ListView.builder(
        itemCount: vehiculos.length,
        itemBuilder: (BuildContext context, int index) {
          return VehiculoItem(vehiculo: vehiculos[index]);
        },
      ),
    );
  }
}
