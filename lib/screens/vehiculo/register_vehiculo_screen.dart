import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/widgets/vehiculo/form_vehiculo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer_widget.dart';

class RegistrarVehiculoPage extends StatefulWidget {
  const RegistrarVehiculoPage({Key? key}) : super(key: key);

  @override
  _RegistrarVehiculoPageState createState() => _RegistrarVehiculoPageState();
}

class _RegistrarVehiculoPageState extends State<RegistrarVehiculoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Registrar Vehiculo'),
      ),
      drawer: Drawer(
        child: DrawerWidget(
          pageNombre: 'Vehiculos',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ChangeNotifierProvider(
                  create: (BuildContext context) => VehiculoFormController(
                    Vehiculo(
                      placa: "",
                      modelo: "",
                      color: "",
                      marca: "",
                      anio: 0,
                      createdAt: DateTime.now(),
                      id_usuario: 0,
                      img: "",
                    ),
                  ),
                  child: const VehiculoForm(),
                ),
              ],
            )),
      ),
    );
  }
}
