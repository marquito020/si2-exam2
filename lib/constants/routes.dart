import 'package:app_movil/screens/credit%20card/tarjeta_create_page.dart';
import 'package:app_movil/screens/credit%20card/tarjeta_index_page.dart';
import 'package:app_movil/screens/historial/list_historia_screen.dart';
import 'package:app_movil/screens/taller/register_taller_screen.dart';
import 'package:app_movil/screens/vehiculo/register_vehiculo_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/screens/index.dart';
import 'package:app_movil/shared_preferences/user_preferences.dart';

class Routes {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String vehiculos = '/vehiculos';
  static const String registerVehiculo = '/vehiculo/add';
  static const String tarjetas = '/tarjetas';
  static const String tarjetasCreate = '/tarjeta/add';
  static const String asistencia = '/asistencia';
  static const String servicios = '/servicios';
  static const String registerServicio = '/servicio/add';
  /* taller */
  static const String talleres = '/talleres';
  static const String registerTaller = '/taller/add';
  static const String tecnicos = '/tecnicos';
  static const String registerTecnico = '/tecnico/add';
  static const String notificaciones = '/notificaciones';
  static const String historial = '/historial';

  static Map<String, WidgetBuilder> getRoutes() {
    final prefs = UserPreferences();

    return <String, WidgetBuilder>{
      onboarding: (BuildContext context) => prefs.token != ''
          ? prefs.id_rol == 1
              ? const ListVehiculoScreen()
              : const ListServicioScreen()
          : const OnboardingScreen(),
      login: (BuildContext context) => const LoginScreen(),
      register: (BuildContext context) => const RegisterScreen(),
      vehiculos: (BuildContext context) => const ListVehiculoScreen(),
      registerVehiculo: (BuildContext context) => const RegistrarVehiculoPage(),
      tarjetas: (BuildContext context) => const TarjetaIndexScreen(),
      tarjetasCreate: (BuildContext context) => const TarjetaCreateScreen(),
      asistencia: (BuildContext context) => const RegisterAsistenciaScreen(),
      servicios: (BuildContext context) => const ListServicioScreen(),
      registerServicio: (BuildContext context) =>
          const RegisterServicioScreen(),
      talleres: (BuildContext context) => const ListTallerScreen(),
      registerTaller: (BuildContext context) => const RegisterTallerScreen(),
      tecnicos: (BuildContext context) => const ListaTecnicoScreen(),
      registerTecnico: (BuildContext context) => const RegisterTecnicosScreen(),
      notificaciones: (BuildContext context) => const ListaNotificacionesScreen(),
      historial: (BuildContext context) => const ListaHistoriaScreen(),

      /* home: (BuildContext context) => const HomePage(),
      perfil: (BuildContext context) => const PerfilPage(),
      property: (BuildContext context) => const PropertyPage(),
      creditCard: (BuildContext context) => const CreditCardPage(),
      creditCardCreate: (BuildContext context) => const CreditCardCreatePage(),
      procedure: (BuildContext context) => const ProcedurePage(), */
    };
  }
}
