import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/tarjeta_controller.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/widgets/tarjeta_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TarjetaCreateScreen extends StatelessWidget {
  const TarjetaCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          Text(
            "Tarjeta de Credito",
            style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          /* Image Credit Card */
          Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/credit_card.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ChangeNotifierProvider(
            create: (BuildContext context) => TarjetaFormController(
              Tarjeta(
                numero: "",
                cvs: "",
                fecha_ven: "",
                createdAt: DateTime.now(),
              ),
            ),
            child: const TarjetaForm(),
          )
        ]),
      ))),
    );
  }
}
