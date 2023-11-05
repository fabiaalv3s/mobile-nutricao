import 'package:flutter/material.dart';

import '../themes/theme.dart';

class CreditosScreen extends StatelessWidget {
  const CreditosScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: colorsTwo.colorScheme.secondary,
        title: const Text('Créditos', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: const Card(
          elevation: 7,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Text(
                  "Criadores / Desenvolvedores",
                  style: TextStyle(
                  color: Color.fromRGBO(13, 25, 43, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                 Text(
                    "Fábia Kaylani Pereira Alves\nIsabelle Evelyn Borsatti\nGuilherme Anderson Salgado de Oliveira\nMariana Aparecida de Assis Souza",
                    style: TextStyle(color: Color.fromRGBO(13, 25, 43, 1), fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: colorsOne.colorScheme.primary,
    );
  }

}
