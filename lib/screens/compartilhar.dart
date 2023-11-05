import 'package:appnutricao/components/sharelists/share_alimento_list.dart';
import 'package:appnutricao/components/sharelists/share_cardapio_list.dart';
import 'package:flutter/material.dart';
import '../themes/theme.dart';

class CompartilharScreen extends StatefulWidget {
  const CompartilharScreen({super.key});

  @override
  State<CompartilharScreen> createState() => _CompartilharScreenState();
}

List<Widget> shareForms = const [
  ShareAlimentosList(),
  ShareCardapioList()
];

int buttonPressed = 0;

MaterialStateProperty<Color> buttonSelected(int buttonPressed, int buttonID) {
  if (buttonPressed == buttonID) {
    return MaterialStateProperty.all(colorsOne.colorScheme.secondary);
  }

  return MaterialStateProperty.all(colorsTwo.colorScheme.secondary);
}

class _CompartilharScreenState extends State<CompartilharScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: colorsTwo.colorScheme.secondary,
          title: const Text('Compartilhar', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Card(
              margin:  const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'O que deseja Compartilhar?',
                        textAlign: TextAlign.center,
                        style: myTextThemes.textTheme.headlineSmall,
                      ),
                    ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                buttonPressed = 0;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: buttonSelected(buttonPressed, 0),
                            ),
                            child: const Text('Alimento'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  buttonPressed = 1;
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      buttonSelected(buttonPressed, 1)),
                              child: const Text('Cardápio')),
                        ],
                      ),
                    shareForms.elementAt(buttonPressed)
                    ],
                  )),
            ),
          ),
        ]),
        backgroundColor: colorsOne.colorScheme.primary);
  }
}
