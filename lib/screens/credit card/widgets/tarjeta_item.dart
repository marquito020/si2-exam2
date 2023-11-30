import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/models/index.dart';

class CreditCardItem extends StatelessWidget {
  const CreditCardItem({super.key, required this.creditCard});

  final Tarjeta creditCard;

  @override
  Widget build(BuildContext context) {
    String monthCreditCard = creditCard.fecha_ven.substring(5, 7);
    String yearCreditCard = creditCard.fecha_ven.substring(2, 4);
    return FadeIn(
      delay: const Duration(milliseconds: 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  /* image assets */
                  image: AssetImage("assets/credit_card.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre: ${creditCard.numero}"),
                  Text("Numero: ${creditCard.fecha_ven}"),
                  /* Text("Expira: ${creditCard.expirationDate}"), */
                  Text("Expira: $monthCreditCard/$yearCreditCard"),
                  Text("CVV: ${creditCard.cvs}"),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
