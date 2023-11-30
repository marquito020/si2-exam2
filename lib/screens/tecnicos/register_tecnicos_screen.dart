import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/tecnicos/widget/tecnico_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTecnicosScreen extends StatefulWidget {
  const RegisterTecnicosScreen({super.key});

  @override
  State<RegisterTecnicosScreen> createState() => _RegisterTecnicosScreenState();
}

class _RegisterTecnicosScreenState extends State<RegisterTecnicosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: const Text('Registro de Tecnicos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider(
            create: (BuildContext context) => TecnicoFormController(Tecnico(
              hora_ini: "",
              hora_fin: "",
              id_taller: 0,
              sueldo: 0,
              id_usuario: 0,
            )),
            child: const TecnicoForm(),
          ),
        ),
      ),
    );
  }
}
