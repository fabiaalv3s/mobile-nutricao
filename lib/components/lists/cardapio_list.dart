import 'package:appnutricao/components/edit%20forms/cardapio_info.dart';
import 'package:appnutricao/db/cardapio_database.dart';
import 'package:appnutricao/screens/edit_records.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';

class CardapioList extends StatefulWidget {
  const CardapioList({super.key});
  @override
  State<CardapioList> createState() => _CardapioListState();
}

List<dynamic> listaCardapio = [];
bool isLoading = true;

class _CardapioListState extends State<CardapioList> {
  @override
  void initState() {
    super.initState();
    refreshCardapio();
  }

  Future refreshCardapio() async {
    final data = await SQLHelperCard.getItems();
    debugPrint(data.toString());

    setState(() {
      isLoading = false;
      listaCardapio = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CARREGANDO...',
                  style: myTextThemes.textTheme.displayLarge,
                ),
              ],
            ),
          )
        : Column(
            children: [
              (listaCardapio.isEmpty)
                  ? Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 80),
                          Text(
                            'Lista vazia.\nVá para a tela de cadastros\ne cadastre novos cardápios.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                            height: (MediaQuery.of(context).size.height * 0.70),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listaCardapio.length,
                                itemBuilder: (context, index) {
                                  final exemplo = listaCardapio[index];

                                  return Card(
                                    margin: const EdgeInsets.all(5),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Nome do cardápio:'),
                                                Text(
                                                  exemplo['name'],
                                                  style: myTextThemes
                                                      .textTheme.displayLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditRecordsScreen(
                                                                  buttonPressed:
                                                                      2,
                                                                  cardapioInfo:
                                                                      CardapioInfo(
                                                                          idRecord:
                                                                              exemplo['id']),
                                                                  idRecord:
                                                                      exemplo[
                                                                          'id'],
                                                                )));
                                              },
                                              icon: const Icon(Icons.list_alt)),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
            ],
          );
  }
}
