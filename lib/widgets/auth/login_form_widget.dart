import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/services/asistencia_service.dart';
import 'package:app_movil/services/img_service.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/services/notificacion_service.dart';
import 'package:app_movil/services/tarjeta_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormLoginScreenWidget extends StatelessWidget {
  FormLoginScreenWidget({
    super.key,
  });

  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormController>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Form(
        key: loginForm.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginForm.user.correo = value,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: primary,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: primary,
                ),
                /* prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 50,
                ), */
                suffixIcon: Icon(
                  Icons.check,
                  color: primary,
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
              onChanged: (value) => loginForm.user.password = value,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: primary,
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: primary,
                ),
                /* prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 50,
                ), */
                constraints: BoxConstraints.expand(height: 50),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: primary,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  /* Navigator.pushReplacementNamed(
                      context, '/solicitarViaje'); */
                  var response =
                      await LoginService().authenticate(loginForm.user);
                  /* if (kDebugMode) {
                    print(response["token"]);
                  } */
                  if (response['token'] != null && response['token'] != '') {
                    restartProviders(context);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Bienvenido"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response['msg']),
                        backgroundColor: Colors.red,
                      ),
                    );
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
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: background,
                    ),
                  ),
                ),
              ),
            ),

            /* Register */
            SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes una cuenta?',
                      style: TextStyle(
                        fontSize: 14,
                        color: primary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void restartProviders(BuildContext context) {
    final tarjetaService = Provider.of<TarjetaService>(context, listen: false);
    tarjetaService.resetCreditCardList();

    final tallerService = Provider.of<TallerService>(context, listen: false);
    tallerService.resetTallerList();

    final servicioService =
        Provider.of<ServicioService>(context, listen: false);
    servicioService.resetServicioList();

    final asistenciaService =
        Provider.of<AsistenciaService>(context, listen: false);
    asistenciaService.resetAsistenciaList();

    final vehiculoService =
        Provider.of<VehiculoService>(context, listen: false);
    vehiculoService.resetVehiculoList();

    final notificacionService =
        Provider.of<NotificacionService>(context, listen: false);
    notificacionService.resetnotificacionList();

    final imagenService = Provider.of<ImgService>(context, listen: false);
    imagenService.resetImgList();
  }
}
