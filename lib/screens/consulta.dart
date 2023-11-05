import 'dart:io';

import 'package:flutter/material.dart';
import '../components/lists/alimentos_list.dart' as alimentos_list;
import '../components/lists/cardapio_list.dart' as cardapio_list;
import '../components/lists/users_list.dart' as users_list;
import '../themes/theme.dart';
import 'package:appnutricao/db/alimentos_database.dart';

class ConsultaScreen extends StatefulWidget {
  const ConsultaScreen({super.key});

  @override
  State<ConsultaScreen> createState() => _ConsultaScreenState();
}

int buttonPressed = 0;

MaterialStateProperty<Color> buttonSelected(int buttonPressed, int buttonID) {
  if (buttonPressed == buttonID) {
    return MaterialStateProperty.all(colorsOne.colorScheme.secondary);
  }

  return MaterialStateProperty.all(colorsTwo.colorScheme.secondary);
}

List<Widget> listasDisponiveis = const [
  users_list.UsersList(),
  alimentos_list.AlimentosList(),
  cardapio_list.CardapioList(),
  Text('Carregando...')
];

List<String> listaOptionsSearch = [
  'Nome do Usuário',
  'Nome do Alimento',
  'Cardápio',
  'Carregando'
];

String searchName = '';
int searcher = 0;

class _ConsultaScreenState extends State<ConsultaScreen> {
  Future searchAlimentosName(String name) async {
    setState(() => alimentos_list.isLoading = true);
    final data = await SQLHelperAlimentos.getItemsByName(name);
    setState(() {
      alimentos_list.isLoading = false;
      alimentos_list.listaAlimentos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: colorsTwo.colorScheme.secondary,
          title: const Text('Consulta', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                buttonPressed = 0;
                                searchName = '';
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: buttonSelected(buttonPressed, 0),
                            ),
                            child: const Text('Usuário'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  buttonPressed = 1;
                                  searchName = '';
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      buttonSelected(buttonPressed, 1)),
                              child: const Text('Alimento')),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  buttonPressed = 2;
                                  searchName = '';
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      buttonSelected(buttonPressed, 2)),
                              child: const Text('Cardápio')),
                        ],
                      ),
                      if (!isKeyboard) listasDisponiveis[buttonPressed]
                    ],
                  )),
            ),
          ),
        ]),
        backgroundColor: colorsOne.colorScheme.primary,
        floatingActionButton: (buttonPressed != 2)
            ? SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Container(
                    color: colorsTwo.colorScheme.secondary,
                    child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              context: context,
                              builder: ((context) {
                                return const ModalSearcher();
                              })).then((value) async {
                            await searchAlimentosName(searchName);
                            sleep(const Duration(milliseconds: 1000));

                            setState(() {
                              buttonPressed = searcher;
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        )),
                  ),
                ),
              )
            : null);
  }
}

class ModalSearcher extends StatefulWidget {
  const ModalSearcher({super.key});

  @override
  State<ModalSearcher> createState() => _ModalSearcherState();
}

class _ModalSearcherState extends State<ModalSearcher> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorsOne.colorScheme.primary,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: SizedBox(
                height: 60,
                child: Center(
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintText: listaOptionsSearch[buttonPressed],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        searchName = '';
                        if (buttonPressed == 0) searcher = 0;
                        if (buttonPressed == 1) searcher = 1;
                        buttonPressed = 3;
                        alimentos_list.isLoading = true;
                        users_list.isLoading = true;
                      });
                      debugPrint(searchName);
                      sleep(const Duration(milliseconds: 500));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: buttonsTheme.elevatedButtonTheme.style,
                    child: const Text('Limpar Filtro')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (buttonPressed == 0) searcher = 0;
                        if (buttonPressed == 1) searcher = 1;
                        buttonPressed = 3;
                        searchName = _nomeController.text;
                        alimentos_list.isLoading = true;
                        users_list.isLoading = true;
                      });
                      sleep(const Duration(milliseconds: 500));
                      debugPrint(searchName);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: buttonsTheme.elevatedButtonTheme.style,
                    child: const Text('Pesquisar')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
