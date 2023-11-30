import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/index.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100, left: 25),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Iniciar sesión',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
          ),
          /* FormLoginScreenWidget(), */
          ChangeNotifierProvider(
            create: (BuildContext context) =>
                LoginFormController(User(correo: "", password: "")),
            child: FormLoginScreenWidget(),
          ),
        ],
      ),
    );
  }
}
