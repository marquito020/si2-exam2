import 'dart:io';

import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/services/cloudinary_service.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class VehiculoForm extends StatefulWidget {
  const VehiculoForm({Key? key}) : super(key: key);

  @override
  _VehiculoFormState createState() => _VehiculoFormState();
}

class _VehiculoFormState extends State<VehiculoForm> {
  String img = '';
  XFile? selectedImage;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = pickedImage;
      /* print(selectedImage!.path); */
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoService =
        Provider.of<VehiculoService>(context, listen: false);
    final vehiculoForm = Provider.of<VehiculoFormController>(context);
    return Form(
      key: vehiculoForm.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Número de placa',
              prefixIcon: Icon(Icons.directions_car),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value == "0") {
                return 'Por favor ingrese el número de placa';
              }
              return null;
            },
            onChanged: (value) => vehiculoForm.vehiculo.placa = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Modelo de vehículo',
              prefixIcon: Icon(Icons.model_training),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el modelo de vehículo';
              }
              return null;
            },
            onChanged: (value) => vehiculoForm.vehiculo.modelo = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Año de vehículo',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            /* Solo number */
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty || value == "0") {
                return 'Por favor ingrese el año de vehículo';
              }
              return null;
            },
            onChanged: (value) => vehiculoForm.vehiculo.anio =
                (value == "" ? 0 : int.parse(value)),
          ),
          const SizedBox(height: 10),
          /* Marca */
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Marca de vehículo',
              prefixIcon: Icon(Icons.car_rental),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la marca de vehículo';
              }
              return null;
            },
            onChanged: (value) => vehiculoForm.vehiculo.marca = value,
          ),
          const SizedBox(height: 10),
          /* Color */
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Color de vehículo',
              prefixIcon: Icon(Icons.color_lens),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el color de vehículo';
              }
              return null;
            },
            onChanged: (value) => vehiculoForm.vehiculo.color = value,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                foregroundColor: primary,
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined),
                  SizedBox(width: 10),
                  Text('Seleccionar imagen'),
                ],
              )),
          const SizedBox(height: 16),
          if (selectedImage != null)
            Image.file(
              File(selectedImage!.path),
              height: 200,
            ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                /* Validate */
                if (!vehiculoForm.isValidForm()) return;

                /* Upload image */
                if (selectedImage != null) {
                  final response =
                      await CloudinaryService().urlCloudinary(selectedImage);
                  if (response != null) {
                    vehiculoForm.vehiculo.img = response;
                  }
                } else {
                  /* Mensage Error */
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      title: const Text(
                        'Error',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      content: const Text('Por favor seleccione una imagen'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                /* Register */
                final response = await vehiculoService.registerVehiculo(
                  vehiculoForm.vehiculo,
                );

                /* Mensage Success */
                if (response) {
                  // ignore: use_build_context_synchronously
                  succesModal(context, "Vehículo registrado");
                } else {
                  // ignore: use_build_context_synchronously
                  failedModal(context, "Error al registrar vehículo");
                }
              },
              child: const Text('Registrar vehículo'),
            ),
          ),
        ],
      ),
    );
  }
}
