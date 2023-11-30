import 'package:app_movil/constants/routes.dart';
import 'package:app_movil/services/asistencia_service.dart';
import 'package:app_movil/services/img_service.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/services/notificacion_service.dart';
import 'package:app_movil/services/servicios_service.dart';
import 'package:app_movil/services/taller_service.dart';
import 'package:app_movil/services/tarjeta_service.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RolService()),
        ChangeNotifierProvider(create: (context) => VehiculoService()),
        ChangeNotifierProvider(create: (context) => TarjetaService()),
        ChangeNotifierProvider(create: (context) => ServicioService()),
        ChangeNotifierProvider(create: (context) => TallerService()),
        ChangeNotifierProvider(create: (context) => AsistenciaService()),
        ChangeNotifierProvider(create: (context) => TecnicoService()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => NotificacionService()),
        ChangeNotifierProvider(create: (context) => ImgService()),
      ],
      child: MaterialApp(
        title: 'Servicio Drivert',
        themeMode: ThemeMode.dark,
        themeAnimationCurve: Curves.linear,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        initialRoute: Routes.onboarding,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
