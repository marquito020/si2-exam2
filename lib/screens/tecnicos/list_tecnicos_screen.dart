import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTecnicoScreen extends StatefulWidget {
  const ListaTecnicoScreen({super.key});

  @override
  State<ListaTecnicoScreen> createState() => _ListaTecnicoScreenState();
}

class _ListaTecnicoScreenState extends State<ListaTecnicoScreen> {
  List<Tecnico> tecnicos = [];
  @override
  Widget build(BuildContext context) {
    final tecnicoService = Provider.of<TecnicoService>(context);

    if (tecnicoService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    tecnicos = tecnicoService.tecnicoList;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Tecnicos'),
        /* Add */
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/tecnico/add');
            },
          )
        ],
      ),
      drawer: DrawerWidget(pageNombre: "Tecnicos"),
      body: ListView.builder(
        itemCount: tecnicos.length,
        itemBuilder: (BuildContext context, int index) {
          return TecnicoItem(tecnico: tecnicos[index]);
        },
      ),
    );
  }
}
