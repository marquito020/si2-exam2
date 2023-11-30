import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTallerScreen extends StatefulWidget {
  const ListTallerScreen({super.key});

  @override
  State<ListTallerScreen> createState() => _ListTallerScreenState();
}

class _ListTallerScreenState extends State<ListTallerScreen> {
  List<Taller> talleres = [];
  @override
  Widget build(BuildContext context) {
    final tallerService = Provider.of<TallerService>(context);

    if (tallerService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    talleres = tallerService.tallerList;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Talleres'),
        /* Add */
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/taller/add');
            },
          )
        ],
      ),
      drawer: DrawerWidget(pageNombre: "Talleres"),
      body: ListView.builder(
        itemCount: talleres.length,
        itemBuilder: (BuildContext context, int index) {
          return TallerItem(taller: talleres[index]);
        },
      ),
    );
  }
}
