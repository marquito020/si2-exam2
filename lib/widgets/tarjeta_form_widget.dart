import 'package:app_movil/controllers/tarjeta_controller.dart';
import 'package:app_movil/services/tarjeta_service.dart';
import 'package:app_movil/ui/login_input_decortation_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarjetaForm extends StatelessWidget {
  const TarjetaForm({super.key});

  @override
  Widget build(BuildContext context) {
    String monthCreditCard = "";
    String yearCreditCard = "";
    final tarjetaService = Provider.of<TarjetaService>(context, listen: false);
    final tarjetaForm = Provider.of<TarjetaFormController>(context);
    return Form(
      /* Form Credit Card */
      key: tarjetaForm.formKey,
      child: Column(
        children: [
          // nombre field
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
          ),

          const SizedBox(height: 15),

          // numero field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: inputDecoration(
                hintText: 'Numero',
                labelText: 'Numero',
              ),
              onChanged: (value) {
                if (value.length <= 16) {
                  // Restringir a 16 caracteres
                  tarjetaForm.creditCard.numero = value;
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su numero';
                }
                if (value.length != 16) {
                  // Validar que tenga exactamente 16 caracteres
                  return 'El número debe tener 16 dígitos';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 15),

          // Fecha field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(
                      hintText: 'MM',
                      labelText: 'Mes',
                    ),
                    onChanged: (value) {
                      if (value.length <= 2) {
                        // Restringir a 2 caracteres
                        monthCreditCard = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el mes';
                      }
                      if (value.length != 2 ||
                          int.tryParse(value) == null ||
                          int.parse(value) < 1 ||
                          int.parse(value) > 12) {
                        return 'Por favor ingrese un mes válido (MM)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(
                      hintText: 'AA',
                      labelText: 'Año',
                    ),
                    onChanged: (value) {
                      if (value.length <= 4) {
                        // Restringir a 4 caracteres
                        yearCreditCard = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el año';
                      }
                      if (value.length != 4 || int.tryParse(value) == null) {
                        return 'Por favor ingrese un año válido (AAAA)';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // cvv field
          // cvv field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: inputDecoration(
                hintText: 'CVV',
                labelText: 'CVV',
              ),
              onChanged: (value) {
                if (value.length <= 3) {
                  // Restringir a 3 caracteres
                  tarjetaForm.creditCard.cvs = value;
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su cvv';
                }
                if (value.length != 3) {
                  // Validar que tenga exactamente 3 caracteres
                  return 'El CVV debe tener 3 dígitos';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 15),

          // boton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton.icon(
              onPressed: tarjetaForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final navigator = Navigator.of(context);
                      if (tarjetaForm.formKey.currentState!.validate()) {
                        print('Guardar tarjeta de crédito');

                        tarjetaForm.creditCard.fecha_ven =
                            "$yearCreditCard-$monthCreditCard-01";

                        tarjetaForm.isLoading = true;

                        final response =
                            await tarjetaService.registerNewTarjeta(
                          tarjetaForm.creditCard,
                        );

                        tarjetaForm.isLoading = false;

                        if (response.containsKey('error') ||
                            response.containsKey('msg')) {
                          if (response.containsKey('error')) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(response['error']),
                              ),
                            );
                          } else {
                            Navigator.pushReplacementNamed(
                                context, '/tarjetas');
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(response['msg']),
                              ),
                            );
                          }
                        } else {
                          navigator.pop();
                        }
                        /* TarjetaForm.formKey.currentState!.reset(); */
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              icon: const Icon(
                Icons.save,
                color: Colors.amber,
              ), // Icono de guardar tarjeta de crédito
              label: const Text('Guardar',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
