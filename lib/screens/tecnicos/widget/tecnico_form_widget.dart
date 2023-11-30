import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TecnicoForm extends StatefulWidget {
  const TecnicoForm({super.key});

  @override
  State<TecnicoForm> createState() => _TecnicoFormState();
}

class _TecnicoFormState extends State<TecnicoForm> {
  List<User> usersList = [];
  List<User> usersListNew = [];
  List<Taller> tallerList = [];
  List<Tecnico> tecnicoList = [];
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    usersList = userService.userList;
    print(usersList);
    final tallerService = Provider.of<TallerService>(context, listen: false);
    if (tallerService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    tallerList = tallerService.tallerList;

    final tecnicoService = Provider.of<TecnicoService>(context, listen: false);
    if (tecnicoService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    tecnicoList = tecnicoService.tecnicoList;

    for (var i = 0; i < usersList.length; i++) {
      for (var j = 0; j < tecnicoList.length; j++) {
        if (usersList[i].id == tecnicoList[j].id_usuario) {
          usersListNew.add(usersList[i]);
        }
      }
    }

    final tecnicoForm = Provider.of<TecnicoFormController>(context);

    return Form(
      key: tecnicoForm.formKey,
      child: Column(
        children: [
          TextFormField(
            /* Solo numero */
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Hora de inicio',
              prefixIcon: Icon(Icons.timer),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la hora de inicio';
              }
              return null;
            },
            onChanged: (value) => tecnicoForm.tecnico.hora_ini = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
            /* Solo numero */
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Hora de fin',
              prefixIcon: Icon(Icons.timer),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la hora de fin';
              }
              return null;
            },
            onChanged: (value) => tecnicoForm.tecnico.hora_fin = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
            /* Solo numero */
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Sueldo',
              prefixIcon: Icon(Icons.monetization_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el sueldo';
              }
              return null;
            },
            onChanged: (value) => tecnicoForm.tecnico.sueldo = int.parse(value),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person),
            ),
            items: usersList.map((User user) {
              return DropdownMenuItem(
                value: user.id,
                child: Text(user.correo),
              );
            }).toList(),
            onChanged: (value) => tecnicoForm.tecnico.id_usuario = value as int,
            validator: (value) {
              if (value == null || value == 0) {
                return 'Por favor seleccione un usuario';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Taller',
              prefixIcon: Icon(Icons.home),
            ),
            items: tallerList.map((Taller taller) {
              return DropdownMenuItem(
                value: taller.id,
                child: Text(taller.nombre),
              );
            }).toList(),
            onChanged: (value) => tecnicoForm.tecnico.id_taller = value as int,
            validator: (value) {
              if (value == null || value == 0) {
                return 'Por favor seleccione un taller';
              }
              return null;
            },
          ),
          /* Generar Tecnico */
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (!tecnicoForm.isValidForm()) return;
                tecnicoForm.tecnico.hora_fin =
                    tecnicoForm.tecnico.hora_fin + ":00";
                tecnicoForm.tecnico.hora_ini = tecnicoForm.tecnico.hora_ini +
                    ":00"; //Agregando los segundos
                final tecnicoService =
                    Provider.of<TecnicoService>(context, listen: false);
                final isSaved = await tecnicoService
                    .registerNewTecnico(tecnicoForm.tecnico);
                if (isSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Se ha guardado el tecnico'),
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No se ha podido guardar el tecnico'),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}
