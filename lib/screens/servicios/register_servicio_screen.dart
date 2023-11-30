import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/widgets/servicio_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer_widget.dart';

class RegisterServicioScreen extends StatefulWidget {
  const RegisterServicioScreen({super.key});

  @override
  State<RegisterServicioScreen> createState() => _RegisterServicioScreenState();
}

class _RegisterServicioScreenState extends State<RegisterServicioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Registrar Servicio'),
      ),
      drawer: Drawer(
        child: DrawerWidget(
          pageNombre: 'Servicios',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ChangeNotifierProvider(
                  create: (BuildContext context) => ServicioFormController(
                    Servicio(
                      servicio: "",
                      descripcion: "",
                      precio: 0,
                      createdAt: DateTime.now(),
                    ),
                  ),
                  child: const ServicioFormWidget(),
                ),
              ],
            )),
      ),
    );
  }
}
