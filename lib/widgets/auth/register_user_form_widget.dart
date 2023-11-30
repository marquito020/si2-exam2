import 'dart:io';

import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/cloudinary_service.dart';
import 'package:app_movil/services/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormRegisterUserWidget extends StatefulWidget {
  const FormRegisterUserWidget({
    super.key,
  });

  @override
  State<FormRegisterUserWidget> createState() => _FormRegisterUserWidgetState();
}

class _FormRegisterUserWidgetState extends State<FormRegisterUserWidget> {
  final registerService = RegisterUserService();

  XFile? selectedImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = pickedImage;
      print(selectedImage!.path);
    });
  }

  List<Rol> roles = [];

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormController>(context);
    final rolService = Provider.of<RolService>(context);
    if (rolService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    roles = rolService.rolList;
    TextEditingController dayController = TextEditingController();
    TextEditingController monthController = TextEditingController();
    TextEditingController yearController = TextEditingController();

    TextFormField buildDateInput(String label, TextEditingController controller,
        {int maxLength = 2}) {
      return TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength:
            maxLength, // Limita la entrada a dos dígitos para el día y mes
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      );
    }

    return Form(
      key: registerForm.formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => registerForm.user.correo = value,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) => registerForm.persona.nombre = value,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /* Celular */
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isEmpty) {
                registerForm.persona.celular = 0;
              } else {
                registerForm.persona.celular = int.parse(value);
              }
            },
            decoration: const InputDecoration(
              labelText: 'Celular',
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /* Rol */
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Rol',
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
            value: roles.isNotEmpty ? roles[0].id : null,
            items: roles.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.rol),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                registerForm.persona.id_rol = value as int;
                print(registerForm.persona.id_rol);
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          /* Imagen input */
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
          const SizedBox(height: 16),
          /* Calendar: Fecha Nacimiento*/
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Día
                  SizedBox(
                    width: 100,
                    child: buildDateInput('Día', dayController),
                  ),
                  // Mes
                  SizedBox(
                    width: 100,
                    child: buildDateInput('Mes', monthController),
                  ),
                  // Año
                  SizedBox(
                    width: 100,
                    child: buildDateInput('Año', yearController, maxLength: 4),
                  ),
                ],
              ),
              SizedBox(height: 20),
              /* ElevatedButton(
                onPressed: () {
                  // Aquí puedes usar fullDate como desees
                },
                child: Text('Obtener fecha de nacimiento'),
              ), */
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) => registerForm.user.password = value,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                /* Navigator.pushReplacementNamed(context, '/login'); */
                String day = dayController.text;
                String month = monthController.text;
                String year = yearController.text;

                // Concatenar la fecha completa
                String fullDate = '$year-$month-$day';
                print('Fecha de nacimiento: $fullDate');
                registerForm.persona.fecha_nac = fullDate;

                var image =
                    await CloudinaryService().urlCloudinary(selectedImage);
                registerForm.persona.img = image.toString();
                /* var image = urlCloudinary(selectedImage);
                        imagenController.text = image.toString();
                        registerScreen(); */
                /*  AuthController().registerScreen(
                      nombreController.text,
                      emailController.text,
                      passwordController.text,
                      registroController.text,
                      celularController.text,
                      image,
                      carreraController.text,
                      google,
                      isSexo,
                    ); */
                var response = await registerService.registerUser(
                  registerForm.user,
                  registerForm.persona,
                );
                print(response);
                if (response['obj'] != null) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
