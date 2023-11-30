import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/screens/credit%20card/widgets/tarjeta_item.dart';
import 'package:app_movil/services/tarjeta_service.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
/* import 'package:venta_casas/src/shared_preferences/user_preferences.dart'; */

class TarjetaIndexScreen extends StatefulWidget {
  const TarjetaIndexScreen({super.key});

  @override
  State<TarjetaIndexScreen> createState() => _TarjetaIndexScreenState();
}

class _TarjetaIndexScreenState extends State<TarjetaIndexScreen> {
  List<Tarjeta> creditCardListFilter = [];

  @override
  Widget build(BuildContext context) {
    final tarjetaService = Provider.of<TarjetaService>(context);

    if (tarjetaService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    creditCardListFilter = tarjetaService.tarjetaList;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Tarjeta de Credito",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
      ),
      drawer: DrawerWidget(pageNombre: "Pagos"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mis tarjetas de credito',
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    /* print("Agregar tarjeta de credito"); */
                    Navigator.pushNamed(context, '/tarjeta/add');
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemCount: creditCardListFilter.length,
              itemBuilder: (BuildContext context, int index) {
                return CreditCardItem(creditCard: creditCardListFilter[index]);
              },
            )),
          ],
        ),
      ),
    );
  }
}
