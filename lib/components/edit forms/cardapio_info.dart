import 'dart:io';

import 'package:flutter/material.dart';
import 'package:appnutricao/db/cardapio_database.dart' as db_cardapio;
import 'package:appnutricao/db/alimentos_database.dart' as db_alimentos;
import '../../themes/theme.dart';

class CardapioInfo extends StatefulWidget {
  const CardapioInfo({super.key, required this.idRecord});
  final int idRecord;

  @override
  State<CardapioInfo> createState() => _CardapioInfoState();
}

bool isLoading = true;

class _CardapioInfoState extends State<CardapioInfo> {
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getItem();
  }

  late Map<String, dynamic> cardapio;
  late List<Widget> alimentosList = [];
  getItem() async {
    var dataCardapio =
        await db_cardapio.SQLHelperCard.getItemByID(widget.idRecord);
    setState(() {
      cardapio = dataCardapio[0];
    });
    getAlimentos();
  }

  getAlimentos() async {
    List<dynamic> list = cardapio.values.toList();
    list.removeAt(0);
    list.removeAt(0);
    for (var index in list) {
      var dataAlimentos =
          await db_alimentos.SQLHelperAlimentos.getItemByID(index);
      var alimentoAnalise = dataAlimentos[0];
      Image foto = Image.file(
        File(alimentoAnalise['fotoBytes']),
        fit: BoxFit.cover,
      );
      var cardAlimento = Card(
        margin: const EdgeInsets.all(5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 100,
                      maxWidth: 100,
                      minHeight: 100,
                      minWidth: 100),
                  child: ClipOval(child: foto)),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      alimentoAnalise['nome'],
                      style: myTextThemes.textTheme.labelLarge,
                    ),
                    Text(alimentoAnalise['tipo'],
                        style: myTextThemes.textTheme.labelSmall)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      alimentosList.add(cardAlimento);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: Card(
                child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Carregando'),
          )))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: colorsTwo.colorScheme.secondary,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Cardápio: ${cardapio['name']}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              // Cards Almoço
              Card(
                color: colorsOne.colorScheme.primary,
                elevation: 5,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Café da Manhã',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              alimentosList[0],
              alimentosList[1],
              alimentosList[2],
              Card(
                color: colorsOne.colorScheme.primary,
                elevation: 5,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Almoço',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              alimentosList[3],
              alimentosList[4],
              alimentosList[5],
              alimentosList[6],
              alimentosList[7],
              Card(
                color: colorsOne.colorScheme.primary,
                elevation: 5,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Janta',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              alimentosList[8],
              alimentosList[9],
              alimentosList[10],
              alimentosList[11],
            ],
          );
  }
}
