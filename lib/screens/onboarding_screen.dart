import 'package:app_movil/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: Stack(
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 15),
                    child: Column(
                      children: [
                        /* Imagen */
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/logo.png',
                            height: 350,
                            width: 190,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          /* child: Text(
                        'Bienvenido a',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ), */
                        ),
                        /* UNIVERSIDAD TAXI */
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'CarCareDirect',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        /* Texto */
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Servicio técnico automotriz a tu puerta. Reparaciones y mantenimiento sin salir de casa. Tu auto, nuestro cuidado.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                              /* Navigator.pushNamed(context, '/login'); */
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: containerprimaryAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Iniciar sesión'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              /* Navigator.pushReplacementNamed(context, '/register'); */
                              Navigator.pushNamed(context, '/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary[100],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Registrarse'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ));
  }
}
