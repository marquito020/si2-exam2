import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key, required this.pageNombre}) : super(key: key);
  final String pageNombre;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  /* Shared Preferences */
  final prefs = UserPreferences();
  @override
  void initState() {
    prefs.initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: background,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Acción al presionar el botón
            },
            child: Container(
              padding: const EdgeInsets.only(top: 25),
              color: primary,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: Image.network(
                            prefs.img.toString(),
                          ).image,
                          radius: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            prefs.nombre.toString(),
                            style: const TextStyle(
                              color: containerprimaryAccent,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            prefs.celular.toString(),
                            style: const TextStyle(
                              color: containerprimaryAccent,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: containerprimaryAccent,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                prefs.id_rol == 1
                    ? Column(
                        children: [
                          ListTile(
                            title: const Text(
                              "Vehiculos",
                            ),
                            selected:
                                widget.pageNombre == "Vehiculos" ? true : false,
                            horizontalTitleGap: 0.0,
                            leading: const Icon(Icons.directions_car),
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/vehiculos');
                            },
                          ),
                          ListTile(
                            title: const Text("Asistencias"),
                            selected: widget.pageNombre == "Asistencias"
                                ? true
                                : false,
                            leading: const Icon(Icons.directions_car),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/asistencia');
                            },
                          ),
                          /* Historial */
                          ListTile(
                            title: const Text("Historial"),
                            selected:
                                widget.pageNombre == "Historial" ? true : false,
                            leading: const Icon(Icons.history),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/historial');
                            },
                          ),
                          /* Pagos */
                          ListTile(
                            title: const Text("Pagos"),
                            selected:
                                widget.pageNombre == "Pagos" ? true : false,
                            leading: const Icon(Icons.payment),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/tarjetas');
                            },
                          ),
                        ],
                      )
                    :
                    /* Metodo de pago */
                    Column(
                        children: [
                          /* Taller */
                          ListTile(
                            title: const Text("Talleres"),
                            subtitle: const Text("Gestionar talleres"),
                            selected:
                                widget.pageNombre == "Talleres" ? true : false,
                            leading: const Icon(Icons.home_repair_service),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/talleres');
                            },
                          ),
                          ListTile(
                            title: const Text("Servicios"),
                            subtitle: const Text("Gestionar servicios"),
                            selected:
                                widget.pageNombre == "Servicios" ? true : false,
                            leading: const Icon(Icons.payment),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/servicios');
                            },
                          ),
                          /* Tecnicos */
                          ListTile(
                            title: const Text("Tecnicos"),
                            subtitle: const Text("Gestionar tecnicos"),
                            selected:
                                widget.pageNombre == "Tecnicos" ? true : false,
                            leading: const Icon(Icons.person),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/tecnicos');
                            },
                          ),
                          /* Notificaciones */
                          ListTile(
                            title: const Text("Notificaciones"),
                            subtitle: const Text("Gestionar notificaciones"),
                            selected: widget.pageNombre == "Notificaciones"
                                ? true
                                : false,
                            leading: const Icon(Icons.notifications),
                            horizontalTitleGap: 0.0,
                            selectedColor: primary,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/notificaciones');
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Cerrar sesión"),
            leading: const Icon(Icons.logout),
            horizontalTitleGap: 0.0,
            onTap: () async {
              prefs.clearUser();
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
