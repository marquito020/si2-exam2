import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicioFormWidget extends StatefulWidget {
  const ServicioFormWidget({super.key});

  @override
  State<ServicioFormWidget> createState() => _ServicioFormWidgetState();
}

class _ServicioFormWidgetState extends State<ServicioFormWidget> {
  List<Taller> talleres = [];
  @override
  Widget build(BuildContext context) {
    final servicioForm = Provider.of<ServicioFormController>(context);
    final servicioService = Provider.of<ServicioService>(context);
    final tallerService = Provider.of<TallerService>(context);
    if (tallerService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    talleres = tallerService.tallerList;
    return talleres.isEmpty
        ? const Center(
            child: Center(child: Text("No tiene Talleres Registrados")))
        : Form(
            key: servicioForm.formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) => servicioForm.servicio.servicio = value,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.note_add_outlined,
                      color: Colors.grey,
                    ),
                    /* prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 50,
              ), */
                    suffixIcon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) =>
                      servicioForm.servicio.descripcion = value,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.description_outlined,
                      color: Colors.grey,
                    ),
                    /* prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 50,
              ), */
                    suffixIcon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    servicioForm.servicio.precio =
                        value.isEmpty ? 0 : int.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el precio';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor ingrese un precio válido';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.grey,
                    ),
                    /* prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 50,
              ), */
                    suffixIcon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /* Dropward */
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Taller',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.home_repair_service_outlined,
                      color: Colors.grey,
                    ),
                    /* prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 50,
              ), */
                    suffixIcon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  value: servicioForm.servicio.id_taller,
                  onChanged: (value) {
                    setState(() {
                      servicioForm.servicio.id_taller = value as int;
                    });
                  },
                  items: talleres.map((taller) {
                    return DropdownMenuItem(
                      value: taller.id,
                      child: Text(taller.nombre),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    onPressed: servicioForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (!servicioForm.isValidForm()) return;
                            print(servicioForm.servicio.toJson());
                            bool response = await servicioService
                                .registerNewServicio(servicioForm.servicio);
                            if (response) {
                              Navigator.pushNamed(context, '/servicios');
                            } else {
                              // mostrar error
                              print(response);
                            }
                          },
                    child: const Text('Crear'),
                  ),
                ),
              ],
            ),
          );
  }
}
